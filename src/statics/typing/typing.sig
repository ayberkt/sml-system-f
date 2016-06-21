signature TYPING =
sig
  type exp
  type typ

  type tctx
  type ectx

  val checkTyp : tctx -> typ -> bool
  val check : tctx * ectx -> exp -> typ -> bool
  val infer : tctx * ectx -> exp -> typ option
end
