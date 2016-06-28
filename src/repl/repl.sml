structure Repl =
struct

  fun loop f =
    let val dummyEOF = ExprLrVals.Tokens.EOF(0, 0)
        val input = valOf ( TextIO.output(TextIO.stdOut, "> ")
                          ; TextIO.flushOut(TextIO.stdOut)
                          ; TextIO.inputLine TextIO.stdIn)
        val result = f input
    in
      print (Ast.toString result)
    end


  fun parseLoop () = loop Parser.parse

  fun main _ = (parseLoop (); 1)

end
