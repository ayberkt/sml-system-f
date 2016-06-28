structure SO = SimpleOperator

structure Repl =
struct

  local
    fun printLn s = print (s ^ "\n")
  in
    fun loop f =
      let val dummyEOF = ExprLrVals.Tokens.EOF(0, 0)
          val input = valOf ( TextIO.output(TextIO.stdOut, "> ")
                            ; TextIO.flushOut(TextIO.stdOut)
                            ; TextIO.inputLine TextIO.stdIn)
          val result = (f input, SortData.EXP)
      in
        printLn (ShowAbt.toString (AstToAbt.convert Abt.Metavar.Ctx.empty result));
        loop f
      end
    end


  fun parseLoop () = loop Parser.parse

  fun main _ = (parseLoop (); 1)

end

val _ = Repl.main ()
