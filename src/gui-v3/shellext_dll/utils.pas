unit utils;

interface

function PosBM(SubString, S: PChar): integer;

implementation

function PosBM(SubString, S : PChar): integer;
{ Attention le resultat renvoye par cette fonction est sur une base 0. C'est
  a dire que le premier caractere se trouve a la position 0 et non a la position
  1 comme dans les string }
var
  skip: array [0..255] of byte;
  LengthSubString: integer;

begin
  Result := 0;
  LengthSubString := Length(SubString);
  
  //On remplit le tableau
  //Le FillMemory appelle FillChar donc autant mettre FillChar des le debut
  FillChar(Skip, 256, LengthSubString);

  asm
  //On remplit les cases des valeurs ASCII avec les positions en partant de la fin
  //PUSH EBX

    XOR EBX, EBX                //Mise a 0

    MOV EDX, [LengthSubString]  //On recupere valeur de LenSub
    MOV ECX, EDX                //Initialise le Compteur
    DEC ECX                    //On va juska LenSub -1
    MOV ESI, [SubString]

    @Remplir :  MOV EAX, EDX                          //On recupere lensub
                SUB EAX, ECX                          //On fait la difference
                //EAX = position du caractere en partant de la fin-1
                MOV BL, BYTE PTR [ESI + ECX-1]      //On recupere l'ASCII du caractere
                //BL = ASCII du caractere
                LEA EDI, [EBX + skip]                //pointeur sur element de skip
                //EDI = Pointe sur skip[BL]
                MOV BYTE PTR [EDI], AL                //On met la difference dans la table Skip
                DEC ECX
                JNZ @Remplir


    //Algo de recherche
    XOR EAX, EAX    //EAX = Sert a lire S
    XOR EBX, EBX    //EBX = Sert a lire SubString

    MOV ESI, [S]            //ESI = pointe sur S
    MOV EDX, [LengthSubString]      //EDX = LenSub
    LEA ESI, [ESI + EDX -1]    //On va au caractere a la position de LenSub


    //Il faut recuperer EDI (ASubString) a chaque debut de boucle
    @Boucle1 :  MOV EDX, [LengthSubString]      //EDX = LenSub
                MOV EDI, [SubString]  //EDI = pointe sur ASubString
                LEA EDI, [EDI + EDX -1]

    @Boucle2 :  MOV AL, BYTE PTR [ESI]  //On recupere la lettre a la position de ESI = Lettre de S
                CMP AL, 0    //Si on est sorti ou pas
                JE @PasTrouve
                MOV BL, BYTE PTR [EDI]  //On recupere la lettre qui va etre comparee = Lettre de SubString
                CMP AL, BL      //On compare les 2 caracteres
                JNE @IncESI    //C'est pas les memes, donc la chaine n'est pas bonne
                DEC ESI        //On lit le prochain caractere de S
                DEC EDI        //On lit le prochain caractere (en arriere)
                DEC EDX        //On regarde si on est pas alle au bout de la chaine
                JNZ @Boucle2
                INC ESI      //On remonte d'un cran car la derniere lettre etait au dessus
                JMP @Trouve  //On est alle au bout sans partir = Chaine trouvee !

    @IncESI  :  //EAX contient deja l'ASCII du caractere pointe
                MOV AL, BYTE PTR [EAX + skip]      //pointeur sur element de skip
                LEA ESI, [ESI + EAX]        //On incremente de la valeur trouve dans Skip
                JMP @Boucle1

    @PasTrouve :MOV EBX, -1


                //POP EBX
    @Trouve :  MOV EAX, [S]  //Recupere adresse de depart
                SUB ESI, EAX  // On fait difference entre arrivee et depart
                MOV EBX, ESI    //On renvoit le resultat

  end;
end;

end.
