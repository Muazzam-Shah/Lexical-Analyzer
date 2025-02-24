%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int line = 1; 
FILE *fp;

void print(char *token_type);
void yyerror(char *message);
%}

%x ML_COMMENT

alpha       [a-zA-Z_]
digit       [0-9_]
alnum       {alpha}|{digit}
print       [ -~]

VARIABLE_NAME          {alpha}+{alnum}*
ICONST      "0"|[1-9][0-9]*
FCONST      {digit}+"."{digit}+
CCONST      (\'{print}\')|(\'\\[nftrbv]\')
STRING      \"{print}*\"
PREPROCESSOR_HEADER "#include \""{alnum}*".h\""
PREPROCESSOR_BUILT_IN_LIBRARY "#include <"{alpha}*">"
POSTINCREMENT {alpha}{alnum}*"++";
PREINCREMENT "++"{alpha}{alnum}*;
POSTDECREMENT {alpha}{alnum}*"--";
PREDECREMENT "--"{alpha}{alnum}*;

%%



"/*"                    { printf("Comment from line %d ", line); BEGIN(ML_COMMENT); }
<ML_COMMENT>"*/"        { printf("to line %d\n", line); BEGIN(INITIAL); }
<ML_COMMENT>[^*\n]+
<ML_COMMENT>"*"
<ML_COMMENT>"\n"        { line = line + 1; }
"//".*                  { print("COMMENT"); }
"+"|"-"                 { print("ARITHEMETIC_OPERATOR"); }
"*"                     { print("MULTIPLICATION_OPERATOR"); }
"/"                     { print("DIVISION_OPERATOR"); }
"||"                    { print("OR_OPERATOR"); }
"&&"                    { print("AND_OPERATOR"); }
"!"                     { print("NOT_OPERATOR"); }
"=="                    { print("EQUAL_TO_OPERATOR"); }
"!="                    { print("NOT_EQUAL_TO_OPERATOR"); }
">"|"<"|">="|"<="       { print("COMPARISON_OPERATOR"); }
"char"|"CHAR"           { print("DATATYPE_CHAR"); }
"int"|"INT"             { print("DATATYPE_INT"); }
"float"|"FLOAT"         { print("DATATYPE_FLOAT"); }
"double"|"DOUBLE"       { print("DATATYPE_DOUBLE"); }
"if"|"IF"               { print("KEYWORD_IF"); }
"switch"                { print("KEYWORD_SWITCH"); }
"case"                  { print("KEYWORD_CASE"); }
"else"|"ELSE"           { print("KEYWORD_ELSE"); }
"while"|"WHILE"         { print("KEYWORD_WHILE_LOOP"); }
"for"|"FOR"             { print("KEYWORD_FOR_LOOP"); }
"continue"|"CONTINUE"   { print("KEYWORD_CONTINUE"); }
"break"|"BREAK"         { print("KEYWORD_BREAK"); }
"void"|"VOID"           { print("DATATYPE_VOID"); }
"return"|"RETURN"       { print("KEYWORD_RETURN"); }
"using namespace std;"  { print("KEYWORD_USING_NAMESPACE_STD"); }
"main"|"MAIN"           {print("KEYWORD_MAIN");}
"bool"                  { printf("DATATYPE_BOOL\n"); }
"delete"                { printf("KEYWORD_DELETE\n"); }
"struct"|"STRUCT"       {print("KEYWORD_STRUCT");}
"enum"|"ENUM"           {print("KEYWORD_ENUM");}
"public"|"PUBLIC"       {print("KEYWORD_PUBLIC");}
"switch"|"SWITCH"       {print("KEYWORD_SWITCH");}
"new"|"NEW"             {print("KEYWORD_NEW");}
"delete"|"DELETE"       {print("KEYWORD_DELETE");}
"template|TEMPLATE"     {print("KEYWORD_TEMPLATE");}
"throw"|"THROW"         {print("KEYWORD_THROW");}
"catch"|"CATCH"         {print("KEYWORD_CATCH");}
"static"|"STATIC"       {print("KEYWORD_STATIC");}
"virtual"|"VIRTUAL"     {print("KEYWORD_VIRTUAL");}
"do"|"DO"               {print("KEYWORD_DO");}
"long|LONG"             {print("DATATYPE_LONG");}
"short|SHORT"           {print("DATATYPE_SHORT");}
"sizeof|SIZEof"         {print("KEYWORD_SIZEOF");}
"class"|"CLASS"         {print("DATA_STRUCTURE_CLASS");}
"("             { print("LEFT_PAREN"); }
")"             { print("RIGHT_PAREN"); }
"]"             { print("LEFT_BRACKET"); }
"["             { print("RIGHT_BRACKET"); }
"{"             { print("LEFT_BRACE"); }
"}"             { print("RIGHT_BRACE"); }
";"             { print("SEMI"); }
"."             { print("DOT"); }
","             { print("COMMA"); }
"="             { print("ASSIGN"); }
"&"             { print("REFER"); }
"#"             { print("PREPROCESSOR"); }
"<<"            {print("STREAM_INSERTION");}
">>"            {print("STREAM_EXTRACTION");}
"cout"          {print("LIBRARY_FUNC_OUTPUT");}
"cin"          {print("LIBRARY_FUNC_INPUT");}
"#define"  {print("PREPROCEESOR_MACRO");}

{VARIABLE_NAME} { print("VARIABLE_DECLARED"); }
{ICONST}        { print("INTCONST"); }
{FCONST}        { print("FLOATCONST"); }
{CCONST}        { print("CHARCONST"); }
{STRING}        { print("STRING"); }
{PREPROCESSOR_BUILT_IN_LIBRARY} { print("PREPROCESSOR"); }
{PREPROCESSOR_HEADER} { print("PREPROCESSOR"); }
{POSTINCREMENT} { print("POSTINCREMENT"); }
{PREINCREMENT} { print("PREINCREMENT"); }
{POSTDECREMENT} { print("POSTDECREMENT"); }
{PREDECREMENT} { print("PREDECREMENT"); }

"\n"            { line += 1; }
[ \t\r\f]+          /* ignore whitespace */

.               { yyerror("Unrecognized character"); }

%%

void print(char *token_type){
    fprintf(fp, "Text: %s\t\t Token: %s.\t Line Number: %d\n", yytext, token_type, line);
}

void yyerror(char *message){
    fprintf(fp, "Error: \"%s\" in line %d. Token = %s\n", message, line, yytext);
    exit(1);
}

int main(int argc, char *argv[]){
    if (argc != 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    fp = fopen("output.txt", "w");
    if (!fp) {
        perror("Error opening output file");
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("Error opening input file");
        fclose(fp);
        return 1;
    }

    yylex();

    fclose(yyin);
    fclose(fp);

    return 0;
}