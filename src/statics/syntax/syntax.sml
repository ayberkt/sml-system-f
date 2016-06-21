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

  fun intoExp _ = raise Todo
  fun intoTyp _ = raise Todo
  fun outExp _ = raise Todo
  fun outTyp _ = raise Todo

end
