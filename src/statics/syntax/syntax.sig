signature SYNTAX =
sig
  type var

  type exp
  type typ

  structure Ctx : DICT where type key = var

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

  val intoExp : (typ, exp) exp_view -> exp
  val intoTyp : typ typ_view -> typ

  val outExp : exp -> (typ, exp) exp_view
  val outTyp : typ -> typ typ_view
end
