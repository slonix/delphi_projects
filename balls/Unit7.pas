{
 author: Konrad S³oniewski, ks321221
 data: 15-06-2012
 wersja: 2.3
}
unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm7 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dodajZawodnika(numer: Integer; nazwa, wynik: String);
  private
    { Private declarations }
  public
    { Public declarations }
    numery, nazwy, wyniki: array[1..20] of TLabel;
  end;

var
  Form7: TForm7;

implementation

uses Unit1;

{$R *.dfm}

{------------------------------------------------------------------------------}
//TWORZENIE FORMULARZA
procedure TForm7.FormCreate(Sender: TObject);
var
  f: TextFile;
  i: Integer;
  pom: String;
  pomLabel: TLabel;
  left, top: Integer;
begin
  left := 16;
  top := 50;
  try
    AssignFile(f, 'wyniki.db');
    Reset(f);

    //Wypisywanie numerów
    for i := 1 to 20 do begin
      pomLabel := TLabel.Create(self);
      pomLabel.Parent := self;
      pomLabel.Caption := IntToStr(i)+'.';
      pomLabel.Font.Size := 12;
      pomLabel.Left := left;
      pomLabel.Top := top;
      pomLabel.BringToFront;
      top := top + 24;
      numery[i] := pomLabel;
    end;

    //Wypisywanie nazw graczy
    top := 50;
    left := 50;
    for i := 1 to 20 do begin
      Readln(f, pom);
      pomLabel := TLabel.Create(self);
      pomLabel.Parent := self;
      pomLabel.Caption := pom;
      pomLabel.Font.Size := 12;
      pomLabel.Left := left;
      pomLabel.Top := top;
      pomLabel.BringToFront;
      top := top + 24;
      nazwy[i] := pomLabel;
    end;

    //Wypisywanie wyników graczy
    top := 50;
    left := ClientWidth - 70;
    for i := 1 to 20 do begin
      Readln(f, pom);
      pomLabel := TLabel.Create(self);
      pomLabel.Parent := self;
      pomLabel.Caption := pom;
      pomLabel.Font.Size := 12;
      pomLabel.Left := left;
      pomLabel.Top := top;
      pomLabel.BringToFront;
      top := top + 24;
      wyniki[i] := pomLabel;
    end;

    CloseFile(f);
  except
    CloseFile(f);
  End;
end;

{------------------------------------------------------------------------------}
//PROCEDURA DODAJ¥CA ZAWODNIKA DO LISTY
procedure TForm7.dodajZawodnika(numer: Integer; nazwa, wynik: String);
begin
  if numer <= 20 then begin
    dodajZawodnika(numer+1, nazwy[numer].Caption, wyniki[numer].Caption);
    nazwy[numer].Caption := nazwa;
    wyniki[numer].Caption := wynik;
  end;
end;

{------------------------------------------------------------------------------}
//PRZYCISK OK
procedure TForm7.Button1Click(Sender: TObject);
begin
  Form7.Close;
end;

{------------------------------------------------------------------------------}
//ZAMYKANIE FORMULARZA
procedure TForm7.FormClose(Sender: TObject; var Action: TCloseAction);
var
  f: TextFile;
  i: Integer;
  pom: String;
  pomLabel: TLabel;
  left, top: Integer;
begin
  try
    AssignFile(f, 'wyniki.db');
    Rewrite(f);

    //Zapisywanie nazw graczy
    for i := 1 to 20 do
      Writeln(f, nazwy[i].Caption);

    //Zapisywanie wyników graczy
    for i := 1 to 20 do
      Writeln(f, wyniki[i].Caption);

    CloseFile(f);
  except
    CloseFile(f);
  End;
  Form1.Visible := true;
end;

end.
