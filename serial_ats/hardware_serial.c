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

#include "hardware_serial.h"

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

// Preinstantiate Objects //////////////////////////////////////////////////////

struct hardware_serial Serial;
