functor Typing (Syn : SYNTAX) : TYPING =
struct
  open Syn

  type tctx = unit Ctx.dict
  type ectx = typ Ctx.dict


  exception Todo

  fun checkTyp delta t =
    case outTyp t of
       TVAR x => Ctx.member delta x
     | ARR (t1, t2) => checkTyp delta t2 andalso checkTyp delta t2
     | ALL (x, t) => checkTyp (Ctx.insert delta x ()) t

  fun check _ _ = raise Todo

  fun infer _ _ = raise Todo

end
