(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
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
*)

(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: September, 2011 *)

(* ****** ****** *)

(*
** HX: a string0 is a null-terminated arrayref of characters
*)

(* ****** ****** *)
//
fun{env:vt0p}
string0_foreach$cont (c: char, env: &env): bool
fun{env:vt0p}
string0_foreach$fwork (c: char, env: &(env) >> _): void
//
fun{
} string0_foreach (str: string): size_t
fun{
env:vt0p
} string0_foreach_env
  (str: string, env: &(env) >> _): size_t
// end of [string_foreach_env]
//
(* ****** ****** *)
//
fun{env:vt0p}
string0_rforeach$cont (c: char, env: &env): bool
fun{env:vt0p}
string0_rforeach$fwork (c: char, env: &(env) >> _): void
//
fun{
} string0_rforeach (str: string): size_t
fun{
env:vt0p
} string0_rforeach_env
  (str: string, env: &(env) >> _): size_t
// end of [string_rforeach_env]
//
(* ****** ****** *)

(* end of [string0.sats] *)
