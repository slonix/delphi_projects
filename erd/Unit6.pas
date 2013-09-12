{
#autor: Konrad S³oniewski
#data: 2012-05-10
}

unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, StdCtrls, Unit1;

type
  TForm6 = class(TForm)
    ListBox1: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label5: TLabel;
    Edit1: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Label8: TLabel;
    Label9: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;
  zwiazek: ListaZwiazkow;

implementation

{$R *.dfm}

{------------------------------------------------------------------------------}
//ANULUJ
procedure TForm6.Button2Click(Sender: TObject);
begin
  ListBox1.Clear;
  ComboBox1.Text := '';
  ComboBox2.Text := '';
  Edit1.Clear;
  ComboBox3.Text := '';
  ComboBox4.Text := '';
  Edit2.Clear;
  Edit3.Clear;
  Form6.Close;
end;

{------------------------------------------------------------------------------}
//ZAZNECZENIE POLA W LIŒCIE ZWI¥ZKÓW
procedure TForm6.ListBox1Click(Sender: TObject);
var
  i: Integer;
begin
  if ListBox1.ItemIndex <> -1 then begin
    i := ListBox1.ItemIndex;
    zwiazek := zwiazki^.nast;
    while i > 0 do begin
      zwiazek := zwiazek^.nast;
      dec(i)
    end;
    ComboBox1.Text := zwiazek^.encja1;
    ComboBox2.Text := zwiazek^.encja2;
    Edit1.Text := zwiazek^.nazwa;
    ComboBox3.Text := zwiazek^.liczba1;
    ComboBox4.Text := zwiazek^.liczba2;
    Edit2.Text := zwiazek^.rola1;
    Edit3.Text := zwiazek^.rola2;
  end;
end;

{------------------------------------------------------------------------------}
//ZAPISYWANIE ZMIAN
procedure TForm6.Button1Click(Sender: TObject);
begin
  if (ComboBox1.Text = '') or (ComboBox2.Text = '') then
    ShowMessage('B£¥D: Nazwy encji nie mog¹ byæ puste.')
  else if ComboBox1.Text = ComboBox2.Text then
    ShowMessage('B£¥D: Nazwy encji nie mog¹ byæ jednakowe.')
  else begin
    zwiazek^.encja1 := ComboBox1.Text;
    zwiazek^.encja2 := ComboBox2.Text;
    zwiazek^.nazwa := Edit1.Text;
    zwiazek^.liczba1 := ComboBox3.Text;
    zwiazek^.liczba2 := ComboBox4.Text;
    zwiazek^.rola1 := Edit2.Text;
    zwiazek^.rola2 := Edit3.Text;

    //Zamykanie formularza
    ListBox1.Clear;
    ComboBox1.Text := '';
    ComboBox2.Text := '';
    Edit1.Clear;
    ComboBox3.Text := '';
    ComboBox4.Text := '';
    Edit2.Clear;
    Edit3.Clear;
    Form1.RysujDiagram;
    Form6.Close;
  end
end;

{------------------------------------------------------------------------------}
//USUÑ ZAZNACZONY ZWI¥ZEK
procedure TForm6.Button3Click(Sender: TObject);
var
  poprzedni: ListaZwiazkow;
begin
  ListBox1.DeleteSelected;
  poprzedni := zwiazki;
  while poprzedni^.nast <> zwiazek do poprzedni := poprzedni^.nast;
  poprzedni^.nast := zwiazek^.nast;
  zwiazek := nil;

  //Zamykanie formularza
  ListBox1.Clear;
  ComboBox1.Text := '';
  ComboBox2.Text := '';
  Edit1.Clear;
  ComboBox3.Text := '';
  ComboBox4.Text := '';
  Edit2.Clear;
  Edit3.Clear;
  Form1.RysujDiagram;
  Form6.Close;
end;

end.
