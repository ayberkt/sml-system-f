structure ExprLrVals =
  ExprLrValsFun(structure Token = LrParser.Token)

structure ExprLex =
  ExprLexFun(structure Tokens = ExprLrVals.Tokens)
