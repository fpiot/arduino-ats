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

(*
** Source:
** $PATSHOME/prelude/DATS/CODEGEN/string.atxt
** Time of generation: Thu Jul  3 21:15:48 2014
*)

(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: April, 2012 *)

(* ****** ****** *)

#include "config.hats"
staload "{$TOP}/avr_prelude/SATS/string0.sats"
staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

#define CNUL '\000'

(* ****** ****** *)

implement{env}
string0_foreach$cont (c, env) = true
implement{env}
string0_foreach$fwork (c, env) = ((*void*))

implement{}
string0_foreach (str) = let
  var env: void = () in string0_foreach_env (str, env)
end // end of [string0_foreach]

implement{env}
string0_foreach_env
  (str, env) = let
//
fun loop (
  p: ptr, env: &env
) : ptr = let
  val c = $UN.ptr0_get<char> (p)
  val cont = (
    if c != CNUL then string0_foreach$cont<env> (c, env) else false
  ) : bool // end of [val]
in
  if cont then let
    val () =
      string0_foreach$fwork<env> (c, env) in loop (ptr_succ<char> (p), env)
    // end of [val]
  end else (p) // end of [if]
end // end of [fun]
//
val p0 =
  string2ptr (str)
val p1 = loop (p0, env)
//
in
  $UN.cast{size_t}(p1 - p0)
end // end of [string0_foreach_env]

(* ****** ****** *)

implement{env}
string0_rforeach$cont (c, env) = true
implement{env}
string0_rforeach$fwork (c, env) = ((*void*))

implement{}
string0_rforeach (str) = let
  var env: void = () in string0_rforeach_env (str, env)
end // end of [string0_rforeach]

implement
{env}(*tmp*)
string0_rforeach_env
  (str, env) = let
//
fun loop
(
  p0: ptr, p1: ptr, env: &env >> _
) : ptr = let
in
//
if
(p1 > p0)
then let
  val p2 = ptr_pred<char> (p1)
  val c2 = $UN.ptr0_get<charNZ> (p2)
  val cont =
    string0_rforeach$cont<env> (c2, env)
  // end of [val]
in
  if cont
    then let
      val () =
      string0_rforeach$fwork<env> (c2, env)
    in
      loop (p0, p2, env)
    end // end of [then]
    else (p1) // end of [else]    
end // end of [then]
else (p1) // end of [else]
//
end // end of [loop]
//
val p0 = ptrcast(str)
val p1 = ptr_add<char> (p0, length(str))
//
in
  $UN.cast{size_t}(p1 - loop (p0, p1, env))
end // end of [string0_rforeach_env]

(* end of [string0.dats] *)
