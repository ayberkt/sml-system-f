signature TYPING =
sig
  type exp
  type typ

  type tctx
  type vctx

  val check : tctx * vctx -> exp -> typ -> unit
  val infer : tctx * vctx -> exp -> typ
end
