type pos = int
type svalue = Tokens.svalue
type ('a,'b) token = ('a,'b) Tokens.token
type lexresult = (svalue, pos) token

val pos = ref 0
val eof = fn () => Tokens.EOF(!pos, !pos)

exception LexerError of pos

%%
%header (functor ExprLexFun (structure Tokens : Expr_TOKENS));
alpha = [A-Za-z];
digit = [0-9];
any = [@a-zA-Z0-9];
whitespace = [\ \t];
%%

\n                 => (pos := !pos + 1; lex ());
{whitespace}+      => (lex ());

"->"               => (Tokens.ARRTYPE (!pos, !pos));
"all"              => (Tokens.FORALL (!pos, !pos));
"\\"               => (Tokens.SMALLLAMBDA (!pos, !pos));
"/\\"              => (Tokens.BIGLAMBDA (!pos, !pos));

"("                => (Tokens.LPAREN (!pos, !pos));
")"                => (Tokens.RPAREN (!pos, !pos));
"{"                => (Tokens.RBRACKET (!pos, !pos));
"}"                => (Tokens.LBRACKET (!pos, !pos));
"["                => (Tokens.LSQUARE (!pos, !pos));
"]"                => (Tokens.RSQUARE (!pos, !pos));
"<="               => (Tokens.LTEQUALS (!pos, !pos));
"."                => (Tokens.DOT (!pos, !pos));
":"                => (Tokens.COLON (!pos, !pos));
"\'"               => (Tokens.APOSTROPHE (!pos, !pos));

{alpha}{any}*      => (Tokens.IDENT (yytext, !pos, !pos));
