structure Parser =
struct

  fun stringreader s =
  	let val pos = ref 0
    	  val remainder = ref (String.size s)
  	    fun min(a, b) = if a < b then a else b
  	in
  	    fn n =>
  	       let
  	           val m = min(n, !remainder)
  	           val s = String.substring(s, !pos, m)
  	           val () = pos := !pos + m
  	           val () = remainder := !remainder - m
  	       in
  	           s
  	       end
  	end

  fun error (s, pos, pos') = (raise Fail "Parse error !")

  fun parse text : AstSyntax.exp =
    let
        val lexer =  ExprParser.makeLexer (stringreader text)
        val (res,_) = ExprParser.parse(1, lexer, error, ())
                                (* parse is complete -- skip the next token, either ; or eof *)
    in
        res
    end

end
