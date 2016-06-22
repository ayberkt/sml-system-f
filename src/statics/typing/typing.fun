functor Typing (Syn : SYNTAX) : TYPING =
struct
  open Syn

  type tctx = unit Ctx.dict
  type ectx = typ Ctx.dict


  exception Todo

  structure Option =
  struct
    open Option

    fun bind (SOME x) f = f x
      | bind NONE _ = NONE

    fun guard true x = x
      | guard _ _ = NONE
  end

  fun >>= (x, f) = Option.bind x f
  infix >>=

  fun @@ (f, x) = f x
  infix @@

  fun checkTyp delta t =
    case outTyp t of
       TVAR x => Ctx.member delta x
     | ARR (t1, t2) => checkTyp delta t2 andalso checkTyp delta t2
     | ALL (x, t) => checkTyp (Ctx.insert delta x ()) t

  fun check (delta, gamma) e t =
    case outExp e of
       VAL v => checkVal (delta, gamma) v t
     | NEU r =>
         (case inferNeu (delta, gamma) r of
             SOME t' => typEq (t, t')
           | NONE => false)
     | ANN (e, t') => typEq (t, t') andalso check (delta, gamma) e t

  and checkVal (delta, gamma) v t =
    case (v, outTyp t) of
       (LAM (x, e), ARR (t1, t2)) => check (delta, Ctx.insert gamma x t1) e t2
     | (TLAM (x, e), ALL (y, t)) => check (Ctx.insert delta y (), gamma) e @@ substTyp (y, intoTyp (TVAR x)) t
     | _ => false

  and inferExp (delta, gamma) e =
    case outExp e of
       NEU r => inferNeu (delta, gamma) r
     | ANN (e, t) => SOME t
     | _ => NONE

  and inferNeu (delta, gamma) r =
    case r of
       VAR x => Ctx.find gamma x
     | AP (r, e) =>
         inferExp (delta, gamma) r >>= (fn t =>
           case outTyp t of
              ARR (t1, t2) => Option.guard (check (delta, gamma) e t1) @@ SOME t2
            | _ => NONE)
    | TAPP (r, t) =>
        Option.guard (checkTyp delta t) @@
          inferExp (delta, gamma) r >>= (fn t' =>
            case outTyp t' of
               ALL (x, t'') => SOME @@ substTyp (x, t) t''
             | _ => NONE)

end
