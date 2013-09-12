{
#autor: Konrad S³oniewski
#data: 2012-05-10
}

unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses Unit1;

{------------------------------------------------------------------------------}
//ANULUJ
procedure TForm3.Button2Click(Sender: TObject);
begin
  ComboBox1.ItemIndex := -1;
  ComboBox2.ItemIndex := -1;
  ComboBox1.Clear;
  ComboBox2.Clear;
  ComboBox3.ItemIndex := -1;
  ComboBox4.ItemIndex := -1;
  Edit1.Text := '';
  Edit2.Text := '';
  Edit3.Text := '';
  Form3.Close;
end;

{------------------------------------------------------------------------------}
//DODAJ ZWI¥ZEK
procedure TForm3.Button1Click(Sender: TObject);
var
  pomZwiazki, dodawanyZwiazek: ListaZwiazkow;
  jest: boolean;
begin
  if (ComboBox1.ItemIndex = -1) or (ComboBox2.ItemIndex = -1) then
    ShowMessage('B£¥D: Nie wybrano pary encji.')
  else if ComboBox1.ItemIndex = ComboBox2.ItemIndex then
    ShowMessage('B£¥D: Wybierz dwie ró¿ne encje.')
  else begin
    //Sprawdzenie czy zwi¹zek miêdzy encjami ju¿ istnieje
    pomZwiazki := zwiazki^.nast;
    jest := false;
    while pomZwiazki <> nil do begin
      if ((pomZwiazki^.encja1 = ComboBox1.Text) and
         (pomZwiazki^.encja2 = ComboBox2.Text)) or
         ((pomZwiazki^.encja1 = ComboBox2.Text) and
         (pomZwiazki^.encja2 = ComboBox1.Text))
      then jest := true;
      pomZwiazki := pomZwiazki^.nast;
    end;
    if not jest then begin
      pomZwiazki := zwiazki;
      while pomZwiazki^.nast <> nil do pomZwiazki := pomZwiazki^.nast;
      new(dodawanyZwiazek);
      dodawanyZwiazek^.encja1 := ComboBox1.Text;
      dodawanyZwiazek^.encja2 := ComboBox2.Text;
      dodawanyZwiazek^.nazwa := Edit1.Text;
      dodawanyZwiazek^.liczba1 := ComboBox3.Text;
      dodawanyZwiazek^.liczba2 := ComboBox4.Text;
      dodawanyZwiazek^.rola1 := Edit2.Text;
      dodawanyZwiazek^.rola2 := Edit3.Text;
      dodawanyZwiazek^.nast := pomZwiazki^.nast;
      pomZwiazki^.nast := dodawanyZwiazek;

      ComboBox1.ItemIndex := -1;
      ComboBox2.ItemIndex := -1;
      ComboBox1.Clear;
      ComboBox2.Clear;
      ComboBox3.ItemIndex := -1;
      ComboBox4.ItemIndex := -1;
      Edit1.Text := '';
      Edit2.Text := '';
      Edit3.Text := '';
      Form1.RysujDiagram;
      Form3.Close;
    end
    else ShowMessage('B£¥D: Zwi¹zek miêdzy wybranymi relacjami ju¿ istnieje');
  end;
end;

end.
