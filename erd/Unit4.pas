{
#autor: Konrad S³oniewski
#data: 2012-05-10
}

unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm4 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    ListBox1: TListBox;
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
    staraNazwa: String;
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

uses Unit1;

{------------------------------------------------------------------------------}
//ANULUJ
procedure TForm4.Button2Click(Sender: TObject);
begin
  Edit1.Text := '';
  Edit2.Text := '';
  ListBox1.Clear;
  Form4.staraNazwa := '';
  Form4.Close;
end;

{------------------------------------------------------------------------------}
//DODAJ ATRYBUT
procedure TForm4.Button1Click(Sender: TObject);
begin
  if Edit2.Text <> '' then begin
    ListBox1.Items.Append(Edit2.Text);
    Edit2.Text := '';
  end
  else ShowMessage('B£¥D: Podaj nazwê atrybutu.');
end;

{------------------------------------------------------------------------------}
//USUÑ ZAZNACZONY ATRYBUT
procedure TForm4.Button3Click(Sender: TObject);
begin
  ListBox1.DeleteSelected;
end;

{------------------------------------------------------------------------------}
//ZAPISZ ZMIANY
procedure TForm4.Button4Click(Sender: TObject);
var
  encja, nowaEncja, usun: ListaEncji;
  straznik, atrybut: ListaAtrybutow;
  dodawanyAtrybut: ListaAtrybutow;
  zwiazek: ListaZwiazkow;
  i, j: Integer;
begin
  if Edit1.Text = '' then
    ShowMessage('B£¥D: Nazwa encji nie mo¿e by pusta.')
  else begin
    //Sprawdzanie czy encja o podanej nazwie ju¿ istnieje
    encja := encje;
    while (encja^.nast <> nil) and (encja^.nast^.nazwa <> Edit1.Text)
      do encja := encja^.nast;
    if (encja^.nast = nil) or (Edit1.Text = staraNazwa) then begin
      encja := encje;

      //Szukanie starej encji
      while (encja^.nast <> nil) and (encja^.nast^.nazwa <> staraNazwa)
        do encja := encja^.nast;

      //Tworzenie nowej encji
      new(nowaEncja);
      nowaEncja^.nazwa := Edit1.Text;
      //Tworzenie stra¿nika listy atrybutów
      new(straznik);
      straznik^.nast := nil;
      //Dodawanie atrybutów do listy
      atrybut := straznik;
      j := 0;
      if ListBox1.Items.Count <> 0 then begin
        for i := 0 to ListBox1.Items.Count-1 do begin
          new(dodawanyAtrybut);
          dodawanyAtrybut^.nazwa := ListBox1.Items.Strings[i];
          dodawanyAtrybut^.nast := atrybut^.nast;
          atrybut^.nast := dodawanyAtrybut;
          atrybut := atrybut^.nast;
          inc(j);
        end;
      end;
      nowaEncja^.atrybuty := straznik;
      nowaEncja^.liczba := j;
      nowaEncja^.punkt1 := encja^.nast^.punkt1;
      nowaEncja^.punkt2 :=
        Point(encja^.nast^.punkt2.X,
              encja^.nast^.punkt2.Y - 15*encja^.nast^.liczba
                                    + 15*nowaEncja^.liczba);

      //Usuniêcie starej i wstawienie nowej encji
      usun := encja^.nast;
      nowaEncja^.nast := encja^.nast^.nast;
      encja^.nast := nowaEncja;
      Dispose(usun);

      //Zmiana zwi¹zków
      zwiazek := zwiazki^.nast;
      while zwiazek <> nil do begin
        if zwiazek^.encja1 = staraNazwa then zwiazek^.encja1 := Edit1.Text;
        if zwiazek^.encja2 = staraNazwa then zwiazek^.encja2 := Edit1.Text;
        zwiazek := zwiazek^.nast;
      end;

      Edit1.Text := '';
      Edit2.Text := '';
      ListBox1.Items.Clear;
      Form4.staraNazwa := '';
      Form1.RysujDiagram;
      Form4.Close;
    end
    else ShowMessage('B£¥D: Encja o podanej nazwie ju¿ istnieje.');
  end;
end;

end.
