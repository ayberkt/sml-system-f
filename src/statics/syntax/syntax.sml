structure Syntax :> SYNTAX =
struct
  structure Abt = SimpleAbt (Operator)
  type var = Abt.variable
  type exp = Abt.abt
  type typ = Abt.abt

  datatype ('t, 'e) exp_view =
     VAR of var
   | TLAM of var * 'e
   | TAPP of 'e * 't
   | LAM of var * 'e
   | AP of 'e * 'e

  datatype 't typ_view =
     TVAR of var
   | ARR of 't * 't
   | ALL of var * 't

  exception Todo

  open Abt
  infix $ $$ \

  structure O = OperatorData

  val intoExp =
    fn VAR x => check (`x, SortData.EXP)
     | TLAM (x, e) => O.TYLAM $$ [([],[x]) \ e]
     | TAPP (e, t) => O.TYAPP $$ [([],[]) \ e, ([],[]) \ t]
     | LAM (x, e) => O.LAM $$ [([],[x]) \ e]
     | AP (e1, e2) => O.AP $$ [([],[]) \ e1, ([],[]) \ e2]

  val intoTyp =
    fn TVAR x => check (`x, SortData.TYP)
     | ARR (t1, t2) => O.ARR $$ [([],[]) \ t1, ([],[]) \ t2]
     | ALL (x, t) => O.ALL $$ [([],[x]) \ t]

  fun outExp e =
    case Abt.infer e of
       (`x, SortData.EXP) => VAR x
     | (O.TYLAM $ [(_,[x]) \ e], _) => TLAM (x, e)
     | (O.TYAPP $ [_ \ e, _ \ t], _) => TAPP (e, t)
     | (O.LAM $ [(_,[x]) \ e], _) => LAM (x, e)
     | (O.AP $ [_ \ e1, _ \ e2], _) => AP (e1, e2)
     | _ => raise Fail "Invalid expression"

  fun outTyp t =
    case Abt.infer t of
       (`x, SortData.TYP) => TVAR x
     | (O.ARR $ [_ \ t1, _ \ t2], _) => ARR (t1, t2)
     | (O.ALL $ [(_,[x]) \ t], _) => ALL (x, t)
     | _ => raise Fail "Invalid type"

end
