structure OperatorData =
struct
    datatype 'i t = LAM of t | AP | TYLAM | TYAPP | ARR | ALL

    (* We need alpha-equivalence for this. *)
    fun eq f (LAM t1, LAM t2) = true
      | eq f (AP,       AP) = true
      | eq f (TYLAM, TYLAM) = true
      | eq f (TYAPP, TYAPP) = true
      | eq f (ARR,     ARR) = true

    fun toString f (LAM _, LAM _) = "lam"
      | toString f (AP,       AP) = "ap"
      | toString f (TYLAM, TYLAM) = "Lam"
      | toString f (TYAPP, TYAPP) = "App"
      | toString f (ARR,     ARR) = "arr"

end
structure Operator : OPERATOR =
struct
  structure S = SortData

  structure Valence = Valence (structure Sort = Sort and Spine = ListSpine)
  structure Arity = Arity (Valence)

  fun replicate i x = List.tabulate (i, fn _ => x)
  fun mkVal p q s = ((p, q), s)

  fun arity (LAM _) = ([mkVal [] [O.Sort.EXP] O.Sort.EXP], O.Sort.EXP)
    | arity AP      = ([mkVal [] [] O.Sort.EXP],    O.Sort.EXP)
    | arity TYLAM   = ([mkVal [] [O.Sort.TYP] O.Sort.TYP], O.Sort.TYP)
    | arity TYAPP   = ([mkVal [] [] O.Sort.TYP],    O.Sort.TYP)
    | arity ARR     = raise Fail "not implemented yet!"


  fun map (LAM _) = LAM
    | map AP      = ([mkVal [] [] O.Sort.EXP],    O.Sort.EXP)
    | map TYLAM   = ([mkVal [] [O.Sort.TYP] O.Sort.TYP], O.Sort.TYP)
    | map TYAPP   = ([mkVal [] [] O.Sort.TYP],    O.Sort.TYP)
    | map ARR     = raise Fail "not implemented yet!"
end
