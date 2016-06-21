structure SortData =
struct
  datatype t = TYP | EXP
end

structure Sort : ABT_SORT =
struct
  open SortData
  val eq = op=

  fun toString EXP = "exp"
    | toString TYP = "typ"
end
