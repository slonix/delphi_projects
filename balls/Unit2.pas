{
 author: Konrad S³oniewski, ks321221
 data: 15-06-2012
 wersja: 2.3
}
unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label2: TLabel;
    Edit2: TEdit;
    UpDown2: TUpDown;
    Edit3: TEdit;
    UpDown3: TUpDown;
    BitBtn1: TBitBtn;
    Label5: TLabel;
    ComboBox1: TComboBox;
    Label6: TLabel;
    ComboBox2: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Image18: TImage;
    Image19: TImage;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    UpDown4: TUpDown;
    Edit4: TEdit;
    UpDown5: TUpDown;
    Edit5: TEdit;
    UpDown6: TUpDown;
    Edit6: TEdit;
    UpDown7: TUpDown;
    Edit7: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBox1Select(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.dfm}

{------------------------------------------------------------------------------}
//TWORZENIE FORMULARZA
procedure TForm2.FormCreate(Sender: TObject);
var
  l: DWORD;
begin
  //Wy³¹czenie opcji maksymalizacji okna
  l := GetWindowLong(Self.Handle, GWL_STYLE);
  l := l and not(WS_MAXIMIZEBOX);
  SetWindowLong(Self.Handle, GWL_STYLE, l);

  //Wyœrodkowanie formularza
  Left := (Screen.Width div 2) - (Constraints.MaxWidth div 2);
  Top := (Screen.Height div 2) - (Constraints.MaxHeight div 2);
end;

{------------------------------------------------------------------------------}
//PRZYCISK OK
procedure TForm2.BitBtn1Click(Sender: TObject);
begin
  Form2.Close;
  Form1.Visible := true;
end;

{------------------------------------------------------------------------------}
//ZZAMYKANIE FORMULARZA
procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form1.Visible := true;
end;

{------------------------------------------------------------------------------}
//ZALE¯NOŒÆ MO¯LIWOŒCI WYBORU POZIOMU KOMPUTERA
procedure TForm2.ComboBox1Select(Sender: TObject);
begin
  ComboBox2.Enabled := ComboBox1.ItemIndex = 2;
end;

{------------------------------------------------------------------------------}
//ZMIANA ROZMIARU PLANSZY
procedure TForm2.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
  if UpDown1.Position > 14 then UpDown2.Min := 5
  else if UpDown1.Position > 9 then UpDown2.Min := 4
  else if UpDown1.Position > 4 then UpDown2.Min := 3
  else UpDown2.Min := 2;

  UpDown2.Position := UpDown2.Min;
end;

end.
