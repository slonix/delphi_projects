{
#autor: Konrad S³oniewski
#data: 2012-05-10
}

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls;

type
  ListaAtrybutow = ^Atrybut;
  Atrybut = record
    nazwa: String;
    nast: ListaAtrybutow;
  end;

  ListaEncji = ^Encja;
  Encja = record
    nazwa: String;
    atrybuty: ListaAtrybutow;
    liczba: Integer;
    nast: ListaEncji;
    punkt1, punkt2: TPoint;
  end;

  ListaZwiazkow = ^Zwiazek;
  Zwiazek = record
    nazwa: String;
    encja1, encja2: String;
    liczba1, liczba2: String;
    rola1, rola2: String;
    nast: ListaZwiazkow;
  end;

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Nowyprojekt1: TMenuItem;
    Nowyprojekt2: TMenuItem;
    PopupMenu1: TPopupMenu;
    Dodajencj1: TMenuItem;
    Wyj1: TMenuItem;
    Zwiazek: TMenuItem;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    Otworz: TMenuItem;
    Zapisz: TMenuItem;
    Pomoc1: TMenuItem;
    Edytujzwizek1: TMenuItem;
    procedure ControlMouseDown(Sender: TObject;
                             Button: TMouseButton;
                             Shift: TShiftState;
                             X, Y: Integer);
    procedure ControlMouseMove(Sender: TObject;
                           Shift: TShiftState;
                           X, Y: Integer);
    procedure ControlMouseUp(Sender: TObject;
                           Button: TMouseButton;
                           Shift: TShiftState;
                           X, Y: Integer);
    procedure RysujDiagram;
    procedure RysujZwiazki;
    procedure FormCreate(Sender: TObject);
    procedure Nowyprojekt2Click(Sender: TObject);
    procedure Dodajencj1Click(Sender: TObject);
    procedure Wyj1Click(Sender: TObject);
    procedure ZwiazekClick(Sender: TObject);
    procedure ZapiszClick(Sender: TObject);
    procedure OtworzClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure Pomoc1Click(Sender: TObject);
    procedure Edytujzwizek1Click(Sender: TObject);
  private
    { Private declarations }
    private
    inReposition: ListaEncji;
    oldPos: TPoint;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Canvas: TCanvas;
  encje: ListaEncji;
  zwiazki: ListaZwiazkow;

implementation

uses Unit2, Unit3, Unit4, Unit5, Unit6;

{$R *.dfm}

{------------------------------------------------------------------------------}
//TWORZENIE FORMULARZA
procedure TForm1.FormCreate(Sender: TObject);
begin
  //Pe³ny ekran
  Left := 0;
  Top := 0;
  Height := Screen.Height;
  Width := Screen.Width;

  //Atrapy dla listy encji, atrybutów i zwi¹zków
  new(encje);
  encje^.nast := nil;
  new(zwiazki);
  zwiazki^.nast := nil;

  //Kontrola klikniêcia mysz¹
  inReposition := nil;
  Form1.OnMouseDown := ControlMouseDown;
  Form1.OnMouseMove := ControlMouseMove;
  Form1.OnMouseUp := ControlMouseUp;
end;

{------------------------------------------------------------------------------}
//KLIKNIÊCIE MYSZ¥
procedure TForm1.ControlMouseDown(Sender: TObject;
  Button: TMouseButton;
  Shift: TShiftState;
  X, Y: Integer);
var
  encja: ListaEncji;
begin
  if Button = mbLeft then begin
    GetCursorPos(oldPos);
    oldPos := form1.ScreenToClient(oldPos);
    encja := encje^.nast;
    while encja <> nil do begin
      if (oldPos.X > encja^.punkt1.X) and
         (oldPos.X < encja^.punkt2.X) and
         (oldPos.Y > encja^.punkt1.Y) and
         (oldPos.Y < encja^.punkt2.Y) then
      begin
        inReposition := encja;
        SetCapture(Form1.Handle);
      end;
      encja := encja^.nast;
    end;
  end;
end;

{------------------------------------------------------------------------------}
//PORUSZANIE MYSZ¥
procedure TForm1.ControlMouseMove(Sender: TObject;
  Shift: TShiftState;
  X, Y: Integer);
var
  newPos: TPoint;
begin
  if inReposition <> nil then
  begin
    GetCursorPos(newPos);
    newPos := form1.ScreenToClient(newPos);
    Screen.Cursor := crSize;
    inReposition^.punkt1.X := inReposition^.punkt1.X - oldPos.X + newPos.X;
    inReposition^.punkt1.Y := inReposition^.punkt1.Y - oldPos.Y + newPos.Y;
    inReposition^.punkt2.X := inReposition^.punkt2.X - oldPos.X + newPos.X;
    inReposition^.punkt2.Y := inReposition^.punkt2.Y - oldPos.Y + newPos.Y;
    oldPos := newPos;
    RysujDiagram;
  end;
end;

{------------------------------------------------------------------------------}
//PUSZCZANIE KLAWISZA MYSZY
procedure TForm1.ControlMouseUp(
  Sender: TObject;
  Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if inReposition <> nil then
  begin
    Screen.Cursor := crDefault;
    ReleaseCapture;
    inReposition := nil;
  end;
end;

{------------------------------------------------------------------------------}
//PODWÓJNE KLIKNIÊCIE MYSZ¥
procedure TForm1.FormDblClick(Sender: TObject);
var
  pos: TPoint;
  encja: ListaEncji;
  found: ListaEncji;
  atrybut: ListaAtrybutow;
begin
  GetCursorPos(pos);
  pos := form1.ScreenToClient(pos);

  found := nil;
  encja := encje^.nast;
  while encja <> nil do begin
    if (pos.X > encja^.punkt1.X) and
       (pos.X < encja^.punkt2.X) and
       (pos.Y > encja^.punkt1.Y) and
       (pos.Y < encja^.punkt2.Y) then
    begin
      found := encja;
    end;
    encja := encja^.nast;
  end;
  if found <> nil then begin
    Form4.Show;
    Form4.Edit1.Text := found^.nazwa;
    atrybut := found^.atrybuty^.nast;
    while atrybut <> nil do begin
      Form4.ListBox1.Items.Append(atrybut^.nazwa);
      atrybut := atrybut^.nast;
    end;
    Form4.staraNazwa := found^.nazwa;
  end;
end;

{------------------------------------------------------------------------------}
//MENU -> NOWY PROJEKT
procedure TForm1.Nowyprojekt2Click(Sender: TObject);
var
  prostokat: TRect;
begin
  prostokat := Rect(0, 0, ClientWidth, ClientHeight);
  Canvas.Brush.Color := clWhite;
  Canvas.FillRect(prostokat);

  //Usuwanie wszystkich informacji
  encje^.nast := nil;
  zwiazki^.nast := nil;
end;

{------------------------------------------------------------------------------}
//MENU -> OTWÓRZ
procedure TForm1.OtworzClick(Sender: TObject);
var
  prostokat: TRect;
  f: TextFile;
  pom: String;
  encja, dodawanaEncja: ListaEncji;
  straznik, atrybut, dodawanyAtrybut: ListaAtrybutow;
  zwiazek, dodawanyZwiazek: ListaZwiazkow;
  x, y: Integer;
begin
  OpenDialog1.Execute;
  if OpenDialog1.FileName <> '' then begin
    //Czyszczenie formularza
    prostokat := Rect(0, 0, ClientWidth, ClientHeight);
    Canvas.Brush.Color := clWhite;
    Canvas.FillRect(prostokat);

    //Usuwanie wszystkich informacji
    encje^.nast := nil;
    zwiazki^.nast := nil;

    //Wczytywanie pliku
    AssignFile(f, OpenDialog1.FileName);
    Reset(f);
    encja := encje;
    zwiazek := zwiazki;
    while not eof(f) do begin
      Readln(f, pom);
      while pom <> '$' do begin
        //Wczytywanie encji
        new(dodawanaEncja);
        dodawanaEncja^.nazwa := pom;
        Readln(f, pom);
        //Wczytywanie atrybutów
        new(straznik);
        straznik^.nast := nil;
        dodawanaEncja^.atrybuty := straznik;
        atrybut := straznik;
        while pom <> '%' do begin
          new(dodawanyAtrybut);
          dodawanyAtrybut^.nazwa := pom;
          dodawanyAtrybut^.nast := atrybut^.nast;
          atrybut^.nast := dodawanyAtrybut;
          atrybut := atrybut^.nast;
          Readln(f, pom);
        end;

        //Wczytywanie pozosta³ych danych dla encji
        Readln(f, pom);
        dodawanaEncja^.liczba := StrToInt(pom);

        Readln(f, pom);
        x := StrToInt(pom);
        Readln(f, pom);
        y := StrToInt(pom);
        dodawanaEncja^.punkt1 := Point(x, y);

        Readln(f, pom);
        x := StrToInt(pom);
        Readln(f, pom);
        y := StrToInt(pom);
        dodawanaEncja^.punkt2 := Point(x, y);

        dodawanaEncja^.nast := encja^.nast;
        encja^.nast := dodawanaEncja;
        encja := encja^.nast;
        if not eof(f) then Readln(f, pom);
      end;
      while not eof(f) do begin
        //Dodawanie zwi¹zków
        new(dodawanyZwiazek);
        Readln(f, pom);
        dodawanyZwiazek^.encja1 := pom;
        Readln(f, pom);
        dodawanyZwiazek^.encja2 := pom;
        Readln(f, pom);
        dodawanyZwiazek^.nazwa := pom;
        Readln(f, pom);
        dodawanyZwiazek^.liczba1 := pom;
        Readln(f, pom);
        dodawanyZwiazek^.liczba2 := pom;
        Readln(f, pom);
        dodawanyZwiazek^.rola1 := pom;
        Readln(f, pom);
        dodawanyZwiazek^.rola2 := pom;

        dodawanyZwiazek^.nast := zwiazek^.nast;
        zwiazek^.nast := dodawanyZwiazek;
        zwiazek := zwiazek^.nast;
      end;
    end;
    CloseFile(f);
    RysujDiagram;
  end;
end;

{------------------------------------------------------------------------------}
//MENU -> ZAPISZ
procedure TForm1.ZapiszClick(Sender: TObject);
var
  f: TextFile;
  encja: ListaEncji;
  atrybut: ListaAtrybutow;
  zwiazek: ListaZwiazkow;
begin
  SaveDialog1.Execute;
  if SaveDialog1.FileName <> '' then begin
    AssignFile(f, SaveDialog1.FileName);
    Rewrite(f);
    //Zapisywanie encji
    encja := encje^.nast;
    while encja <> nil do begin
      writeln(f, encja^.nazwa);
      atrybut := encja^.atrybuty^.nast;
      while atrybut <> nil do begin
        writeln(f, atrybut^.nazwa);
        atrybut := atrybut^.nast
      end;
      writeln(f, '%');
      writeln(f, encja^.liczba);
      writeln(f, encja^.punkt1.X);
      writeln(f, encja^.punkt1.Y);
      writeln(f, encja^.punkt2.X);
      writeln(f, encja^.punkt2.Y);
      encja := encja^.nast;
    end;
    writeln(f, '$');
    zwiazek := zwiazki^.nast;
    while zwiazek <> nil do begin
      writeln(f, zwiazek^.encja1);
      writeln(f, zwiazek^.encja2);
      writeln(f, zwiazek^.nazwa);
      writeln(f, zwiazek^.liczba1);
      writeln(f, zwiazek^.liczba2);
      writeln(f, zwiazek^.rola1);
      writeln(f, zwiazek^.rola2);
      zwiazek := zwiazek^.nast;
    end;
    CloseFile(f);
  end;
end;

{------------------------------------------------------------------------------}
//MENU -> WYJŒCIE
procedure TForm1.Wyj1Click(Sender: TObject);
begin
  Form1.Close;
end;

{------------------------------------------------------------------------------}
//POMOC
procedure TForm1.Pomoc1Click(Sender: TObject);
begin
  Form5.Left := (Screen.Width div 2) - (Form5.Constraints.MaxWidth div 2);
  Form5.Top := (Screen.Height div 2) - (Form5.Constraints.MaxHeight div 2);
  Form5.Show;
end;

{------------------------------------------------------------------------------}
//POPUP MENU -> DODAWANIE ENCJI
procedure TForm1.Dodajencj1Click(Sender: TObject);
var
  pozycjaKursora: TPoint;
begin
  GetCursorPos(pozycjaKursora);
  Form2.Left := pozycjaKursora.X;
  Form2.Top := pozycjaKursora.Y;
  Form2.pozycjaKursora := pozycjaKursora;
  Form2.Show;
end;

{------------------------------------------------------------------------------}
//POPUP MENU -> DODAJ ZWI¥ZEK
procedure TForm1.ZwiazekClick(Sender: TObject);
var
  pozycjaKursora: TPoint;
  pomEncje: ListaEncji;
begin
  GetCursorPos(pozycjaKursora);
  Form3.Left := pozycjaKursora.X;
  Form3.Top := pozycjaKursora.y;
  Form3.Show;
  pomEncje := encje^.nast;
  while pomEncje <> nil do begin
    Form3.ComboBox1.Items.Add(pomEncje^.nazwa);
    Form3.ComboBox2.Items.Add(pomEncje^.nazwa);
    pomEncje := pomEncje^.nast;
  end;
end;

{------------------------------------------------------------------------------}
//POPUP MENU -> EDYTUJ ZWI¥ZEK
procedure TForm1.Edytujzwizek1Click(Sender: TObject);
var
  pozycjaKursora: TPoint;
  zwiazek: ListaZwiazkow;
  encja: ListaEncji;
begin
  GetCursorPos(pozycjaKursora);
  Form6.Left := pozycjaKursora.X;
  Form6.Top := pozycjaKursora.y;
  Form6.Show;
  //Przepisywanie zwi¹zków do formularza
  zwiazek := zwiazki^.nast;
  while zwiazek <> nil do begin
    Form6.ListBox1.Items.Append(zwiazek^.encja1 + ' - ' + zwiazek^.encja2);
    zwiazek := zwiazek^.nast;
  end;
  encja := encje^.nast;
  while encja <> nil do begin
    Form6.ComboBox1.Items.Append(encja^.nazwa);
    Form6.ComboBox2.Items.Append(encja^.nazwa);
    encja := encja^.nast;
  end;
end;

{------------------------------------------------------------------------------}
//RYSOWANIE LINII ZWI¥ZKÓW
procedure TForm1.RysujZwiazki;
var
  zwiazek: ListaZwiazkow;
  encja: ListaEncji;
  encja1, encja2: String;
  encja1punkt1, encja1punkt2, encja2punkt1, encja2punkt2: TPoint;
  opcja: Boolean;
begin
  zwiazek := zwiazki^.nast;
  while zwiazek <> nil do begin
    encja1 := zwiazek^.encja1;
    encja2 := zwiazek^.encja2;

    encja := encje^.nast;
    while (encja <> nil) and (encja^.nazwa <> encja1)
      do encja := encja^.nast;
    encja1punkt1 := encja^.punkt1;
    encja1punkt2 := encja^.punkt2;

    encja := encje^.nast;
    while (encja <> nil) and (encja^.nazwa <> encja2)
      do encja := encja^.nast;
    encja2punkt1 := encja^.punkt1;
    encja2punkt2 := encja^.punkt2;

    opcja :=
      abs(encja1punkt1.X-encja2punkt2.X) < abs(encja1punkt2.X-encja2punkt1.X);

    Canvas.Pen.Color := clBlack;
    Canvas.Pen.Width := 1;
    if opcja then begin
      Canvas.MoveTo(encja1punkt1.X-10,encja1punkt1.Y+10);
      Canvas.LineTo(encja1punkt1.X,encja1punkt1.Y+10);
      Canvas.TextOut(encja1punkt1.X-10,encja1punkt1.Y-5,zwiazek^.liczba1);
      Canvas.TextOut(encja1punkt1.X-5 - Length(zwiazek^.rola1) * 5,
                     encja1punkt1.Y+12,
                     zwiazek^.rola1);

      Canvas.MoveTo(encja2punkt2.X+10,encja2punkt1.Y+10);
      Canvas.LineTo(encja2punkt2.X,encja2punkt1.Y+10);
      Canvas.TextOut(encja2punkt2.X+5,encja2punkt1.Y-5,zwiazek^.liczba2);
      Canvas.TextOut(encja2punkt2.X+5,encja2punkt1.Y+12,zwiazek^.rola2);

      Canvas.MoveTo(encja1punkt1.X-10,encja1punkt1.Y+10);
      Canvas.LineTo(encja2punkt2.X+10,encja2punkt1.Y+10);

      Canvas.TextOut((encja1punkt1.X-10 + encja2punkt2.X+10) div 2,
                     ((encja1punkt1.Y+10 + encja2punkt1.Y+10) div 2)+2,
                      zwiazek^.nazwa);

    end
    else begin
      Canvas.MoveTo(encja1punkt2.X+10,encja1punkt1.Y+10);
      Canvas.LineTo(encja1punkt2.X,encja1punkt1.Y+10);
      Canvas.TextOut(encja1punkt2.X+5,encja1punkt1.Y-5,zwiazek^.liczba1);
      Canvas.TextOut(encja1punkt2.X+5,encja1punkt1.Y+12,zwiazek^.rola1);

      Canvas.MoveTo(encja2punkt1.X-10,encja2punkt1.Y+10);
      Canvas.LineTo(encja2punkt1.X,encja2punkt1.Y+10);
      Canvas.TextOut(encja2punkt1.X-10,encja2punkt1.Y-5,zwiazek^.liczba2);
      Canvas.TextOut(encja2punkt1.X-5 - Length(zwiazek^.rola2) * 5,
                     encja2punkt1.Y+12,
                     zwiazek^.rola2);

      Canvas.MoveTo(encja1punkt2.X+10,encja1punkt1.Y+10);
      Canvas.LineTo(encja2punkt1.X-10,encja2punkt1.Y+10);

      Canvas.TextOut((encja1punkt2.X+10 + encja2punkt1.X-10) div 2,
                     ((encja1punkt1.Y+10 + encja2punkt1.Y+10) div 2)+2,
                      zwiazek^.nazwa);

    end;
    zwiazek := zwiazek^.nast;
  end;
end;

{------------------------------------------------------------------------------}
//RYSOWANIE DIAGRAMU
procedure TForm1.RysujDiagram;
var
  encja: ListaEncji;
  pomAtrybuty: ListaAtrybutow;
  encjaProstokat: TRect;
  i: Integer;
begin
  //Czyszczenie formularza
  encjaProstokat := Rect(0, 0, ClientWidth, ClientHeight);
  Canvas.Brush.Color := clWhite;
  Canvas.FillRect(encjaProstokat);
  Canvas.Pen.Color := clBlack;

  //Rysowanie linii zwi¹zków
  RysujZwiazki;

  //Rysowanie encji
  encja := encje^.nast;
  while encja <> nil do begin

    //Panel encji
    encjaProstokat := Rect(encja^.punkt1, encja^.punkt2);
    Canvas.Brush.Color := clWhite;
    Canvas.FillRect(encjaProstokat);

    //Czarna krawêdŸ
    Canvas.Pen.Width := 2;
    Canvas.Rectangle(encjaProstokat);

    //Panel z nazw¹ encji
    encjaProstokat := Rect(encja^.punkt1.X, encja^.punkt1.Y,
                           encja^.punkt2.X, encja^.punkt1.Y + 35);
    Canvas.Brush.Color := clSilver;
    Canvas.FillRect(encjaProstokat);

    //Czarna krawêdŸ
    Canvas.Pen.Width := 2;
    Canvas.Rectangle(encjaProstokat);

    //Tekst z nazw¹ encji
    Canvas.TextOut(encja^.punkt1.X + 10, encja^.punkt1.Y + 10,
                   encja^.nazwa);

    //Panel z atrybutami
    Canvas.Brush.Color := clWhite;
    if (encja^.liczba <> 0) then begin
      i := 5;
      pomAtrybuty := encja^.atrybuty^.nast;
      while pomAtrybuty <> nil do begin
        Canvas.TextOut(encja^.punkt1.X + 10, encja^.punkt1.Y + 35 + i,
                       pomAtrybuty^.nazwa);
        i := i + 15;
        pomAtrybuty := pomAtrybuty^.nast;
      end;
    end;

    encja := encja^.nast;
  end; //Koniec rysowania encji
end;

end.
