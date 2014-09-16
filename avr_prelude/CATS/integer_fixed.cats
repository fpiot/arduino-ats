/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
**
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
**
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*) */

/* ****** ****** */

/*
** Source:
** $PATSHOME/prelude/CATS/CODEGEN/integer_fixed.atxt
** Time of generation: Mon Jun 30 18:24:16 2014
*/

/* ****** ****** */

/*
(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: January, 2013 *)
*/

/* ****** ****** */

#ifndef ATSLIB_PRELUDE_INTEGER_FIXED_CATS
#define ATSLIB_PRELUDE_INTEGER_FIXED_CATS

/* ****** ****** */

#include <stdint.h>

/* ****** ****** */

typedef int8_t atstype_int8 ;
typedef int16_t atstype_int16 ;
typedef int32_t atstype_int32 ;
typedef int64_t atstype_int64 ;

typedef uint8_t atstype_uint8 ;
typedef uint16_t atstype_uint16 ;
typedef uint32_t atstype_uint32 ;
typedef uint64_t atstype_uint64 ;

/* ****** ****** */

ATSinline()
atstype_int8
atspre_g0int_neg_int8
  (atstype_int8 x) { return (-x) ; }
// end of [atspre_g0int_neg_int8]
ATSinline()
atstype_int8
atspre_g0int_succ_int8
  (atstype_int8 x) { return (x + 1) ; }
// end of [atspre_g0int_succ_int8]
ATSinline()
atstype_int8
atspre_g0int_pred_int8
  (atstype_int8 x) { return (x - 1) ; }
// end of [atspre_g0int_pred_int8]
ATSinline()
atstype_int8
atspre_g0int_half_int8
  (atstype_int8 x) { return (x / 2) ; }
// end of [atspre_g0int_half_int8]
ATSinline()
atstype_int8
atspre_g0int_add_int8
  (atstype_int8 x1, atstype_int8 x2) { return (x1 + x2) ; }
// end of [atspre_g0int_add_int8]
ATSinline()
atstype_int8
atspre_g0int_sub_int8
  (atstype_int8 x1, atstype_int8 x2) { return (x1 - x2) ; }
// end of [atspre_g0int_sub_int8]
ATSinline()
atstype_int8
atspre_g0int_mul_int8
  (atstype_int8 x1, atstype_int8 x2) { return (x1 * x2) ; }
// end of [atspre_g0int_mul_int8]
ATSinline()
atstype_int8
atspre_g0int_div_int8
  (atstype_int8 x1, atstype_int8 x2) { return (x1 / x2) ; }
// end of [atspre_g0int_div_int8]
ATSinline()
atstype_int8
atspre_g0int_mod_int8
  (atstype_int8 x1, atstype_int8 x2) { return (x1 % x2) ; }
// end of [atspre_g0int_mod_int8]
ATSinline()
atstype_bool
atspre_g0int_isltz_int8 (atstype_int8 x)
{
  return (x < 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isltz_int8]
ATSinline()
atstype_bool
atspre_g0int_isltez_int8 (atstype_int8 x)
{
  return (x <= 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isltez_int8]
ATSinline()
atstype_bool
atspre_g0int_isgtz_int8 (atstype_int8 x)
{
  return (x > 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isgtz_int8]
ATSinline()
atstype_bool
atspre_g0int_isgtez_int8 (atstype_int8 x)
{
  return (x >= 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isgtez_int8]
ATSinline()
atstype_bool
atspre_g0int_iseqz_int8 (atstype_int8 x)
{
  return (x == 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_iseqz_int8]
ATSinline()
atstype_bool
atspre_g0int_isneqz_int8 (atstype_int8 x)
{
  return (x != 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isneqz_int8]
ATSinline()
atstype_bool
atspre_g0int_lt_int8
(
  atstype_int8 x1, atstype_int8 x2
) {
  return (x1 < x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_lt_int8]
ATSinline()
atstype_bool
atspre_g0int_lte_int8
(
  atstype_int8 x1, atstype_int8 x2
) {
  return (x1 <= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_lte_int8]
ATSinline()
atstype_bool
atspre_g0int_gt_int8
(
  atstype_int8 x1, atstype_int8 x2
) {
  return (x1 > x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_gt_int8]
ATSinline()
atstype_bool
atspre_g0int_gte_int8
(
  atstype_int8 x1, atstype_int8 x2
) {
  return (x1 >= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_gte_int8]
ATSinline()
atstype_bool
atspre_g0int_eq_int8
(
  atstype_int8 x1, atstype_int8 x2
) {
  return (x1 == x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_eq_int8]
ATSinline()
atstype_bool
atspre_g0int_neq_int8
(
  atstype_int8 x1, atstype_int8 x2
) {
  return (x1 != x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_neq_int8]
ATSinline()
atstype_int16
atspre_g0int_neg_int16
  (atstype_int16 x) { return (-x) ; }
// end of [atspre_g0int_neg_int16]
ATSinline()
atstype_int16
atspre_g0int_succ_int16
  (atstype_int16 x) { return (x + 1) ; }
// end of [atspre_g0int_succ_int16]
ATSinline()
atstype_int16
atspre_g0int_pred_int16
  (atstype_int16 x) { return (x - 1) ; }
// end of [atspre_g0int_pred_int16]
ATSinline()
atstype_int16
atspre_g0int_half_int16
  (atstype_int16 x) { return (x / 2) ; }
// end of [atspre_g0int_half_int16]
ATSinline()
atstype_int16
atspre_g0int_add_int16
  (atstype_int16 x1, atstype_int16 x2) { return (x1 + x2) ; }
// end of [atspre_g0int_add_int16]
ATSinline()
atstype_int16
atspre_g0int_sub_int16
  (atstype_int16 x1, atstype_int16 x2) { return (x1 - x2) ; }
// end of [atspre_g0int_sub_int16]
ATSinline()
atstype_int16
atspre_g0int_mul_int16
  (atstype_int16 x1, atstype_int16 x2) { return (x1 * x2) ; }
// end of [atspre_g0int_mul_int16]
ATSinline()
atstype_int16
atspre_g0int_div_int16
  (atstype_int16 x1, atstype_int16 x2) { return (x1 / x2) ; }
// end of [atspre_g0int_div_int16]
ATSinline()
atstype_int16
atspre_g0int_mod_int16
  (atstype_int16 x1, atstype_int16 x2) { return (x1 % x2) ; }
// end of [atspre_g0int_mod_int16]
ATSinline()
atstype_bool
atspre_g0int_isltz_int16 (atstype_int16 x)
{
  return (x < 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isltz_int16]
ATSinline()
atstype_bool
atspre_g0int_isltez_int16 (atstype_int16 x)
{
  return (x <= 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isltez_int16]
ATSinline()
atstype_bool
atspre_g0int_isgtz_int16 (atstype_int16 x)
{
  return (x > 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isgtz_int16]
ATSinline()
atstype_bool
atspre_g0int_isgtez_int16 (atstype_int16 x)
{
  return (x >= 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isgtez_int16]
ATSinline()
atstype_bool
atspre_g0int_iseqz_int16 (atstype_int16 x)
{
  return (x == 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_iseqz_int16]
ATSinline()
atstype_bool
atspre_g0int_isneqz_int16 (atstype_int16 x)
{
  return (x != 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isneqz_int16]
ATSinline()
atstype_bool
atspre_g0int_lt_int16
(
  atstype_int16 x1, atstype_int16 x2
) {
  return (x1 < x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_lt_int16]
ATSinline()
atstype_bool
atspre_g0int_lte_int16
(
  atstype_int16 x1, atstype_int16 x2
) {
  return (x1 <= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_lte_int16]
ATSinline()
atstype_bool
atspre_g0int_gt_int16
(
  atstype_int16 x1, atstype_int16 x2
) {
  return (x1 > x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_gt_int16]
ATSinline()
atstype_bool
atspre_g0int_gte_int16
(
  atstype_int16 x1, atstype_int16 x2
) {
  return (x1 >= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_gte_int16]
ATSinline()
atstype_bool
atspre_g0int_eq_int16
(
  atstype_int16 x1, atstype_int16 x2
) {
  return (x1 == x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_eq_int16]
ATSinline()
atstype_bool
atspre_g0int_neq_int16
(
  atstype_int16 x1, atstype_int16 x2
) {
  return (x1 != x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_neq_int16]
ATSinline()
atstype_int32
atspre_g0int_neg_int32
  (atstype_int32 x) { return (-x) ; }
// end of [atspre_g0int_neg_int32]
ATSinline()
atstype_int32
atspre_g0int_succ_int32
  (atstype_int32 x) { return (x + 1) ; }
// end of [atspre_g0int_succ_int32]
ATSinline()
atstype_int32
atspre_g0int_pred_int32
  (atstype_int32 x) { return (x - 1) ; }
// end of [atspre_g0int_pred_int32]
ATSinline()
atstype_int32
atspre_g0int_half_int32
  (atstype_int32 x) { return (x / 2) ; }
// end of [atspre_g0int_half_int32]
ATSinline()
atstype_int32
atspre_g0int_add_int32
  (atstype_int32 x1, atstype_int32 x2) { return (x1 + x2) ; }
// end of [atspre_g0int_add_int32]
ATSinline()
atstype_int32
atspre_g0int_sub_int32
  (atstype_int32 x1, atstype_int32 x2) { return (x1 - x2) ; }
// end of [atspre_g0int_sub_int32]
ATSinline()
atstype_int32
atspre_g0int_mul_int32
  (atstype_int32 x1, atstype_int32 x2) { return (x1 * x2) ; }
// end of [atspre_g0int_mul_int32]
ATSinline()
atstype_int32
atspre_g0int_div_int32
  (atstype_int32 x1, atstype_int32 x2) { return (x1 / x2) ; }
// end of [atspre_g0int_div_int32]
ATSinline()
atstype_int32
atspre_g0int_mod_int32
  (atstype_int32 x1, atstype_int32 x2) { return (x1 % x2) ; }
// end of [atspre_g0int_mod_int32]
ATSinline()
atstype_bool
atspre_g0int_isltz_int32 (atstype_int32 x)
{
  return (x < 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isltz_int32]
ATSinline()
atstype_bool
atspre_g0int_isltez_int32 (atstype_int32 x)
{
  return (x <= 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isltez_int32]
ATSinline()
atstype_bool
atspre_g0int_isgtz_int32 (atstype_int32 x)
{
  return (x > 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isgtz_int32]
ATSinline()
atstype_bool
atspre_g0int_isgtez_int32 (atstype_int32 x)
{
  return (x >= 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isgtez_int32]
ATSinline()
atstype_bool
atspre_g0int_iseqz_int32 (atstype_int32 x)
{
  return (x == 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_iseqz_int32]
ATSinline()
atstype_bool
atspre_g0int_isneqz_int32 (atstype_int32 x)
{
  return (x != 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isneqz_int32]
ATSinline()
atstype_bool
atspre_g0int_lt_int32
(
  atstype_int32 x1, atstype_int32 x2
) {
  return (x1 < x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_lt_int32]
ATSinline()
atstype_bool
atspre_g0int_lte_int32
(
  atstype_int32 x1, atstype_int32 x2
) {
  return (x1 <= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_lte_int32]
ATSinline()
atstype_bool
atspre_g0int_gt_int32
(
  atstype_int32 x1, atstype_int32 x2
) {
  return (x1 > x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_gt_int32]
ATSinline()
atstype_bool
atspre_g0int_gte_int32
(
  atstype_int32 x1, atstype_int32 x2
) {
  return (x1 >= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_gte_int32]
ATSinline()
atstype_bool
atspre_g0int_eq_int32
(
  atstype_int32 x1, atstype_int32 x2
) {
  return (x1 == x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_eq_int32]
ATSinline()
atstype_bool
atspre_g0int_neq_int32
(
  atstype_int32 x1, atstype_int32 x2
) {
  return (x1 != x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_neq_int32]
ATSinline()
atstype_int64
atspre_g0int_neg_int64
  (atstype_int64 x) { return (-x) ; }
// end of [atspre_g0int_neg_int64]
ATSinline()
atstype_int64
atspre_g0int_succ_int64
  (atstype_int64 x) { return (x + 1) ; }
// end of [atspre_g0int_succ_int64]
ATSinline()
atstype_int64
atspre_g0int_pred_int64
  (atstype_int64 x) { return (x - 1) ; }
// end of [atspre_g0int_pred_int64]
ATSinline()
atstype_int64
atspre_g0int_half_int64
  (atstype_int64 x) { return (x / 2) ; }
// end of [atspre_g0int_half_int64]
ATSinline()
atstype_int64
atspre_g0int_add_int64
  (atstype_int64 x1, atstype_int64 x2) { return (x1 + x2) ; }
// end of [atspre_g0int_add_int64]
ATSinline()
atstype_int64
atspre_g0int_sub_int64
  (atstype_int64 x1, atstype_int64 x2) { return (x1 - x2) ; }
// end of [atspre_g0int_sub_int64]
ATSinline()
atstype_int64
atspre_g0int_mul_int64
  (atstype_int64 x1, atstype_int64 x2) { return (x1 * x2) ; }
// end of [atspre_g0int_mul_int64]
ATSinline()
atstype_int64
atspre_g0int_div_int64
  (atstype_int64 x1, atstype_int64 x2) { return (x1 / x2) ; }
// end of [atspre_g0int_div_int64]
ATSinline()
atstype_int64
atspre_g0int_mod_int64
  (atstype_int64 x1, atstype_int64 x2) { return (x1 % x2) ; }
// end of [atspre_g0int_mod_int64]
ATSinline()
atstype_bool
atspre_g0int_isltz_int64 (atstype_int64 x)
{
  return (x < 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isltz_int64]
ATSinline()
atstype_bool
atspre_g0int_isltez_int64 (atstype_int64 x)
{
  return (x <= 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isltez_int64]
ATSinline()
atstype_bool
atspre_g0int_isgtz_int64 (atstype_int64 x)
{
  return (x > 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isgtz_int64]
ATSinline()
atstype_bool
atspre_g0int_isgtez_int64 (atstype_int64 x)
{
  return (x >= 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isgtez_int64]
ATSinline()
atstype_bool
atspre_g0int_iseqz_int64 (atstype_int64 x)
{
  return (x == 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_iseqz_int64]
ATSinline()
atstype_bool
atspre_g0int_isneqz_int64 (atstype_int64 x)
{
  return (x != 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_isneqz_int64]
ATSinline()
atstype_bool
atspre_g0int_lt_int64
(
  atstype_int64 x1, atstype_int64 x2
) {
  return (x1 < x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_lt_int64]
ATSinline()
atstype_bool
atspre_g0int_lte_int64
(
  atstype_int64 x1, atstype_int64 x2
) {
  return (x1 <= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_lte_int64]
ATSinline()
atstype_bool
atspre_g0int_gt_int64
(
  atstype_int64 x1, atstype_int64 x2
) {
  return (x1 > x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_gt_int64]
ATSinline()
atstype_bool
atspre_g0int_gte_int64
(
  atstype_int64 x1, atstype_int64 x2
) {
  return (x1 >= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_gte_int64]
ATSinline()
atstype_bool
atspre_g0int_eq_int64
(
  atstype_int64 x1, atstype_int64 x2
) {
  return (x1 == x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_eq_int64]
ATSinline()
atstype_bool
atspre_g0int_neq_int64
(
  atstype_int64 x1, atstype_int64 x2
) {
  return (x1 != x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0int_neq_int64]
//
/* ****** ****** */

ATSinline()
atstype_uint8
atspre_g0uint_succ_uint8
  (atstype_uint8 x) { return (x + 1) ; }
// end of [atspre_g0uint_succ_uint8]
ATSinline()
atstype_uint8
atspre_g0uint_pred_uint8
  (atstype_uint8 x) { return (x - 1) ; }
// end of [atspre_g0uint_pred_uint8]
ATSinline()
atstype_uint8
atspre_g0uint_half_uint8
  (atstype_uint8 x) { return (x >> 1) ; }
// end of [atspre_g0uint_pred_uint8]
ATSinline()
atstype_uint8
atspre_g0uint_add_uint8
  (atstype_uint8 x1, atstype_uint8 x2) { return (x1 + x2) ; }
// end of [atspre_g0uint_add_uint8]
ATSinline()
atstype_uint8
atspre_g0uint_sub_uint8
  (atstype_uint8 x1, atstype_uint8 x2) { return (x1 - x2) ; }
// end of [atspre_g0uint_sub_uint8]
ATSinline()
atstype_uint8
atspre_g0uint_mul_uint8
  (atstype_uint8 x1, atstype_uint8 x2) { return (x1 * x2) ; }
// end of [atspre_g0uint_mul_uint8]
ATSinline()
atstype_uint8
atspre_g0uint_div_uint8
  (atstype_uint8 x1, atstype_uint8 x2) { return (x1 / x2) ; }
// end of [atspre_g0uint_div_uint8]
ATSinline()
atstype_uint8
atspre_g0uint_mod_uint8
  (atstype_uint8 x1, atstype_uint8 x2) { return (x1 % x2) ; }
// end of [atspre_g0uint_mod_uint8]
ATSinline()
atstype_uint8
atspre_g0uint_lsl_uint8
  (atstype_uint8 x, atstype_int n) { return (x << n) ; }
// end of [atspre_g0uint_lsl_uint8]
ATSinline()
atstype_uint8
atspre_g0uint_lsr_uint8
  (atstype_uint8 x, atstype_int n) { return (x >> n) ; }
// end of [atspre_g0uint_lsr_uint8]
ATSinline()
atstype_uint8
atspre_g0uint_lnot_uint8
  (atstype_uint8 x) { return ~(x) ; }
// end of [atspre_g0uint_lnot_uint8]
ATSinline()
atstype_uint8
atspre_g0uint_lor_uint8
  (atstype_uint8 x, atstype_uint8 y) { return (x | y) ; }
// end of [atspre_g0uint_uint8_uint8]
ATSinline()
atstype_uint8
atspre_g0uint_land_uint8
  (atstype_uint8 x, atstype_uint8 y) { return (x & y) ; }
// end of [atspre_g0uint_uint8_uint8]
ATSinline()
atstype_uint8
atspre_g0uint_lxor_uint8
  (atstype_uint8 x, atstype_uint8 y) { return (x ^ y) ; }
// end of [atspre_g0uint_uint8_uint8]
ATSinline()
atstype_bool
atspre_g0uint_isgtz_uint8 (atstype_uint8 x)
{
  return (x > 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_isgtz_uint8]
ATSinline()
atstype_bool
atspre_g0uint_iseqz_uint8 (atstype_uint8 x)
{
  return (x == 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_iseqz_uint8]
ATSinline()
atstype_bool
atspre_g0uint_isneqz_uint8 (atstype_uint8 x)
{
  return (x != 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_isneqz_uint8]
ATSinline()
atstype_bool
atspre_g0uint_lt_uint8
(
  atstype_uint8 x1, atstype_uint8 x2
) {
  return (x1 < x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_lt_uint8]
ATSinline()
atstype_bool
atspre_g0uint_lte_uint8
(
  atstype_uint8 x1, atstype_uint8 x2
) {
  return (x1 <= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_lte_uint8]
ATSinline()
atstype_bool
atspre_g0uint_gt_uint8
(
  atstype_uint8 x1, atstype_uint8 x2
) {
  return (x1 > x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_gt_uint8]
ATSinline()
atstype_bool
atspre_g0uint_gte_uint8
(
  atstype_uint8 x1, atstype_uint8 x2
) {
  return (x1 >= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_gte_uint8]
ATSinline()
atstype_bool
atspre_g0uint_eq_uint8
(
  atstype_uint8 x1, atstype_uint8 x2
) {
  return (x1 == x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_eq_uint8]
ATSinline()
atstype_bool
atspre_g0uint_neq_uint8
(
  atstype_uint8 x1, atstype_uint8 x2
) {
  return (x1 != x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_neq_uint8]
ATSinline()
atstype_uint16
atspre_g0uint_succ_uint16
  (atstype_uint16 x) { return (x + 1) ; }
// end of [atspre_g0uint_succ_uint16]
ATSinline()
atstype_uint16
atspre_g0uint_pred_uint16
  (atstype_uint16 x) { return (x - 1) ; }
// end of [atspre_g0uint_pred_uint16]
ATSinline()
atstype_uint16
atspre_g0uint_half_uint16
  (atstype_uint16 x) { return (x >> 1) ; }
// end of [atspre_g0uint_pred_uint16]
ATSinline()
atstype_uint16
atspre_g0uint_add_uint16
  (atstype_uint16 x1, atstype_uint16 x2) { return (x1 + x2) ; }
// end of [atspre_g0uint_add_uint16]
ATSinline()
atstype_uint16
atspre_g0uint_sub_uint16
  (atstype_uint16 x1, atstype_uint16 x2) { return (x1 - x2) ; }
// end of [atspre_g0uint_sub_uint16]
ATSinline()
atstype_uint16
atspre_g0uint_mul_uint16
  (atstype_uint16 x1, atstype_uint16 x2) { return (x1 * x2) ; }
// end of [atspre_g0uint_mul_uint16]
ATSinline()
atstype_uint16
atspre_g0uint_div_uint16
  (atstype_uint16 x1, atstype_uint16 x2) { return (x1 / x2) ; }
// end of [atspre_g0uint_div_uint16]
ATSinline()
atstype_uint16
atspre_g0uint_mod_uint16
  (atstype_uint16 x1, atstype_uint16 x2) { return (x1 % x2) ; }
// end of [atspre_g0uint_mod_uint16]
ATSinline()
atstype_uint16
atspre_g0uint_lsl_uint16
  (atstype_uint16 x, atstype_int n) { return (x << n) ; }
// end of [atspre_g0uint_lsl_uint16]
ATSinline()
atstype_uint16
atspre_g0uint_lsr_uint16
  (atstype_uint16 x, atstype_int n) { return (x >> n) ; }
// end of [atspre_g0uint_lsr_uint16]
ATSinline()
atstype_uint16
atspre_g0uint_lnot_uint16
  (atstype_uint16 x) { return ~(x) ; }
// end of [atspre_g0uint_lnot_uint16]
ATSinline()
atstype_uint16
atspre_g0uint_lor_uint16
  (atstype_uint16 x, atstype_uint16 y) { return (x | y) ; }
// end of [atspre_g0uint_uint16_uint16]
ATSinline()
atstype_uint16
atspre_g0uint_land_uint16
  (atstype_uint16 x, atstype_uint16 y) { return (x & y) ; }
// end of [atspre_g0uint_uint16_uint16]
ATSinline()
atstype_uint16
atspre_g0uint_lxor_uint16
  (atstype_uint16 x, atstype_uint16 y) { return (x ^ y) ; }
// end of [atspre_g0uint_uint16_uint16]
ATSinline()
atstype_bool
atspre_g0uint_isgtz_uint16 (atstype_uint16 x)
{
  return (x > 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_isgtz_uint16]
ATSinline()
atstype_bool
atspre_g0uint_iseqz_uint16 (atstype_uint16 x)
{
  return (x == 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_iseqz_uint16]
ATSinline()
atstype_bool
atspre_g0uint_isneqz_uint16 (atstype_uint16 x)
{
  return (x != 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_isneqz_uint16]
ATSinline()
atstype_bool
atspre_g0uint_lt_uint16
(
  atstype_uint16 x1, atstype_uint16 x2
) {
  return (x1 < x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_lt_uint16]
ATSinline()
atstype_bool
atspre_g0uint_lte_uint16
(
  atstype_uint16 x1, atstype_uint16 x2
) {
  return (x1 <= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_lte_uint16]
ATSinline()
atstype_bool
atspre_g0uint_gt_uint16
(
  atstype_uint16 x1, atstype_uint16 x2
) {
  return (x1 > x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_gt_uint16]
ATSinline()
atstype_bool
atspre_g0uint_gte_uint16
(
  atstype_uint16 x1, atstype_uint16 x2
) {
  return (x1 >= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_gte_uint16]
ATSinline()
atstype_bool
atspre_g0uint_eq_uint16
(
  atstype_uint16 x1, atstype_uint16 x2
) {
  return (x1 == x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_eq_uint16]
ATSinline()
atstype_bool
atspre_g0uint_neq_uint16
(
  atstype_uint16 x1, atstype_uint16 x2
) {
  return (x1 != x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_neq_uint16]
ATSinline()
atstype_uint32
atspre_g0uint_succ_uint32
  (atstype_uint32 x) { return (x + 1) ; }
// end of [atspre_g0uint_succ_uint32]
ATSinline()
atstype_uint32
atspre_g0uint_pred_uint32
  (atstype_uint32 x) { return (x - 1) ; }
// end of [atspre_g0uint_pred_uint32]
ATSinline()
atstype_uint32
atspre_g0uint_half_uint32
  (atstype_uint32 x) { return (x >> 1) ; }
// end of [atspre_g0uint_pred_uint32]
ATSinline()
atstype_uint32
atspre_g0uint_add_uint32
  (atstype_uint32 x1, atstype_uint32 x2) { return (x1 + x2) ; }
// end of [atspre_g0uint_add_uint32]
ATSinline()
atstype_uint32
atspre_g0uint_sub_uint32
  (atstype_uint32 x1, atstype_uint32 x2) { return (x1 - x2) ; }
// end of [atspre_g0uint_sub_uint32]
ATSinline()
atstype_uint32
atspre_g0uint_mul_uint32
  (atstype_uint32 x1, atstype_uint32 x2) { return (x1 * x2) ; }
// end of [atspre_g0uint_mul_uint32]
ATSinline()
atstype_uint32
atspre_g0uint_div_uint32
  (atstype_uint32 x1, atstype_uint32 x2) { return (x1 / x2) ; }
// end of [atspre_g0uint_div_uint32]
ATSinline()
atstype_uint32
atspre_g0uint_mod_uint32
  (atstype_uint32 x1, atstype_uint32 x2) { return (x1 % x2) ; }
// end of [atspre_g0uint_mod_uint32]
ATSinline()
atstype_uint32
atspre_g0uint_lsl_uint32
  (atstype_uint32 x, atstype_int n) { return (x << n) ; }
// end of [atspre_g0uint_lsl_uint32]
ATSinline()
atstype_uint32
atspre_g0uint_lsr_uint32
  (atstype_uint32 x, atstype_int n) { return (x >> n) ; }
// end of [atspre_g0uint_lsr_uint32]
ATSinline()
atstype_uint32
atspre_g0uint_lnot_uint32
  (atstype_uint32 x) { return ~(x) ; }
// end of [atspre_g0uint_lnot_uint32]
ATSinline()
atstype_uint32
atspre_g0uint_lor_uint32
  (atstype_uint32 x, atstype_uint32 y) { return (x | y) ; }
// end of [atspre_g0uint_uint32_uint32]
ATSinline()
atstype_uint32
atspre_g0uint_land_uint32
  (atstype_uint32 x, atstype_uint32 y) { return (x & y) ; }
// end of [atspre_g0uint_uint32_uint32]
ATSinline()
atstype_uint32
atspre_g0uint_lxor_uint32
  (atstype_uint32 x, atstype_uint32 y) { return (x ^ y) ; }
// end of [atspre_g0uint_uint32_uint32]
ATSinline()
atstype_bool
atspre_g0uint_isgtz_uint32 (atstype_uint32 x)
{
  return (x > 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_isgtz_uint32]
ATSinline()
atstype_bool
atspre_g0uint_iseqz_uint32 (atstype_uint32 x)
{
  return (x == 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_iseqz_uint32]
ATSinline()
atstype_bool
atspre_g0uint_isneqz_uint32 (atstype_uint32 x)
{
  return (x != 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_isneqz_uint32]
ATSinline()
atstype_bool
atspre_g0uint_lt_uint32
(
  atstype_uint32 x1, atstype_uint32 x2
) {
  return (x1 < x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_lt_uint32]
ATSinline()
atstype_bool
atspre_g0uint_lte_uint32
(
  atstype_uint32 x1, atstype_uint32 x2
) {
  return (x1 <= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_lte_uint32]
ATSinline()
atstype_bool
atspre_g0uint_gt_uint32
(
  atstype_uint32 x1, atstype_uint32 x2
) {
  return (x1 > x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_gt_uint32]
ATSinline()
atstype_bool
atspre_g0uint_gte_uint32
(
  atstype_uint32 x1, atstype_uint32 x2
) {
  return (x1 >= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_gte_uint32]
ATSinline()
atstype_bool
atspre_g0uint_eq_uint32
(
  atstype_uint32 x1, atstype_uint32 x2
) {
  return (x1 == x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_eq_uint32]
ATSinline()
atstype_bool
atspre_g0uint_neq_uint32
(
  atstype_uint32 x1, atstype_uint32 x2
) {
  return (x1 != x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_neq_uint32]
ATSinline()
atstype_uint64
atspre_g0uint_succ_uint64
  (atstype_uint64 x) { return (x + 1) ; }
// end of [atspre_g0uint_succ_uint64]
ATSinline()
atstype_uint64
atspre_g0uint_pred_uint64
  (atstype_uint64 x) { return (x - 1) ; }
// end of [atspre_g0uint_pred_uint64]
ATSinline()
atstype_uint64
atspre_g0uint_half_uint64
  (atstype_uint64 x) { return (x >> 1) ; }
// end of [atspre_g0uint_pred_uint64]
ATSinline()
atstype_uint64
atspre_g0uint_add_uint64
  (atstype_uint64 x1, atstype_uint64 x2) { return (x1 + x2) ; }
// end of [atspre_g0uint_add_uint64]
ATSinline()
atstype_uint64
atspre_g0uint_sub_uint64
  (atstype_uint64 x1, atstype_uint64 x2) { return (x1 - x2) ; }
// end of [atspre_g0uint_sub_uint64]
ATSinline()
atstype_uint64
atspre_g0uint_mul_uint64
  (atstype_uint64 x1, atstype_uint64 x2) { return (x1 * x2) ; }
// end of [atspre_g0uint_mul_uint64]
ATSinline()
atstype_uint64
atspre_g0uint_div_uint64
  (atstype_uint64 x1, atstype_uint64 x2) { return (x1 / x2) ; }
// end of [atspre_g0uint_div_uint64]
ATSinline()
atstype_uint64
atspre_g0uint_mod_uint64
  (atstype_uint64 x1, atstype_uint64 x2) { return (x1 % x2) ; }
// end of [atspre_g0uint_mod_uint64]
ATSinline()
atstype_uint64
atspre_g0uint_lsl_uint64
  (atstype_uint64 x, atstype_int n) { return (x << n) ; }
// end of [atspre_g0uint_lsl_uint64]
ATSinline()
atstype_uint64
atspre_g0uint_lsr_uint64
  (atstype_uint64 x, atstype_int n) { return (x >> n) ; }
// end of [atspre_g0uint_lsr_uint64]
ATSinline()
atstype_uint64
atspre_g0uint_lnot_uint64
  (atstype_uint64 x) { return ~(x) ; }
// end of [atspre_g0uint_lnot_uint64]
ATSinline()
atstype_uint64
atspre_g0uint_lor_uint64
  (atstype_uint64 x, atstype_uint64 y) { return (x | y) ; }
// end of [atspre_g0uint_uint64_uint64]
ATSinline()
atstype_uint64
atspre_g0uint_land_uint64
  (atstype_uint64 x, atstype_uint64 y) { return (x & y) ; }
// end of [atspre_g0uint_uint64_uint64]
ATSinline()
atstype_uint64
atspre_g0uint_lxor_uint64
  (atstype_uint64 x, atstype_uint64 y) { return (x ^ y) ; }
// end of [atspre_g0uint_uint64_uint64]
ATSinline()
atstype_bool
atspre_g0uint_isgtz_uint64 (atstype_uint64 x)
{
  return (x > 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_isgtz_uint64]
ATSinline()
atstype_bool
atspre_g0uint_iseqz_uint64 (atstype_uint64 x)
{
  return (x == 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_iseqz_uint64]
ATSinline()
atstype_bool
atspre_g0uint_isneqz_uint64 (atstype_uint64 x)
{
  return (x != 0 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_isneqz_uint64]
ATSinline()
atstype_bool
atspre_g0uint_lt_uint64
(
  atstype_uint64 x1, atstype_uint64 x2
) {
  return (x1 < x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_lt_uint64]
ATSinline()
atstype_bool
atspre_g0uint_lte_uint64
(
  atstype_uint64 x1, atstype_uint64 x2
) {
  return (x1 <= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_lte_uint64]
ATSinline()
atstype_bool
atspre_g0uint_gt_uint64
(
  atstype_uint64 x1, atstype_uint64 x2
) {
  return (x1 > x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_gt_uint64]
ATSinline()
atstype_bool
atspre_g0uint_gte_uint64
(
  atstype_uint64 x1, atstype_uint64 x2
) {
  return (x1 >= x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_gte_uint64]
ATSinline()
atstype_bool
atspre_g0uint_eq_uint64
(
  atstype_uint64 x1, atstype_uint64 x2
) {
  return (x1 == x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_eq_uint64]
ATSinline()
atstype_bool
atspre_g0uint_neq_uint64
(
  atstype_uint64 x1, atstype_uint64 x2
) {
  return (x1 != x2 ? atsbool_true : atsbool_false) ;
} // end of [atspre_g0uint_neq_uint64]
//
/* ****** ****** */

#endif // ifndef ATSLIB_PRELUDE_INTEGER_FIXED_CATS

/* ****** ****** */

/* end of [integer_fixed.cats] */

