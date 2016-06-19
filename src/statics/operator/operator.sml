structure F_Op =
struct
  structure M = Symbol ()
  structure V = Symbol ()
  structure I = Symbol ()

  structure O =
  struct
    structure Sort =
    struct
      datatype t = EXP | TYP
      val eq : t * t -> bool = op=
      fun toString EXP = "exp"
        | toString TYP = "typ"
    end

    structure Valence = Valence (structure Sort = Sort and Spine = ListSpine)
    structure Arity = Arity (Valence)

    datatype 'i t = LAM | AP | TYLAM | TYAPP | ARR | ALL

    fun eq f (LAM,      LAM) = true
      | eq f (AP,        AP) = true
      | eq f (TYLAM,  TYLAM) = true
      | eq f (TYAPP,  TYAPP) = true
      | eq f (ARR,      ARR) = true

    fun toString f (LAM,      LAM) = "lam"
      | toString f (AP,        AP) = "ap"
      | toString f (TYLAM,  TYLAM) = "Lam"
      | toString f (TYAPP,  TYAPP) = "App"
      | toString f (ARR,      ARR) = "arr"
  end

  fun replicatie i x = List.tabulate (i, fn _ => x)
  fun mkVal p q s = ((p, q), s)

end
