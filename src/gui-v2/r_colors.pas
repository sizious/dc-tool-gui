unit r_colors;

interface

uses
  JvRichEdit, Graphics, ComCtrls, Windows, Messages;
  
procedure AddFormattedText(Text : string ; JvRichEdit : TJvRichEdit ; TextColor : TColor = clBlack ; TextSize : integer = 8 ; FontName : TFontName = 'Tahoma' ; FontStyle : TFontStyles = [] ; TextCharset : TFontCharset = 0);
procedure SetTextAttribut(JvRichEdit : TJvRichEdit ; TextColor : TColor = clBlack ; TextSize : integer = 8 ; FontName : TFontName = 'Tahoma' ; FontStyle : TFontStyles = [] ; TextCharset : TFontCharset = ANSI_CHARSET);
procedure SetAttributWithFont(JvRichEdit : TJvRichEdit ; Font : TFont);
procedure CopyJvRichEdit(Source, Destination : TJvRichEdit);

implementation

uses main, tools;

{ -------------------------------< DEBUT DES PROCEDURES >--------------------------------------------------------------------------------------------------------------------------------------------------------- }

{ -------------------------------< PROCEDURE GotoEnd >--------------------------------------------------------------------------------------------------------------------------------------------------------- }

procedure GotoEnd(JvRichEdit : TJvRichEdit);
begin
  JvRichEdit.SelStart := Length(JvRichEdit.Text);
end;

{ -------------------------------< PROCEDURE AddTextColor >--------------------------------------------------------------------------------------------------------------------------------------------------------- }

procedure AddFormattedText(Text : string ; JvRichEdit : TJvRichEdit ; TextColor : TColor = clBlack ; TextSize : integer = 8 ; FontName : TFontName = 'Tahoma' ; FontStyle : TFontStyles = [] ; TextCharset : TFontCharset = ANSI_CHARSET);
var
  SaveAttributs : TTextAttributes;
  
begin
  //Fonction normale
  JvRichEdit.SelLength := 0;
  //MessageBoxA(0, pchar(JvRichEdit.SelText), '', 0);

  SaveAttributs := JvRichEdit.SelAttributes;

  with JvRichEdit.SelAttributes do
  begin
    Color := TextColor;
    Size := TextSize;
    Name := FontName;
    Style := FontStyle;
    Charset := TextCharset;
  end;
  
  JvRichEdit.Lines.Add(Text);
  JvRichEdit.SelAttributes := SaveAttributs;
end;

{ -------------------------------< PROCEDURE SetTextAttribut >--------------------------------------------------------------------------------------------------------------------------------------------------------- }

procedure SetTextAttribut(JvRichEdit : TJvRichEdit ; TextColor : TColor = clBlack ; TextSize : integer = 8 ; FontName : TFontName = 'Tahoma' ; FontStyle : TFontStyles = [] ; TextCharset : TFontCharset = ANSI_CHARSET);
begin
  //JvRichEdit.SelLength := 0;

  //Mettre à la fin!
  if JvRichEdit = nil then Exit; //Si l'objet est détruit, on se barre!
  JvRichEdit.SelStart := Length(JvRichEdit.Text);
  //JvRichEdit.
  //if Main_Form.Visible = True then
  //  GotoLine(JvRichEdit, JvRichEdit.Lines.Count - 1);
  //SendMessage(JvRichEdit.Handle, WM_VSCROLL, SB_BOTTOM, 0);
  
  with JvRichEdit.SelAttributes do
  begin
    Color := TextColor;
    Size := TextSize;
    Name := FontName;
    Style := FontStyle;
    Charset := TextCharset;
  end;
end;

{ -------------------------------< PROCEDURE SetAttributWithFont >--------------------------------------------------------------------------------------------------------------------------------------------------------- }

procedure SetAttributWithFont(JvRichEdit : TJvRichEdit ; Font : TFont);
begin
  JvRichEdit.SelectAll;
  with JvRichEdit.SelAttributes do
  begin
    Color := Font.Color;
    Size := Font.Size;
    Name := Font.Name;
    Style := Font.Style;
    Charset := Font.Charset;
  end;
  JvRichEdit.SelLength := 0;
end;

{ -------------------------------< PROCEDURE CopyJvRichEdit >--------------------------------------------------------------------------------------------------------------------------------------------------------- }

procedure CopyJvRichEdit(Source, Destination : TJvRichEdit);

//------Sous procédure AddChatText--------
procedure AddChatText(Text : string ; JvRichEdit : TJvRichEdit ; TextColor : TColor = clBlack ; TextSize : integer = 8 ; FontName : TFontName = 'Tahoma' ; FontStyle : TFontStyles = [] ; TextCharset : TFontCharset = ANSI_CHARSET);
var
  SaveAttributs : TTextAttributes;
  
begin
  SaveAttributs := JvRichEdit.SelAttributes;

  with JvRichEdit.SelAttributes do
  begin
    Color := clGray;
    Size := 8;
    Name := 'Tahoma';
    Style := [fsItalic];
    Charset := TextCharset;
  end;

  { if NickName = '' then
    JvRichEdit.Lines.Add(LocalIP + ' dit :')
  else JvRichEdit.Lines.Add(NickName + ' dit :'); }

  with JvRichEdit.SelAttributes do
  begin
    Color := TextColor;
    Size := TextSize;
    Name := FontName;
    Style := FontStyle;
    Charset := TextCharset;
  end;
  
  JvRichEdit.Lines.Add(Text);
  JvRichEdit.SelAttributes := SaveAttributs;
end;
//----Fin procédure--------------------------------------

var
  SourceAttributes : TTextAttributes;
  i : integer;
  Text : string;

begin
  Text := Source.Text;
  if Length(Text) = 0 then Exit;
  Source.Clear;

  //Mettre à la fin
  Destination.SelStart := Length(Destination.Text);
  SourceAttributes := Source.SelAttributes;

  //Ceci decale vers le bas
  for i := 0 to Destination.Lines.Count - 1 do
    Destination.Perform(WM_VSCROLL, SB_LINEDOWN, 0);

  with Destination.SelAttributes do
  begin
    Color := SourceAttributes.Color;
    Size := SourceAttributes.Size;
    Name := SourceAttributes.Name;
    Style := SourceAttributes.Style;
    Charset := SourceAttributes.Charset;
  end;

  AddChatText(Text, Destination, Destination.SelAttributes.Color, Destination.SelAttributes.Size, Destination.SelAttributes.Name, Destination.SelAttributes.Style, Destination.SelAttributes.Charset);
end;

{ ----------------------------------< FIN DES PROCEDURES >-------------------------------------------------------------------------------------------------------------------------------------------------------- }

end.
