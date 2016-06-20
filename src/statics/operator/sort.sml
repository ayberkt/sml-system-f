structure SortData =
struct
  datatype t = TYP | EXP
end
structure Sort : SORT =
struct
  val eq = op=

  fun toString EXP = "exp"
    | toString TYP = "typ"
end
