{
 author: Konrad S³oniewski, ks321221
 data: 15-06-2012
 wersja: 2.3
}
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Image1: TImage;
    Label1: TLabel;
    Button4: TButton;
    Button5: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2, Unit3, Unit4, Unit7, Unit6;

{$R *.dfm}
{------------------------------------------------------------------------------}
//TWORZENIE FORMULARZA
procedure TForm1.FormCreate(Sender: TObject);
var
  l: DWORD;
begin
  //Wy³¹czenie opcji maksymalizacji okna
  l := GetWindowLong(Self.Handle, GWL_STYLE);
  l := l and not(WS_MAXIMIZEBOX);
  SetWindowLong(Self.Handle, GWL_STYLE, l);

  //Wyœrodkowanie formularza
  Left := (Screen.Width div 2) - (Width div 2);
  Top := (Screen.Height div 2) - (Height div 2);
end;

{------------------------------------------------------------------------------}
//USTAWIENIA
procedure TForm1.Button2Click(Sender: TObject);
begin
  Form2.Show;
  Form1.Visible := false;
end;

{------------------------------------------------------------------------------}
//NOWA GRA
procedure TForm1.Button1Click(Sender: TObject);
begin
  Form3.trybGry := Form2.ComboBox1.ItemIndex;
  Form3.poziom := Form2.ComboBox2.ItemIndex;
  Form3.rozmiar := Form2.UpDown1.Position;
  Form3.kolory := Form2.UpDown2.Position;
  Form3.prawdJoker := Form2.UpDown3.Position;
  Form3.prawdKameleon := Form2.UpDown4.Position;
  Form3.prawdBonus := Form2.UpDown5.Position;
  Form3.prawdCzaszka := Form2.UpDown6.Position;
  Form3.prawdKlepsydra := Form2.UpDown7.Position;

  //Dopasowanie rozmiaru okna do liczby kulek
  Form3.ClientWidth := 125 + Form3.rozmiar*40;
  Form3.ClientHeight := 15 + Form3.rozmiar*40;

  //Wyœrodkowanie formularza do gry
  Form3.Left := (Screen.Width div 2) - (Form3.Width div 2);
  Form3.Top := (Screen.Height div 2) - (Form3.Height div 2);

  Form3.Show;
  Form1.Visible := false;
end;

{------------------------------------------------------------------------------}
//WYJŒCIE
procedure TForm1.Button3Click(Sender: TObject);
begin
  Application.Terminate;
end;

{------------------------------------------------------------------------------}
//ZASADY GRY
procedure TForm1.Button4Click(Sender: TObject);
begin
  //Wyœrodkowanie formularza
  Form4.Left := (Screen.Width div 2) - (Form7.Width div 2);
  Form4.Top := (Screen.Height div 2) - (Form7.Height div 2);
  Form4.Show;
  Form1.Visible := false;
end;

{------------------------------------------------------------------------------}
//NAJLEPSZE WYNIKI
procedure TForm1.Button5Click(Sender: TObject);
begin
  //Wyœrodkowanie formularza
  Form7.Left := (Screen.Width div 2) - (Form7.Width div 2);
  Form7.Top := (Screen.Height div 2) - (Form7.Height div 2);
  Form7.Show;
  Form1.Visible := false;
end;

end.
