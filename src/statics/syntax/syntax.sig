signature SYNTAX =
sig
  type var

  type exp
  type typ

  structure Ctx : DICT where type key = var

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

  val intoExp : (typ, exp) exp_view -> exp
  val intoTyp : typ typ_view -> typ

  val outExp : exp -> (typ, exp) exp_view
  val outTyp : typ -> typ typ_view
end
