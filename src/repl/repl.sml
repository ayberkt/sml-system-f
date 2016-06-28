structure Repl =
struct

  local
    structure Typing = Typing (Syntax)
    fun printLn s = print (s ^ "\n")
  in
    fun loop f =
      let val dummyEOF = ExprLrVals.Tokens.EOF(0, 0)
          val input = valOf ( TextIO.output(TextIO.stdOut, "> ")
                            ; TextIO.flushOut(TextIO.stdOut)
                            ; TextIO.inputLine TextIO.stdIn)
          val result = (f input, SortData.EXP)
          val resultAbt = AstToAbt.convert Abt.Metavar.Ctx.empty result
          val wellTyped =
            case Syntax.outExp resultAbt of
               Syntax.ANN (m, a) => Typing.check (Abt.Var.Ctx.empty, Abt.Var.Ctx.empty) m a
             | _ => false
      in
        printLn (ShowAbt.toString resultAbt);
        printLn (if wellTyped then "Good!" else "Bad!");
        loop f
      end
    end


  fun parseLoop () = loop Parser.parse

  fun main _ = (parseLoop (); 1)

end

val _ = Repl.main ()
