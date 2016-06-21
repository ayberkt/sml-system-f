structure OperatorData =
struct
    datatype t = LAM | AP | TYLAM | TYAPP | ARR | ALL

    val eq : t * t -> bool = op=

    val toString =
      fn LAM => "lam"
       | AP => "ap"
       | TYLAM => "Lam"
       | TYAPP => "App"
       | ARR => "arr"
       | ALL => "all"
end

structure SimpleOperator : ABT_SIMPLE_OPERATOR =
struct
  open OperatorData
  structure Ar = ListAbtArity (Sort)

  (* to make a valence *)
  fun mkVal p q s = ((p, q), s)

  val arity =
    fn LAM => ([mkVal [] [SortData.EXP] SortData.EXP], SortData.EXP)
     | AP => ([mkVal [] [] SortData.EXP, mkVal [] [] SortData.EXP], SortData.EXP)
     | TYLAM => ([mkVal [] [SortData.TYP] SortData.EXP], SortData.EXP)
     | TYAPP => ([mkVal [] [] SortData.EXP, mkVal [] [] SortData.TYP], SortData.EXP)
     | ARR => ([mkVal [] [] SortData.TYP, mkVal [] [] SortData.TYP], SortData.TYP)
     | ALL => ([mkVal [] [SortData.TYP] SortData.TYP], SortData.TYP)
end

structure Operator = AbtSimpleOperator (SimpleOperator)
