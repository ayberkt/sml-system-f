structure SortData =
struct
  datatype t = TYP | EXP
end

structure Sort : ABT_SORT =
struct
  open SortData

  fun eq (TYP, TYP) = true
    | eq (EXP, EXP) = true
    | eq (_,     _) = false

  val eq = op=

  fun toString EXP = "exp"
    | toString TYP = "typ"
end
