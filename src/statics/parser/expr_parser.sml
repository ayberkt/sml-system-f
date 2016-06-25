structure ExprParser =
  Join(structure LrParser = LrParser
      structure ParserData = ExprLrVals.ParserData
      structure Lex = ExprLex)
