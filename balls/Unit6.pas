{
 author: Konrad S³oniewski, ks321221
 data: 15-06-2012
 wersja: 2.3
}
unit Unit6;

interface

uses
  Math, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm6 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    wynik: Integer;
    pozycja: Integer;
    joker, kameleon, bonus, czaszka, klepsydra: Integer;
  end;

var
  Form6: TForm6;

implementation

uses Unit7;

{$R *.dfm}

{------------------------------------------------------------------------------}
//TWORZENIE FORMULARZA
procedure TForm6.FormCreate(Sender: TObject);
var
  l: DWORD;
begin
  //Wy³¹czenie opcji maksymalizacji okna
  l := GetWindowLong(Self.Handle, GWL_STYLE);
  l := l and not(WS_MAXIMIZEBOX);
  SetWindowLong(Self.Handle, GWL_STYLE, l);

  //Wy³¹czenie opcji zamykania okna
  EnableMenuItem( GetSystemMenu( handle, False ),SC_CLOSE, MF_BYCOMMAND
    or MF_GRAYED );
end;

{------------------------------------------------------------------------------}
//POKAZYWANIE FORMULARZA
procedure TForm6.FormShow(Sender: TObject);
var
  przeliczonyWynik: double;
  i: Integer;
  szukaj: boolean;
begin
  pozycja := 0;

  //Przeliczanie wyniku
  Label2.Caption := IntToStr(wynik);
  przeliczonyWynik := wynik * Power(0.9, joker) * Power(1.05, kameleon) *
    Power(0.8, bonus) * Power(1.2, czaszka) * Power(1.1, klepsydra);
  wynik := round(przeliczonyWynik);
  Label4.Caption := IntToStr(wynik);

  //Sprawdzanie czy wynik kwalifikuje siê do listy najlepszych wyników
  i := 1;
  szukaj:= true;
  while (i <= 20) and szukaj do begin
    if wynik > StrToInt(Form7.wyniki[i].Caption) then begin
      szukaj := false;
      Label5.Visible := true;
      Label6.Visible := true;
      Edit1.Visible := true;
      pozycja := i;
    end;
    inc(i);
  end;
end;

{------------------------------------------------------------------------------}
//PRZYCISK OK
procedure TForm6.Button1Click(Sender: TObject);
begin
  if (pozycja <> 0) then Form7.dodajZawodnika(pozycja, Edit1.Text,
    IntToStr(wynik));
  Form6.Close;

  //Wyœrodkowanie formularza
  Form7.Left := (Screen.Width div 2) - (Form7.Width div 2);
  Form7.Top := (Screen.Height div 2) - (Form7.Height div 2);
  Form7.Show;
end;

end.
