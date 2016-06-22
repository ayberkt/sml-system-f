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

  fun isSubtype delta t1 t2 =
    checkTyp delta t1
      andalso checkTyp delta t2
      andalso typEq (t1, t2)

  fun check (delta, gamma) e t =
    case outExp e of
       VAL v => checkVal (delta, gamma) v t
     | NEU r =>
         (case inferNeu (delta, gamma) r of
             SOME t' => isSubtype delta t t' (* is this backwards? *)
           | NONE => false)
     | ANN (e, t') => typEq (t, t') andalso check (delta, gamma) e t

  and checkVal (delta, gamma) v =
    raise Todo

  and inferExp (delta, gamma) e =
    case outExp e of
       NEU r => inferNeu (delta, gamma) r
     | ANN (e, t) => SOME t
     | _ => NONE

  and inferNeu (delta, gamma) r =
    case r of
       VAR x => Ctx.find gamma x
     | AP (r, e) =>
         (case inferExp (delta, gamma) r of
             SOME t => raise Todo
           | NONE => NONE)
    | TAPP (r, t) => raise Todo

end
