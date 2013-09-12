{
 author: Konrad S³oniewski, ks321221
 data: 15-06-2012
 wersja: 2.3
}
unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm5 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses Unit3, Unit1, Unit6;

{$R *.dfm}

{------------------------------------------------------------------------------}
//PRZYCISK TAK
procedure TForm5.Button1Click(Sender: TObject);
begin
  Form5.Close;
  Form3.Enabled := true;
  if Form3.trybGry = 0 then begin
    //Wyœrodkowanie formularza
    Form6.Left := (Screen.Width div 2) - (Form6.Width div 2);
    Form6.Top := (Screen.Height div 2) - (Form6.Height div 2);

    Form6.wynik := Form3.wynik1;
    Form6.joker := Form3.prawdJoker;
    Form6.kameleon := Form3.prawdKameleon;
    Form6.bonus := Form3.prawdBonus;
    Form6.czaszka := Form3.prawdCzaszka;
    Form6.klepsydra := Form3.prawdKlepsydra;
    Form6.Show;
    Form3.Close;
    Form1.Visible := false;
  end
  else begin
    Form3.Close;
    Form1.Visible := true;
  end;
end;

{------------------------------------------------------------------------------}
//PRZYCISK NIE
procedure TForm5.Button2Click(Sender: TObject);
begin
  Form5.Close;
end;

{------------------------------------------------------------------------------}
//TWORZENIE FORMULARZA
procedure TForm5.FormCreate(Sender: TObject);
var
  l: DWORD;
begin
  //Wy³¹czenie opcji maksymalizacji okna
  l := GetWindowLong(Self.Handle, GWL_STYLE);
  l := l and not(WS_MAXIMIZEBOX);
  SetWindowLong(Self.Handle, GWL_STYLE, l);
end;

{------------------------------------------------------------------------------}
//ZAMYKANIE FORMULARZA
procedure TForm5.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form3.Enabled := true;
end;

{------------------------------------------------------------------------------}
//POKAZYWANIE FORMULARZA
procedure TForm5.FormShow(Sender: TObject);
begin
  Form3.Enabled := false;
end;

end.
