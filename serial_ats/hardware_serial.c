#define __AVR_LIBC_DEPRECATED_ENABLE__

/*
  hardware_serial.c - Hardware serial library for Wiring
  Copyright (c) 2006 Nicholas Zambetti.  All right reserved.

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with this library; if not, write to the Free Software
  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  
  Modified 23 November 2006 by David A. Mellis
  Modified 28 September 2010 by Mark Sproul
  Modified 14 August 2012 by Alarus
*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <inttypes.h>
#include "Arduino.h"

// this next line disables the entire HardwareSerial.cpp, 
// this is so I can support Attiny series and any other chip without a uart
#if defined(UBRRH) || defined(UBRR0H) || defined(UBRR1H) || defined(UBRR2H) || defined(UBRR3H)

#include "hardware_serial.h"

/*
 * on ATmega8, the uart and its bits are not numbered, so there is no "TXC0"
 * definition.
 */
#if !defined(TXC0)
#if defined(TXC)
#define TXC0 TXC
#elif defined(TXC1)
// Some devices have uart1 but no uart0
#define TXC0 TXC1
#else
#error TXC0 not definable in HardwareSerial.h
#endif
#endif

// Ring buffer //////////////////////////////////////////////////////////////

// Define constants and variables for buffering incoming serial data.  We're
// using a ring buffer (I think), in which head is the index of the location
// to which to write the next incoming character and tail is the index of the
// location from which to read.
#if (RAMEND < 1000)
  #define SERIAL_BUFFER_SIZE 16
#else
  #define SERIAL_BUFFER_SIZE 64
#endif

struct ring_buffer
{
  unsigned char buffer[SERIAL_BUFFER_SIZE];
  volatile unsigned int head;
  volatile unsigned int tail;
};

#if defined(USBCON) || defined(UBRRH) || defined(UBRR0H)
struct ring_buffer rx_buffer = { { 0 }, 0, 0};
struct ring_buffer tx_buffer = { { 0 }, 0, 0};
#endif

void ringbuf_insert_nowait(unsigned char c, struct ring_buffer *buffer)
{
  int i = (unsigned int)(buffer->head + 1) % SERIAL_BUFFER_SIZE;

  // if we should be storing the received character into the location
  // just before the tail (meaning that the head would advance to the
  // current location of the tail), we're about to overflow the buffer
  // and so we don't write the character or advance the head.
  if (i != buffer->tail) {
    buffer->buffer[buffer->head] = c;
    buffer->head = i;
  }
}

void ringbuf_insert_wait(unsigned char c, struct ring_buffer *buffer)
{
  int i = (buffer->head + 1) % SERIAL_BUFFER_SIZE;

  // If the output buffer is full, there's nothing for it other than to 
  // wait for the interrupt handler to empty it a bit
  // ???: return 0 here instead?
  while (i == buffer->tail)
    ;

  buffer->buffer[buffer->head] = c;
  buffer->head = i;
}

bool ringbuf_is_empty(struct ring_buffer *buffer)
{
  return (buffer->head == buffer->tail);
}

unsigned int ringbuf_get_size(struct ring_buffer *buffer)
{
  return (unsigned int)(SERIAL_BUFFER_SIZE + buffer->head - buffer->tail) % SERIAL_BUFFER_SIZE;
}

unsigned char ringbuf_peek(struct ring_buffer *buffer)
{
  return buffer->buffer[buffer->tail];;
}

unsigned char ringbuf_remove(struct ring_buffer *buffer)
{
  unsigned char c = ringbuf_peek(buffer);
  buffer->tail = (buffer->tail + 1) % SERIAL_BUFFER_SIZE;
  return c;
}

void ringbuf_clear(struct ring_buffer *buffer)
{
  buffer->head = buffer->tail;
}

#if !defined(USART0_RX_vect) && defined(USART1_RX_vect)
// do nothing - on the 32u4 the first USART is USART1
#else
#if !defined(USART_RX_vect) && !defined(USART0_RX_vect) && \
    !defined(USART_RXC_vect)
  #error "Don't know what the Data Received vector is called for the first UART"
#else
  void serialEvent() __attribute__((weak));
  void serialEvent() {}
  #define serialEvent_implemented
#if defined(USART_RX_vect)
  ISR(USART_RX_vect)
#elif defined(USART0_RX_vect)
  ISR(USART0_RX_vect)
#elif defined(USART_RXC_vect)
  ISR(USART_RXC_vect) // ATmega8
#endif
  {
  #if defined(UDR0)
    if (bit_is_clear(UCSR0A, UPE0)) {
      unsigned char c = UDR0;
      ringbuf_insert_nowait(c, &rx_buffer);
    } else {
      unsigned char c = UDR0;
    };
  #elif defined(UDR)
    if (bit_is_clear(UCSRA, PE)) {
      unsigned char c = UDR;
      ringbuf_insert_nowait(c, &rx_buffer);
    } else {
      unsigned char c = UDR;
    };
  #else
    #error UDR not defined
  #endif
  }
#endif
#endif

#if !defined(USART0_UDRE_vect) && defined(USART1_UDRE_vect)
// do nothing - on the 32u4 the first USART is USART1
#else
#if !defined(UART0_UDRE_vect) && !defined(UART_UDRE_vect) && !defined(USART0_UDRE_vect) && !defined(USART_UDRE_vect)
  #error "Don't know what the Data Register Empty vector is called for the first UART"
#else
#if defined(UART0_UDRE_vect)
ISR(UART0_UDRE_vect)
#elif defined(UART_UDRE_vect)
ISR(UART_UDRE_vect)
#elif defined(USART0_UDRE_vect)
ISR(USART0_UDRE_vect)
#elif defined(USART_UDRE_vect)
ISR(USART_UDRE_vect)
#endif
{
  if (ringbuf_is_empty(&tx_buffer)) {
	// Buffer empty, so disable interrupts
#if defined(UCSR0B)
    cbi(UCSR0B, UDRIE0);
#else
    cbi(UCSRB, UDRIE);
#endif
  }
  else {
    // There is more data in the output buffer. Send the next byte
    unsigned char c = ringbuf_remove(&tx_buffer);
  #if defined(UDR0)
    UDR0 = c;
  #elif defined(UDR)
    UDR = c;
  #else
    #error UDR not defined
  #endif
  }
}
#endif
#endif
#endif


// Public Methods //////////////////////////////////////////////////////////////

void hardware_serial_begin(struct hardware_serial* hserial, unsigned long baud)
{
  uint16_t baud_setting;
  bool use_u2x = true;

#if F_CPU == 16000000UL
  // hardcoded exception for compatibility with the bootloader shipped
  // with the Duemilanove and previous boards and the firmware on the 8U2
  // on the Uno and Mega 2560.
  if (baud == 57600) {
    use_u2x = false;
  }
#endif

try_again:
  
  if (use_u2x) {
    *(hserial->_ucsra) = 1 << hserial->_u2x;
    baud_setting = (F_CPU / 4 / baud - 1) / 2;
  } else {
    *(hserial->_ucsra) = 0;
    baud_setting = (F_CPU / 8 / baud - 1) / 2;
  }
  
  if ((baud_setting > 4095) && use_u2x)
  {
    use_u2x = false;
    goto try_again;
  }

  // assign the baud_setting, a.k.a. ubbr (USART Baud Rate Register)
  *(hserial->_ubrrh) = baud_setting >> 8;
  *(hserial->_ubrrl) = baud_setting;

  hserial->transmitting = false;

  sbi(*(hserial->_ucsrb), hserial->_rxen);
  sbi(*(hserial->_ucsrb), hserial->_txen);
  sbi(*(hserial->_ucsrb), hserial->_rxcie);
  cbi(*(hserial->_ucsrb), hserial->_udrie);
}

void hardware_serial_end(struct hardware_serial* hserial)
{
  // wait for transmission of outgoing data
  while (!ringbuf_is_empty(hserial->_tx_buffer))
    ;

  cbi(*(hserial->_ucsrb), hserial->_rxen);
  cbi(*(hserial->_ucsrb), hserial->_txen);
  cbi(*(hserial->_ucsrb), hserial->_rxcie);  
  cbi(*(hserial->_ucsrb), hserial->_udrie);
  
  // clear any received data
  ringbuf_clear(hserial->_rx_buffer);
}

int hardware_serial_available(struct hardware_serial* hserial)
{
  return ringbuf_get_size(hserial->_rx_buffer);
}

int hardware_serial_peek(struct hardware_serial* hserial)
{
  if (ringbuf_is_empty(hserial->_rx_buffer)) {
    return -1;
  }
  return ringbuf_peek(hserial->_rx_buffer);
}

void hardware_serial_flush(struct hardware_serial* hserial)
{
  // UDR is kept full while the buffer is not empty, so TXC triggers when EMPTY && SENT
  while (hserial->transmitting && ! (*(hserial->_ucsra) & _BV(TXC0)));
  hserial->transmitting = false;
}

// Preinstantiate Objects //////////////////////////////////////////////////////

#if defined(UBRRH) && defined(UBRRL)
struct hardware_serial Serial = {&rx_buffer, &tx_buffer, &UBRRH, &UBRRL, &UCSRA, &UCSRB, &UCSRC, &UDR, RXEN, TXEN, RXCIE, UDRIE, U2X};
#elif defined(UBRR0H) && defined(UBRR0L)
struct hardware_serial Serial = {&rx_buffer, &tx_buffer, &UBRR0H, &UBRR0L, &UCSR0A, &UCSR0B, &UCSR0C, &UDR0, RXEN0, TXEN0, RXCIE0, UDRIE0, U2X0};
#elif defined(USBCON)
  // do nothing - Serial object and buffers are initialized in CDC code
#else
  #error no serial port defined  (port 0)
#endif
