structure Syntax :> SYNTAX =
struct
  structure Abt = SimpleAbt (Operator)
  type var = Abt.variable
  type exp = Abt.abt
  type typ = Abt.abt

  structure Ctx = Abt.Var.Ctx

  datatype ('t, 'e) val_view =
     TLAM of var * 'e
   | LAM of var * 'e

  datatype ('t, 'e) neu_view =
     VAR of var
   | TAPP of 'e * 't
   | AP of 'e * 'e

  datatype ('t, 'e) exp_view =
     ANN of 'e * 't
   | NEU of ('t, 'e) neu_view
   | VAL of ('t, 'e) val_view

  datatype 't typ_view =
     TVAR of var
   | ARR of 't * 't
   | ALL of var * 't

  exception Todo

  open Abt
  infix $ $$ \

  structure O = OperatorData

  val intoExp =
    fn NEU (VAR x) => check (`x, SortData.EXP)
     | NEU (TAPP (e, t)) => O.TYAPP $$ [([],[]) \ e, ([],[]) \ t]
     | NEU (AP (e1, e2)) => O.AP $$ [([],[]) \ e1, ([],[]) \ e2]
     | VAL (TLAM (x, e)) => O.TYLAM $$ [([],[x]) \ e]
     | VAL (LAM (x, e)) => O.LAM $$ [([],[x]) \ e]
     | ANN (e, t) => O.ANN $$ [([],[]) \ e, ([],[]) \ t]

  val intoTyp =
    fn TVAR x => check (`x, SortData.TYP)
     | ARR (t1, t2) => O.ARR $$ [([],[]) \ t1, ([],[]) \ t2]
     | ALL (x, t) => O.ALL $$ [([],[x]) \ t]

  fun outExp e =
    case Abt.infer e of
       (`x, SortData.EXP) => NEU (VAR x)
     | (O.TYLAM $ [(_,[x]) \ e], _) => VAL (TLAM (x, e))
     | (O.TYAPP $ [_ \ e, _ \ t], _) => NEU (TAPP (e, t))
     | (O.LAM $ [(_,[x]) \ e], _) => VAL (LAM (x, e))
     | (O.AP $ [_ \ e1, _ \ e2], _) => NEU (AP (e1, e2))
     | (O.ANN $ [_ \ e, _ \ t], _) => ANN (e, t)
     | _ => raise Fail "Invalid expression"

  fun outTyp t =
    case Abt.infer t of
       (`x, SortData.TYP) => TVAR x
     | (O.ARR $ [_ \ t1, _ \ t2], _) => ARR (t1, t2)
     | (O.ALL $ [(_,[x]) \ t], _) => ALL (x, t)
     | _ => raise Fail "Invalid type"

end
