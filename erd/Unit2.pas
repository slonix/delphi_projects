{
#autor: Konrad S³oniewski
#data: 2012-05-10
}

unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type


  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    ListBox1: TListBox;
    Label3: TLabel;
    Button1: TButton;
    Edit2: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    pozycjaKursora: TPoint;
  end;

var
  Form2: TForm2;

implementation

uses Unit1, Types;

{$R *.dfm}

{------------------------------------------------------------------------------}
//ANULUJ
procedure TForm2.Button2Click(Sender: TObject);
begin
  Edit1.Text := '';
  Edit2.Text := '';
  ListBox1.Items.Clear;
  Form2.Close;
end;

{------------------------------------------------------------------------------}
//DODAJ ATRYBUT
procedure TForm2.Button1Click(Sender: TObject);
begin
  if Edit2.Text <> '' then begin
    ListBox1.Items.Append(Edit2.Text);
    Edit2.Text := '';
  end
  else ShowMessage('B£¥D: Podaj nazwê atrybutu.');
end;

{------------------------------------------------------------------------------}
//USUÑ ZAZNACZONY ATRYBUT
procedure TForm2.Button3Click(Sender: TObject);
begin
  ListBox1.DeleteSelected;
end;

{------------------------------------------------------------------------------}
//DODAJ
procedure TForm2.Button4Click(Sender: TObject);
var
  pom: ListaEncji;
  dodawanaEncja: String;
  nowaEncja: ListaEncji;
  atrybutyLista: ListaAtrybutow;
  pomAtryb: ListaAtrybutow;
  dodawanyAtrybut: ListaAtrybutow;
  i, j: Integer;
begin
  dodawanaEncja := Edit1.Text;
  if dodawanaEncja = '' then
    ShowMessage('B£¥D: Nazwa encji nie mo¿e by pusta.')
  else begin
    pom := encje;
    while (pom^.nast <> nil) and (pom^.nast^.nazwa <> dodawanaEncja)
      do pom := pom^.nast;
    if pom^.nast = nil then begin
      new(nowaEncja);
      nowaEncja^.nazwa := dodawanaEncja;
      nowaEncja^.nast := pom^.nast;
      pom^.nast := nowaEncja;

      //Tworzenie stra¿nika listy atrybutów
      new(atrybutyLista);
      atrybutyLista^.nazwa := '#pusty';
      atrybutyLista^.nast := nil;
      //Dodawanie atrybutów do listy
      pomAtryb := atrybutyLista;
      while (pomAtryb^.nast <> nil) do pomAtryb := pomAtryb^.nast;
      j := 0;
      if ListBox1.Items.Count <> 0 then begin
        for i := 0 to ListBox1.Items.Count-1 do begin
          new(dodawanyAtrybut);
          dodawanyAtrybut^.nazwa := ListBox1.Items.Strings[i];
          dodawanyAtrybut^.nast := pomAtryb^.nast;
          pomAtryb^.nast := dodawanyAtrybut;
          pomAtryb := pomAtryb^.nast;
          inc(j);
        end;
      end;
      nowaEncja^.atrybuty := atrybutyLista;
      nowaEncja^.liczba := j;
      nowaEncja^.punkt1 := pozycjaKursora;
      nowaEncja^.punkt2 := Point(pozycjaKursora.X+150,
                                 pozycjaKursora.Y+45+15*nowaEncja^.liczba);

      Edit1.Text := '';
      Edit2.Text := '';
      ListBox1.Items.Clear;
      Form1.RysujDiagram;
      Form2.Close;
    end
    else //wyœwietla komunikat o b³êdzie
      ShowMessage('B£¥D: Encja o podanej nazwie ju¿ istnieje.');
  end;
end;

end.
