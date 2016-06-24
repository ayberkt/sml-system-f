structure ExpLrVals =
  ExprLrValsFun(structure Token = LrParser.Token)

structure ExprLex =
  ExprLexFun(structure Tokens = ExpLrVals.Tokens)
