MODULE armscii1;

IMPORT Out,Files, Args, ethUnicode;


VAR
  str, fn: ARRAY 32 OF CHAR;
  f: Files.File;
  r: Files.Rider;


PROCEDURE showHelp(err: INTEGER);
BEGIN
  IF err = 0 THEN
    Out.String('At least one argument required.');Out.Ln;
    HALT(1);
  END;
  IF err = 1 THEN
    Out.String('Not valid file path');Out.Ln;
    HALT(1);
    END;

END showHelp;

PROCEDURE checkArgs(VAR filename: ARRAY OF CHAR);
 VAR 
   n: INTEGER;
   fl: Files.File;
BEGIN
  n := Args.argc;
  IF n = 1 THEN 
    Out.String('at least 1');Out.Ln;
    showHelp(0);
  ELSE 
    IF n >2 THEN Out.String('only first will proccessed'); Out.Ln END;
    Args.Get(1, filename);
  END;
  fl := Files.Old(filename);
  IF fl = NIL THEN
    showHelp(1);
    END;
END checkArgs;

PROCEDURE convertArmscii(ch1, ch2: CHAR; VAR outstr: ARRAY OF CHAR);

VAR
  
  ord: INTEGER;
  armlet : ARRAY 300 OF CHAR;

BEGIN
    armlet := '։    »«և  ՝    ֊  ՜՛՞ԱաԲբԳգԴդԵեԶզԷէԸըԹթԺժԻիԼլԽխԾծԿկՀհՁձՂղՃճՄմՅյՆնՇշՈոՉչՊպՋջՌռՍսՎվՏտՐրՑցՒւՓփՔքՕօՖֆ';
    ord := ORD(ch2) - 163;
    IF ORD(ch1) = 195 THEN
      ord := ord + 64;
      END;
    ord := ord*2;

    outstr[0] := armlet[ord];
    outstr[1] := armlet[ord+1];
    outstr[2] := 0X;

END convertArmscii;


PROCEDURE catFile(filename: ARRAY OF CHAR);

VAR
  ch1: CHAR;
  ch2: CHAR;
  r: Files.Rider;
  f: Files.File;
  outstr: ARRAY 3 OF CHAR;

BEGIN
 f := Files.Old(filename);
 Files.Set(r, f, 0);
 
 REPEAT
    outstr[0] := 0X;
    outstr[1] := 0X;
    Files.Read(r, ch1);
    IF (ORD(ch1) # 194) & (ORD(ch1) # 195) THEN
       Out.Char(ch1);
    ELSE 
    Files.Read(r, ch2);
    convertArmscii(ch1, ch2, outstr);
    Out.String(outstr);
    END;
  UNTIL r.eof;

  Out.Ln;
  
END catFile;

PROCEDURE main;
VAR
  filename: ARRAY 32 OF CHAR;

   
BEGIN
  checkArgs(filename);
  catFile(filename);
END main;

BEGIN
  main;
END armscii1.
