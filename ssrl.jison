/* description: structured scripture reference language.  turns strings of bible scriptures to json by parsing them. */

/* lexical grammar */
%lex

%s CHAPTER

%%
[\s]+
  { /*skip whitespace*/ }
[0-4][\s]+[a-zA-Z]+[.]?
  return 'NAME'
[a-zA-Z]+[.]?
  return 'NAME'
<CHAPTER>[;](?=[\s]*[0-9]+[\s]*[:])
  {
    this.popState();
    return 'CHAPTER_SEMICOLON';
  }  
<CHAPTER>[;]
  {
    this.popState();
    return 'SEMICOLON';
  }
<CHAPTER>[,](?=[\s]*[0-9]+[\s]*[:])
  {
    this.popState();
    return 'COMMA';
  }
<CHAPTER>[-](?=[\s]*[0-9]+[\s]*[:])
  {
    this.popState();
    return 'DASH';
  }
<CHAPTER>[,]
  return 'VERSE_COMMA'
<CHAPTER>[-]
  return 'VERSE_DASH'
<CHAPTER>[0-9]+
  return 'VERSE_NUMBER'
[0-9]+
  return 'NUMBER'
[:]
  {
    this.begin('CHAPTER');
    return 'COLON';
  }
[;]
  return 'SEMICOLON'
[,]
  return 'COMMA'
[-]
  return 'DASH'
<<EOF>>
  return 'EOF'

/lex

%start LIST

%% /* language grammar */

LIST
  : SCRIPTURES EOF
    { return $1; }
  ;

SCRIPTURES
  : SCRIPTURE
    { $$ = [$1]; }
  | SCRIPTURES SEMICOLON
    { $$ = $1; }
  | SCRIPTURES SEMICOLON SCRIPTURE
    { $$ = $1.concat($3); }
  ;

SCRIPTURE
  : NAME CHAPTERS
    { $$ = { book: $1, chapters: $2 } }
  ;

CHAPTERS
  : NUMBER
    { $$ = [{ chapter: parseInt($1) }]; }
  | NUMBER COLON
    { $$ = [{ chapter: parseInt($1) }]; }
  | NUMBER COLON VERSES
    { $$ = [{ chapter: parseInt($1), verses: $3 }]; }
  | NUMBER DASH
    { $$ = [{ chapter: parseInt($1) }]; }
  | NUMBER DASH NUMBER
    { $$ = [{ start: { chapter: parseInt($1) }, end: { chapter: parseInt($3) } }]; }
  | NUMBER COLON VERSES DASH NUMBER COLON VERSES
    { $$ = [{ start: { chapter: parseInt($1), verses: $3 }, end: { chapter: parseInt($5), verses: $7 } }]; }
  | CHAPTERS COMMA
    { $$ = $1; }
  | CHAPTERS COMMA NUMBER
    { $$ = $1.concat({ chapter: parseInt($3) }); }
  | CHAPTERS COMMA NUMBER COLON
    { $$ = $1.concat({ chapter: parseInt($3) }); }
  | CHAPTERS COMMA NUMBER COLON VERSES
    { $$ = $1.concat({ chapter: parseInt($3), verses: $5 }); }
  | CHAPTERS COMMA NUMBER DASH
    { $$ = $1.concat({ chapter: parseInt($3) }); }
  | CHAPTERS COMMA NUMBER DASH NUMBER
    { $$ = $1.concat({ start: { chapter: parseInt($3) }, end: { chapter: parseInt($5) } }); }
  | CHAPTERS CHAPTER_SEMICOLON
    { $$ = $1; }
  | CHAPTERS CHAPTER_SEMICOLON NUMBER
    { $$ = $1.concat({ chapter: parseInt($3) }); }
  | CHAPTERS CHAPTER_SEMICOLON NUMBER COLON
    { $$ = $1.concat({ chapter: parseInt($3) }); }
  | CHAPTERS CHAPTER_SEMICOLON NUMBER COLON VERSES
    { $$ = $1.concat({ chapter: parseInt($3), verses: $5 }); }
  | CHAPTERS CHAPTER_SEMICOLON NUMBER DASH
    { $$ = $1.concat({ chapter: parseInt($3) }); }
  | CHAPTERS CHAPTER_SEMICOLON NUMBER DASH NUMBER
    { $$ = $1.concat({ start: { chapter: parseInt($3) }, end: { chapter: parseInt($5) } }); }
  ;

VERSES
  : VERSE_RANGE
    { $$ = [$1]; }
  | VERSE_NUMBER
    { $$ = [{ verse: parseInt($1) }]; }
  | VERSES VERSE_COMMA
    { $$ = $1; }
  | VERSES VERSE_COMMA VERSE_RANGE
    { $$ = $1.concat($3); }
  | VERSES VERSE_COMMA VERSE_NUMBER
    { $$ = $1.concat({ verse: parseInt($3) }); }
  ;

VERSE_RANGE
  : VERSE_NUMBER VERSE_DASH
    { $$ = { verse: parseInt($1) }; }
  | VERSE_NUMBER VERSE_DASH VERSE_NUMBER
    { $$ = { start: { verse: parseInt($1) }, end: { verse: parseInt($3) } }; }
  ;
