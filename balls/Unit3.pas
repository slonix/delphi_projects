{
 author: Konrad S³oniewski, ks321221
 data: 15-06-2012
 wersja: 2.3
}
unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TKulka = record
    obraz: TImage;
    punkt: TPoint;
    kolor: Integer;
    puste: boolean;
    X: Integer;
    Y: Integer;
    joker: boolean;
    kameleon: boolean;
    bonus: boolean;
    czaszka: boolean;
    klepsydra: boolean;
    klepsydraPunkty: Integer
  end;

  TListaRuchow = ^ElementListy;
  ElementListy = record
    zaznaczX, zaznaczY, dobierzX, dobierzY: Integer;
    nast: TListaRuchow;
  end;

  TForm3 = class(TForm)
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Image1: TImage;
    Image2: TImage;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ZamienKolor();
    procedure UsunCiagi();
    procedure PrzypiszKulke(x, y: Integer; zaznaczona: boolean);
    procedure Delay(msecs:integer);
    procedure Obsun();
    procedure LosujNowe();
    procedure FormCreate(Sender: TObject);
    procedure ZmienGracza();
    function ZamienKolory(x1, y1, x2, y2: Integer; zmienRysunek: boolean): boolean;
    procedure LatwyRuchKomputera();
    procedure TrudnyRuchKomputera();
    function JestRuch(): boolean;
  private
    { Private declarations }
    procedure CustomImageClick(Sender: TObject);
  public
    { Public declarations }
    trybGry: Integer;
    poziom: Integer;
    rozmiar: Integer;
    kolory: Integer;
    prawdJoker, prawdKameleon, prawdBonus, prawdCzaszka, prawdKlepsydra: Integer;
    kulkaWybrana: boolean;
    zaznaczonaKulka: ^TKulka;
    dobranaKulka: ^TKulka;
    aktualnyGracz: Integer;
    zamknij: boolean;
    wynik1, wynik2: Integer;
    koniecGry: boolean;
  end;

var
  Form3: TForm3;
  Canvas: TCanvas;
  tablica: array of array of TKulka;
  odswiez: boolean;
  zezwalaj: boolean;
  wystapilaCzaszka: boolean;
  zdobytePunkty: Integer;
  skumulowanyMnoznik: Integer;
implementation

uses Unit2, Unit1, Unit5;

{$R *.dfm}

{------------------------------------------------------------------------------}
//TWORZENIE FORMULARZA
procedure TForm3.FormCreate(Sender: TObject);
var
  l: DWORD;
begin
  //Wy³¹czenie opcji maksymalizacji okna
  l := GetWindowLong(Self.Handle, GWL_STYLE);
  l := l and not(WS_MAXIMIZEBOX);
  SetWindowLong(Self.Handle, GWL_STYLE, l);

  Label4.Visible := false;
  Label7.Visible := false;
end;

{------------------------------------------------------------------------------}
//WYŒWIETLANIE FORMULARZA
procedure TForm3.FormShow(Sender: TObject);

  //Funkcja pomocnicza sprawdzaj¹ca czy dobrany zosta³ odpowiedni kolor
  function czyOdpowiedniKolor(i, j, kolor: Integer): boolean;
  var
    poprawny: boolean;
  begin
    poprawny := true;
    if j-2 >= 0 then
      if ((tablica[i,j-2].kolor = kolor) or tablica[i,j-2].joker) and
        ((tablica[i,j-1].kolor = kolor) or tablica[i,j-1].joker) then
        poprawny := false;
    if i-2 >= 0 then
      if ((tablica[i-2,j].kolor = kolor) or tablica[i-2,j].joker) and
      ((tablica[i-1,j].kolor = kolor) or tablica[i-1,j].joker) then
        poprawny := false;
    czyOdpowiedniKolor := poprawny;
  end;


  //Funkcja pomocnicza sprawdzaj¹ca czy wylosowany joker jest w dobrym miejscu
  function czyOdpowiedniaSytuacjaJokera(i, j: Integer): boolean;
  var
    odpowiednia: boolean;
  begin
    odpowiednia := true;
    if j-2 >= 0 then
      if (tablica[i,j-2].kolor = tablica[i,j-1].kolor) or tablica[i,j-2].joker
      or tablica[i,j-1].joker then
        odpowiednia := false;
    if i-2 >= 0 then
      if (tablica[i-2,j].kolor = tablica[i-1,j].kolor) or tablica[i-2,j].joker
      or tablica[i-1,j].joker then
        odpowiednia := false;
    czyOdpowiedniaSytuacjaJokera := odpowiednia;
  end;

var
  nowaKulka: TImage;
  kulka: TKulka;
  dobranyKolor: Integer;
  i,j,s: Integer;
  top, left: Integer;
  odpowiedniKolor: boolean;
  specjalne: array[0..4] of boolean;
  wylosowanaSpecjalna: Integer;
  wylosowanePrawd: Integer;
  prawdopodobienstwo: Integer;
  specjalna: boolean;
  petla: Integer;

label losowanie1, losowanie2;

begin
  DoubleBuffered := true;
  Randomize;
  zamknij := false;
  aktualnyGracz := 1;
  kulkaWybrana := false;
  zezwalaj := true;
  koniecGry := false;
  wynik1 := 0;
  wynik2 := 0;
  Label3.Caption := IntToStr(wynik1);
  Label7.Caption := IntToStr(wynik2);

  //Wyœwietlanie bocznych informacji
  Label1.Font.Color := clHighlight;
  Label4.Font.Color := clWindowText;
  Label4.Visible := false;
  Label7.Visible := false;
  if trybGry = 0 then
    Label1.Caption := 'Wynik'
  else if trybGry = 1 then begin
    Label1.Caption := 'Gracz 1';
    Label4.Caption := 'Gracz 2';
    Label4.Visible := true;
    Label7.Visible := true;
  end
  else if trybGry = 2 then begin
    Label1.Caption := 'Gracz';
    Label4.Caption := 'Komputer';
    Label4.Visible := true;
    Label7.Visible := true;
  end;

  //Tworzenie tablicy n x n
  SetLength(tablica, rozmiar);
  for i := 0 to rozmiar-1 do
    SetLength(tablica[i], rozmiar);

  //Czyszczenie obrazów w tablicy
  for i := 0 to rozmiar - 1 do begin
    for j := 0 to rozmiar - 1 do begin
      nowaKulka := TImage.Create(self);
      kulka.obraz := nowaKulka;
      kulka.obraz.Picture.LoadFromFile('pic/kulka0.bmp');
      tablica[i,j] := kulka;
    end;
  end;

  losowanie1:
  //Wype³nianie tablicy kulkami
  for i := 0 to rozmiar-1 do begin
    for j := 0 to rozmiar-1 do begin

      losowanie2:
      //Losowanie kulek specjalnych
      for s := 0 to 4 do specjalne[s] := false;
      specjalna := false;
      wylosowanaSpecjalna := random(5);
      prawdopodobienstwo := 0;
      case wylosowanaSpecjalna of
        0: prawdopodobienstwo := prawdJoker;
        1: prawdopodobienstwo := prawdKameleon;
        2: prawdopodobienstwo := prawdBonus;
        3: prawdopodobienstwo := prawdCzaszka;
        4: prawdopodobienstwo := prawdKlepsydra;
      end;
      wylosowanePrawd := random(100)+1;
      if (prawdopodobienstwo > 0) and (wylosowanePrawd <= prawdopodobienstwo)
        then specjalna := true;

      //Tworzenie nowej kulki
      petla := 0;
      nowaKulka := TImage.Create(self);
      dobranyKolor := 1;
      with nowaKulka do begin
        Parent := self;
        odpowiedniKolor := false;

        //Jakakolwiek kulka inna ni¿ joker
        if wylosowanaSpecjalna <> 0 then begin
          while (not odpowiedniKolor) and (petla < 100) do begin
            dobranyKolor := random(kolory)+1;
            odpowiedniKolor := czyOdpowiedniKolor(i,j,dobranyKolor);
            inc(petla);
          end;
        end
        //Kulka jest jokerem
        else begin
          odpowiedniKolor := czyOdpowiedniaSytuacjaJokera(i,j);
          if not odpowiedniKolor then GoTo losowanie2;
        end;
        OnClick := CustomImageClick;
      end;
      if petla = 100 then GoTo losowanie1;

      //Tworzenie kulki nie 'specjalnej'
      if not specjalna then begin
        nowaKulka.Picture.
          LoadFromFile('pic/kulka'+IntToStr(dobranyKolor)+'.bmp');
        with kulka do begin
          obraz := nowaKulka;
          kolor := dobranyKolor;
          joker := false;
          kameleon := false;
          bonus := false;
          czaszka := false;
          klepsydra := false;
          klepsydraPunkty := 0;
        end;
      end

      //Tworzenie kulki specjalnej
      else begin
        with kulka do begin
          case wylosowanaSpecjalna of
            0: begin //Joker
              nowaKulka.Picture.
                LoadFromFile('pic/kulka15.bmp');
              obraz := nowaKulka;
              kolor := 15;
              joker := true;
              kameleon := false;
              bonus := false;
              czaszka := false;
              klepsydra := false;
              klepsydraPunkty := 0;
              end;
            1: begin //Kameleon
              nowaKulka.Picture.
                LoadFromFile('pic/kulka'+IntToStr(dobranyKolor)+'k.bmp');
              obraz := nowaKulka;
              kolor := dobranyKolor;
              joker := false;
              kameleon := true;
              bonus := false;
              czaszka := false;
              klepsydra := false;
              klepsydraPunkty := 0;
              end;
            2: begin //Bonus
              nowaKulka.Picture.
                LoadFromFile('pic/kulka'+IntToStr(dobranyKolor)+'b.bmp');
              obraz := nowaKulka;
              kolor := dobranyKolor;
              joker := false;
              kameleon := false;
              bonus := true;
              czaszka := false;
              klepsydra := false;
              klepsydraPunkty := 0;
              end;
            3: begin //Czaszka
              nowaKulka.Picture.
                LoadFromFile('pic/kulka'+IntToStr(dobranyKolor)+'c.bmp');
              obraz := nowaKulka;
              kolor := dobranyKolor;
              joker := false;
              kameleon := false;
              bonus := false;
              czaszka := true;
              klepsydra := false;
              klepsydraPunkty := 0;
              end;
            4: begin //Klepsydra
              nowaKulka.Picture.
                LoadFromFile('pic/kulka'+IntToStr(dobranyKolor)+'z.bmp');
              obraz := nowaKulka;
              kolor := dobranyKolor;
              joker := false;
              kameleon := false;
              bonus := false;
              czaszka := false;
              klepsydra := true;
              klepsydraPunkty := 0;
              end;
          end;
        end;
      end;

      kulka.X := i;
      kulka.Y := j;
      kulka.puste := false;
      tablica[i,j] := kulka;
    end;
  end;

  //Wyœwietlanie kulek
  top := 10;
  left := 120;
  for i := 0 to rozmiar-1 do begin
    for j := 0 to rozmiar-1 do begin
      tablica[i,j].obraz.Top := top;
      tablica[i,j].obraz.Left := left;
      tablica[i,j].punkt := Point(left, top);
      left := left + 40;
    end;
    top := top + 40;
    left := 120;
  end;

  if not JestRuch then ShowMessage('Brak mo¿liwoœci ruchu. Zaleca siê ' +
    'zmniejszenie liczby kolorów lub zwiêkszenie rozmiaru planszy.');         
end;

{------------------------------------------------------------------------------}
//PROCEDURA POWODUJ¥CA OPÓ¯NIENIE DZIA£ANIA PROGRAMU
procedure TForm3.Delay(msecs: Integer);
var
  FirstTickCount: longint;
begin
  FirstTickCount := GetTickCount;
  repeat
    Application.ProcessMessages;
  until ((GetTickCount - FirstTickCount) >= Longint(msecs));
end;

{------------------------------------------------------------------------------}
//FUNKCJA SPRAWDZAJ¥CA CZY KULKA LE¯Y W CI¥GU TRZECH KULEK JEDNAKOWEGO KOLORU
function PotrojnyKolor(i,j,kolor: Integer): boolean;
var
  potrojny: boolean;
begin
  potrojny := false;
  if (i >= 0) and (i < Form3.rozmiar) and (j >=0) and (j < Form3.rozmiar) then
  begin
    if tablica[i,j].joker then begin
      if j-2 >= 0 then
        if ((tablica[i,j-2].kolor = tablica[i,j-1].kolor) or
        tablica[i,j-2].joker or tablica[i,j-1].joker) then
          potrojny := true;
      if (not potrojny) and (j+2 < Form3.rozmiar) then
        if ((tablica[i,j+1].kolor = tablica[i,j+2].kolor) or
        tablica[i,j+1].joker or tablica[i,j+2].joker) then
          potrojny := true;
      if (not potrojny) and (i-2 >= 0) then
        if ((tablica[i-2,j].kolor = tablica[i-1,j].kolor) or
        tablica[i-2,j].joker or tablica[i-1,j].joker) then
          potrojny := true;
      if (not potrojny) and (i+2 < Form3.rozmiar) then
        if ((tablica[i+1,j].kolor = tablica[i+2,j].kolor) or
        tablica[i+1,j].joker or tablica[i+2,j].joker) then
          potrojny := true;
      if (not potrojny) and (j-1 >= 0) and (j+1 < Form3.rozmiar) then
        if ((tablica[i,j-1].kolor = tablica[i,j+1].kolor ) or
        tablica[i,j-1].joker or tablica[i,j+1].joker) then
          potrojny := true;
      if (not potrojny) and (i-1 >= 0) and (i+1 < Form3.rozmiar) then
        if ((tablica[i-1,j].kolor = tablica[i+1,j].kolor) or
        tablica[i-1,j].joker or tablica[i+1,j].joker) then
          potrojny := true;
    end
    else begin
      if j-2 >= 0 then
        if ((tablica[i,j-2].kolor = kolor) or tablica[i,j-2].joker) and
         ((tablica[i,j-1].kolor = kolor) or tablica[i,j-1].joker) then
          potrojny := true;
      if (not potrojny) and (j+2 < Form3.rozmiar) then
        if ((tablica[i,j+1].kolor = kolor) or tablica[i,j+1].joker) and
       ((tablica[i,j+2].kolor = kolor) or tablica[i,j+2].joker) then
          potrojny := true;
      if (not potrojny) and (i-2 >= 0) then
        if ((tablica[i-2,j].kolor = kolor) or tablica[i-2,j].joker) and
        ((tablica[i-1,j].kolor = kolor) or tablica[i-1,j].joker) then
          potrojny := true;
      if (not potrojny) and (i+2 < Form3.rozmiar) then
        if ((tablica[i+1,j].kolor = kolor) or tablica[i+1,j].joker) and
        ((tablica[i+2,j].kolor = kolor) or tablica[i+2,j].joker) then
          potrojny := true;
      if (not potrojny) and (j-1 >= 0) and (j+1 < Form3.rozmiar) then
        if ((tablica[i,j-1].kolor = kolor) or tablica[i,j-1].joker) and
        ((tablica[i,j+1].kolor = kolor) or tablica[i,j+1].joker) then
          potrojny := true;
      if (not potrojny) and (i-1 >= 0) and (i+1 < Form3.rozmiar) then
        if ((tablica[i-1,j].kolor = kolor) or tablica[i-1,j].joker) and
        ((tablica[i+1,j].kolor = kolor) or tablica[i+1,j].joker) then
          potrojny := true;
    end
  end;
  PotrojnyKolor := potrojny;
end;

{------------------------------------------------------------------------------}
//PROCEDURA PRZYPISUJ¥CA KULKÊ NA PODSTAWIE OTRZYMANEGO OBRAZU
procedure TForm3.przypiszKulke(x, y: Integer; zaznaczona: boolean);
var
  i,j: Integer;
  szukaj: boolean;
begin
  i := 0;
  szukaj := true;
  while (i < rozmiar) and szukaj do begin
    j := 0;
    while (j < rozmiar) and szukaj do begin
      if (tablica[i,j].obraz.Left = x) and (tablica[i,j].obraz.Top = y) then begin
        if zaznaczona then dobranaKulka := @tablica[i,j]
        else zaznaczonaKulka := @tablica[i,j];
        szukaj := false;
      end;
      inc(j);
    end;
    inc(i);
  end;
end;

{------------------------------------------------------------------------------}
//FUNKCJA SPRAWDZAJ¥CA CZY NA PLANSZY JEST MO¯LIWY DO WYKONANIA RUCH
function TForm3.JestRuch(): boolean;
var
  jest: boolean;
  i, j: Integer;
begin
  jest := false;
  i := 0;
  while (i < rozmiar) and (not jest) do begin
    j := 0;
    while (j < rozmiar) and (not jest) do begin
      if ZamienKolory(i, j, i, j-1, false) then begin
        if PotrojnyKolor(i, j-1, tablica[i, j-1].kolor) then
          jest := true;
        ZamienKolory(i, j, i, j-1,false);
      end;

      if ZamienKolory(i, j, i-1, j, false) then begin
        if PotrojnyKolor(i-1, j, tablica[i-1, j].kolor) then
          jest := true;
        ZamienKolory(i,j,i-1,j,false);
      end;

      if ZamienKolory(i, j, i, j+1, false) then begin
        if PotrojnyKolor(i, j+1, tablica[i, j+1].kolor) then
          jest := true;
        ZamienKolory(i, j, i, j+1,false);
      end;

      if ZamienKolory(i, j, i+1, j, false) then begin
        if PotrojnyKolor(i+1, j, tablica[i+1, j].kolor) then
          jest := true;
        ZamienKolory(i, j, i+1, j, false);
      end;

      inc(j);
    end;
    inc(i);
  end;
  JestRuch := jest;
end;

{------------------------------------------------------------------------------}
//PROCEDURA ZAMIENIAJ¥CA KOLORY DWÓCH S¥SIEDNICH KULEK
procedure TForm3.ZamienKolor();
var
  kolorPom: Integer;
  specjalnaPom: boolean;
  klepsydraPom: Integer;
  sciezka: String;
begin
  kolorPom := zaznaczonaKulka^.kolor;
  zaznaczonaKulka^.kolor := dobranaKulka^.kolor;
  dobranaKulka^.kolor := kolorPom;

  specjalnaPom := zaznaczonaKulka^.joker;
  zaznaczonaKulka^.joker := dobranaKulka^.joker;
  dobranaKulka^.joker := specjalnaPom;

  specjalnaPom := zaznaczonaKulka^.kameleon;
  zaznaczonaKulka^.kameleon := dobranaKulka^.kameleon;
  dobranaKulka^.kameleon := specjalnaPom;

  specjalnaPom := zaznaczonaKulka^.bonus;
  zaznaczonaKulka^.bonus := dobranaKulka^.bonus;
  dobranaKulka^.bonus := specjalnaPom;

  specjalnaPom := zaznaczonaKulka^.czaszka;
  zaznaczonaKulka^.czaszka := dobranaKulka^.czaszka;
  dobranaKulka^.czaszka := specjalnaPom;

  specjalnaPom := zaznaczonaKulka^.klepsydra;
  zaznaczonaKulka^.klepsydra := dobranaKulka^.klepsydra;
  dobranaKulka^.klepsydra := specjalnaPom;

  klepsydraPom := zaznaczonaKulka^.klepsydraPunkty;
  zaznaczonaKulka^.klepsydraPunkty := dobranaKulka^.klepsydraPunkty;
  dobranaKulka^.klepsydraPunkty := klepsydraPom;

  if zaznaczonaKulka^.joker then zaznaczonaKulka^.obraz.Picture.
    LoadFromFile('pic/kulka15.bmp')
  else begin
    sciezka := '';
    if zaznaczonaKulka^.kameleon then sciezka := 'k'
    else if zaznaczonaKulka^.bonus then sciezka := 'b'
    else if zaznaczonaKulka^.czaszka then sciezka := 'c'
    else if zaznaczonaKulka^.klepsydra then sciezka := 'z';

    zaznaczonaKulka^.obraz.Picture.LoadFromFile('pic/kulka'+
      IntToStr(zaznaczonaKulka^.kolor)+sciezka+'.bmp');
  end;

  if dobranaKulka^.joker then dobranaKulka^.obraz.Picture.
    LoadFromFile('pic/kulka15.bmp')
  else begin
    sciezka := '';
    if dobranaKulka^.kameleon then sciezka := 'k'
    else if dobranaKulka^.bonus then sciezka := 'b'
    else if dobranaKulka^.czaszka then sciezka := 'c'
    else if dobranaKulka^.klepsydra then sciezka := 'z';

    dobranaKulka^.obraz.Picture.LoadFromFile('pic/kulka'+
      IntToStr(dobranaKulka^.kolor)+sciezka+'.bmp');
  end;
end;

{------------------------------------------------------------------------------}
//FUNKCJA ZAMIENIAJ¥CA KOLORY W DWÓCH POLACH PLANSZY
function TForm3.ZamienKolory(x1, y1, x2, y2: Integer; zmienRysunek: boolean): boolean;
var
  kolorPom: Integer;
  specjalnaPom, pustePom: boolean;
  klepsydraPom: Integer;
  zamieniono: boolean;
  sciezka: String;
begin
  zamieniono := false;
  if (x1 >= 0) and (x1 < Form3.rozmiar) and (x2 >=0) and (x2 < Form3.rozmiar)
    and (y1 >= 0) and (y1 < Form3.rozmiar) and (y2 >=0) and (y2 < Form3.rozmiar)
    then begin
    zamieniono := true;

    //Czêœæ s³u¿¹ca do zamiany tylko w³aœciwoœci pól
    kolorPom := tablica[x1,y1].kolor;
    tablica[x1,y1].kolor := tablica[x2,y2].kolor;
    tablica[x2,y2].kolor := kolorPom;

    pustePom := tablica[x1,y1].puste;
    tablica[x1,y1].puste := tablica[x2,y2].puste;
    tablica[x2,y2].puste := pustePom;

    specjalnaPom := tablica[x1,y1].joker;
    tablica[x1,y1].joker := tablica[x2,y2].joker;
    tablica[x2,y2].joker := specjalnaPom;

    specjalnaPom := tablica[x1,y1].kameleon;
    tablica[x1,y1].kameleon := tablica[x2,y2].kameleon;
    tablica[x2,y2].kameleon := specjalnaPom;

    specjalnaPom := tablica[x1,y1].bonus;
    tablica[x1,y1].bonus := tablica[x2,y2].bonus;
    tablica[x2,y2].bonus := specjalnaPom;

    specjalnaPom := tablica[x1,y1].czaszka;
    tablica[x1,y1].czaszka := tablica[x2,y2].czaszka;
    tablica[x2,y2].czaszka := specjalnaPom;

    specjalnaPom := tablica[x1,y1].klepsydra;
    tablica[x1,y1].klepsydra := tablica[x2,y2].klepsydra;
    tablica[x2,y2].klepsydra := specjalnaPom;

    klepsydraPom := tablica[x1,y1].klepsydraPunkty;
    tablica[x1,y1].klepsydraPunkty := tablica[x2,y2].klepsydraPunkty;
    tablica[x2,y2].klepsydraPunkty := klepsydraPom;

    //Czêœæ zamieniaj¹ca obrazki
    if zmienRysunek then begin
      if tablica[x1,y1].puste then tablica[x1,y1].obraz.Picture.
        LoadFromFile('pic/kulka0.bmp')
      else if tablica[x1,y1].joker then tablica[x1,y1].obraz.Picture.
        LoadFromFile('pic/kulka15.bmp')
      else begin
        sciezka := '';
        if tablica[x1,y1].kameleon then sciezka := 'k'
        else if tablica[x1,y1].bonus then sciezka := 'b'
        else if tablica[x1,y1].czaszka then sciezka := 'c'
        else if tablica[x1,y1].klepsydra then sciezka := 'z';

        tablica[x1,y1].obraz.Picture.LoadFromFile('pic/kulka'+
          IntToStr(tablica[x1,y1].kolor)+sciezka+'.bmp');
      end;

      if tablica[x2,y2].puste then tablica[x2,y2].obraz.Picture.
        LoadFromFile('pic/kulka0.bmp')
      else if tablica[x2,y2].joker then tablica[x2,y2].obraz.Picture.
        LoadFromFile('pic/kulka15.bmp')
      else begin
        sciezka := '';
        if tablica[x2,y2].kameleon then sciezka := 'k'
        else if tablica[x2,y2].bonus then sciezka := 'b'
        else if tablica[x2,y2].czaszka then sciezka := 'c'
        else if tablica[x2,y2].klepsydra then sciezka := 'z';

        tablica[x1,y1].obraz.Picture.LoadFromFile('pic/kulka'+
          IntToStr(tablica[x2,y2].kolor)+sciezka+'.bmp');
      end;
    end
  end;
  ZamienKolory := zamieniono
end;

{------------------------------------------------------------------------------}
//PROCEDURA USUWAJ¥CA Z PLANSZY CI¥GI JEDNAKOWYCH KULEK
procedure TForm3.UsunCiagi();
var
  usunieto: boolean;
  i, j: Integer;
  punkty: Integer;
  mnoznik: Integer;
  czaszka: boolean;
  wynik: Integer;
begin
  usunieto := false;

  i := 0;
  while i < rozmiar do begin
    j := 0;
    while j < rozmiar do begin
      if PotrojnyKolor(i,j,tablica[i,j].kolor) then begin
        tablica[i,j].puste := true;
      end;
      inc(j);
    end;
    inc(i);
  end;

  punkty := 0;
  mnoznik := 1;
  czaszka := false;
  i := 0;
  while i < rozmiar do begin
    j := 0;
    while j < rozmiar do begin
      wynik := 0;
      if tablica[i,j].puste = true then begin
        tablica[i,j].obraz.Picture.LoadFromFile('pic/kulka0.bmp');
        Delay(30);

        if tablica[i,j].joker then //Pusta instrukcja
        else if tablica[i,j].klepsydra then begin
          punkty := punkty + tablica[i,j].klepsydraPunkty;
          wynik := tablica[i,j].klepsydraPunkty;
        end
        else if tablica[i,j].bonus then begin
          punkty := punkty + tablica[i,j].kolor;
          wynik := tablica[i,j].kolor;
          mnoznik := mnoznik * 2;
        end
        else if tablica[i,j].czaszka then begin
          punkty := punkty + tablica[i,j].kolor;
          wynik := tablica[i,j].kolor;
          czaszka := true;
        end
        else begin
          punkty := punkty + tablica[i,j].kolor;
          wynik := tablica[i,j].kolor;
        end;

        if aktualnyGracz = 1 then begin
          wynik1 := wynik1 + wynik;
          Label3.Caption := IntToStr(wynik1)
        end
        else begin
          wynik2 := wynik2 + wynik;
          Label7.Caption := IntToStr(wynik2);
        end;
        usunieto := true;
      end;
      inc(j);
    end;
    inc(i);
  end;

  if czaszka = true then wystapilaCzaszka := true;
  zdobytePunkty := zdobytePunkty + punkty;
  skumulowanyMnoznik := skumulowanyMnoznik * mnoznik;

  odswiez := usunieto
end;

{------------------------------------------------------------------------------}
//PROCEDURA POWODUJ¥CA OPADANIE KULEK NA PUSTE MIEJSCA PONI¯EJ
procedure TForm3.Obsun();
var
  znalezione: boolean;
  i, j, k: Integer;
begin
  Delay(50);
  i := rozmiar - 1;
  while (i >= 0) do begin
    j := 0;
    while j < rozmiar do begin
      if tablica[i,j].puste = true then begin

        //Szukam pierwszego pola powy¿ej, które nie jest puste
        k := i - 1;
        znalezione := false;
        while (k >= 0) and (not znalezione) do begin
          if tablica[k,j].puste = false then begin
            znalezione := true;

            Delay(10);
            //Zamieniam kolory pól
            ZamienKolory(i,j,k,j,true);
            Application.ProcessMessages;

          end;
          dec(k);
        end;

      end;
      inc(j);
    end;
    dec(i);
  end;
end;

{------------------------------------------------------------------------------}
//PROCEDURA LOSUJ¥CA I WSTAWIAJ¥CA NOWE KULKI NA PLANSZY
procedure TForm3.LosujNowe();
var
  i, j: Integer;
  dobranyKolor: Integer;
  wylosowanaSpecjalna, prawdopodobienstwo, wylosowanePrawd: Integer;
  specjalna: boolean;
begin
  Randomize;
  Delay(50);
  j := 0;
  while j < rozmiar do begin
    i := rozmiar - 1;
    while i >= 0 do begin
      if tablica[i,j].puste = true then begin
        Delay(30);

        //Wstawianie nowej kulki
        dobranyKolor := random(kolory) + 1;

        wylosowanaSpecjalna := random(5);
        case wylosowanaSpecjalna of
          0: prawdopodobienstwo := prawdJoker;
          1: prawdopodobienstwo := prawdKameleon;
          2: prawdopodobienstwo := prawdBonus;
          3: prawdopodobienstwo := prawdCzaszka;
          4: prawdopodobienstwo := prawdKlepsydra;
        end;

        specjalna := false;
        wylosowanePrawd := random(100) + 1;
        if (prawdopodobienstwo > 0) and (wylosowanePrawd <= prawdopodobienstwo)
        then specjalna := true;

        //Tworzenie kulki nie 'specjalnej'
        if not specjalna then begin
          with tablica[i,j] do begin
            obraz.Picture.
              LoadFromFile('pic/kulka'+IntToStr(dobranyKolor)+'.bmp');
            kolor := dobranyKolor;
            joker := false;
            kameleon := false;
            bonus := false;
            czaszka := false;
            klepsydra := false;
            klepsydraPunkty := 0;
          end;
        end

        //Tworzenie kulki specjalnej
        else begin
          with tablica[i,j] do begin
            case wylosowanaSpecjalna of
              0: begin //Joker
                obraz.Picture.
                  LoadFromFile('pic/kulka15.bmp');
                kolor := 15;
                joker := true;
                kameleon := false;
                bonus := false;
                czaszka := false;
                klepsydra := false;
                klepsydraPunkty := 0;
                end;
              1: begin //Kameleon
                obraz.Picture.
                  LoadFromFile('pic/kulka'+IntToStr(dobranyKolor)+'k.bmp');
                kolor := dobranyKolor;
                joker := false;
                kameleon := true;
                bonus := false;
                czaszka := false;
                klepsydra := false;
                klepsydraPunkty := 0;
                end;
              2: begin //Bonus
                obraz.Picture.
                  LoadFromFile('pic/kulka'+IntToStr(dobranyKolor)+'b.bmp');
                kolor := dobranyKolor;
                joker := false;
                kameleon := false;
                bonus := true;
                czaszka := false;
                klepsydra := false;
                klepsydraPunkty := 0;
                end;
              3: begin //Czaszka
                obraz.Picture.
                  LoadFromFile('pic/kulka'+IntToStr(dobranyKolor)+'c.bmp');
                kolor := dobranyKolor;
                joker := false;
                kameleon := false;
                bonus := false;
                czaszka := true;
                klepsydra := false;
                klepsydraPunkty := 0;
                end;
              4: begin //Klepsydra
                obraz.Picture.
                  LoadFromFile('pic/kulka'+IntToStr(dobranyKolor)+'z.bmp');
                kolor := dobranyKolor;
                joker := false;
                kameleon := false;
                bonus := false;
                czaszka := false;
                klepsydra := true;
                klepsydraPunkty := 0;
                end;
            end;
          end;
        end;

        tablica[i,j].puste := false;
      end;
      dec(i);
    end;
    inc(j);
  end;
end;

{------------------------------------------------------------------------------}
//PROCEDURA ZMIENIAJ¥CA KOLOR KAMELEONA
procedure ZmienKameleona();
var
  i, j : Integer;
  kolorKameleona: Integer;
begin
  Randomize;
  if Form3.prawdKameleon <> 0 then begin
    for i := 0 to Form3.rozmiar - 1 do begin
      for j := 0 to Form3.rozmiar - 1 do begin
        if tablica[i,j].kameleon then begin
          kolorKameleona := random(Form3.kolory) + 1;
          tablica[i,j].obraz.Picture.
            LoadFromFile('pic/kulka'+IntToStr(kolorKameleona)+'k.bmp');
          tablica[i,j].kolor := kolorKameleona;
        end;
      end;
    end;
  end;
end;

{------------------------------------------------------------------------------}
//PROCEDURA ZMNIEJSZAJ¥CA WARTOŒÆ KULEK Z KLEPSYDR¥
procedure OdliczKlepsydre();
var
  i, j : Integer;
begin
  if Form3.prawdKlepsydra <> 0 then begin
    for i := 0 to Form3.rozmiar - 1 do begin
      for j := 0 to Form3.rozmiar - 1 do begin
        if tablica[i,j].klepsydra then
          if tablica[i,j].klepsydraPunkty > 0 then
            dec(tablica[i,j].klepsydraPunkty);
      end;
    end;
  end;
end;

{------------------------------------------------------------------------------}
//PROCEDURA ZMIENIAJ¥CA GRACZA
procedure TForm3.ZmienGracza();
begin
  if trybGry <> 0 then begin
    if aktualnyGracz = 1 then begin
      aktualnyGracz := 2;
      Label1.Font.Color := clWindowText;
      Label4.Font.Color := clHighlight;
    end
    else begin
      aktualnyGracz := 1;
      Label4.Font.Color := clWindowText;
      Label1.Font.Color := clHighlight;
    end
  end;
end;

{------------------------------------------------------------------------------}
//PROCEDURA WYKONUJ¥CA £ATWY RUCH KOMPUTERA
procedure TForm3.LatwyRuchKomputera();

  procedure DodajRuch(i1, j1, i2, j2: Integer; var lista: TListaRuchow);
  var
    dodawanyRuch: TListaRuchow;
  begin
    new(dodawanyRuch);
    dodawanyRuch^.zaznaczX := i1;
    dodawanyRuch^.zaznaczY := j1;
    dodawanyRuch^.dobierzX := i2;
    dodawanyRuch^.dobierzY := j2;
    dodawanyRuch^.nast := lista^.nast;
    lista^.nast := dodawanyRuch;
    lista := lista^.nast;
  end;

  procedure UsunListe(var lista: TListaRuchow);
  begin
    if lista <> nil then begin
      UsunListe(lista^.nast);
      Dispose(lista);
    end;
  end;

var
  straznik, lista: TListaRuchow;
  i, j: Integer;
  liczbaRuchow, wylosowanyRuch: Integer;
begin
  //Tworzê stra¿nika nowej listy
  New(straznik);
  straznik^.nast := nil;
  lista := straznik;

  //Przegl¹dam planszê w poszukiwaniu mo¿liwych ruchów i dodajê je do listy
  i := 0;
  while i < Form3.rozmiar do begin
    j := 0;
    while j < Form3.rozmiar do begin
      if ZamienKolory(i, j, i, j-1, false) then begin
        if PotrojnyKolor(i, j-1, tablica[i, j-1].kolor) then
          DodajRuch(i, j, i, j-1, lista);
        ZamienKolory(i, j, i, j-1,false);
      end;

      if ZamienKolory(i, j, i-1, j, false) then begin
        if PotrojnyKolor(i-1, j, tablica[i-1, j].kolor) then
          DodajRuch(i, j, i-1, j, lista);
        ZamienKolory(i,j,i-1,j,false);
      end;

      if ZamienKolory(i, j, i, j+1, false) then begin
        if PotrojnyKolor(i, j+1, tablica[i, j+1].kolor) then
          DodajRuch(i, j, i, j+1, lista);
        ZamienKolory(i, j, i, j+1,false);
      end;

      if ZamienKolory(i, j, i+1, j, false) then begin
        if PotrojnyKolor(i+1, j, tablica[i+1, j].kolor) then
          DodajRuch(i, j, i+1, j, lista);
        ZamienKolory(i, j, i+1, j, false);
      end;

      inc(j);
    end;
    inc(i);
  end;

  //Zliczam ile jest mo¿liwych ruchow;
  lista := straznik^.nast;
  liczbaRuchow := 0;
  while lista <> nil do begin
    inc(liczbaRuchow);
    lista := lista^.nast;
  end;

  //Losujê jeden z ruchów
  Randomize;
  wylosowanyRuch := random(liczbaRuchow) + 1;

  //Wykonuje wylosowany ruch
  lista := straznik;
  while (lista <> nil) and (wylosowanyRuch <> 0) do begin
    lista := lista^.nast;
    dec(wylosowanyRuch)
  end;

  Form3.Delay(500);
  zezwalaj := true;
  Form3.CustomImageClick(tablica[lista^.zaznaczX, lista^.zaznaczY].obraz);
  zezwalaj := false;

  Form3.Delay(500);

  zezwalaj := true;
  Form3.CustomImageClick(tablica[lista^.dobierzX, lista^.dobierzY].obraz);
  zezwalaj := false;

  //Usuwam listê ruchów
  UsunListe(straznik);
end;

{------------------------------------------------------------------------------}
//PROCEDURA WYKONUJ¥CA TRUDNY RUCH KOMPUTERA
procedure TForm3.TrudnyRuchKomputera();

  //Pomocnicza funkcja zliczaj¹ca punkty na planszy i zwracaj¹ca ich sumê
  function ZliczPunkty(): Integer;
  var
    punkty: Integer;
    i, j: Integer;
    bonusy: Integer;
    czaszka: boolean;
  begin
    czaszka := wystapilaCzaszka;

    //Zaznaczanie pól znajduj¹cyvh siê w ci¹gu 3 kulek o tym samym kolorze
    punkty := 0;
    bonusy := 1;
    for i := 0 to Form3.rozmiar - 1 do begin
      for j := 0 to Form3.rozmiar - 1 do begin
        if PotrojnyKolor(i, j, tablica[i,j].kolor) then begin
          tablica[i,j].puste := true; //Zaznaczenie pola
          if tablica[i,j].joker then //Pusta komenda
          else if tablica[i,j].bonus then begin
            bonusy := bonusy * 2;
            punkty := punkty + tablica[i,j].kolor;
          end
          else if tablica[i,j].czaszka then czaszka := true
          else if tablica[i,j].klepsydra then
            punkty := punkty + tablica[i,j].klepsydraPunkty
          else punkty := punkty + tablica[i,j].kolor;
        end;
      end;
    end;

    punkty := punkty * bonusy;
    if czaszka then punkty := 0;
    ZliczPunkty := punkty;

    //Odznaczam pola na planszy
    for i := 0 to Form3.rozmiar - 1 do
      for j := 0 to Form3.rozmiar - 1 do
        tablica[i,j].puste := false;

  end;

var
  punkty, zdobytePunkty: Integer;
  i, j: Integer;
  zaznaczonyX, zaznaczonyY, dobranyX, dobranyY: Integer;
begin
  punkty := -1;
  for i := 0 to Form3.rozmiar - 1 do begin
    for j := 0 to Form3.rozmiar - 1 do begin
      if ZamienKolory(i, j, i, j-1, false) then begin
        if PotrojnyKolor(i, j-1, tablica[i, j-1].kolor) then begin
          zdobytePunkty := 0;
          zdobytePunkty := ZliczPunkty();
          if zdobytePunkty > punkty then begin
            punkty := zdobytePunkty;
            zaznaczonyX := i;
            zaznaczonyY := j;
            dobranyX := i;
            dobranyY := j-1;
          end;
        end;
        ZamienKolory(i, j, i, j-1,false);
      end;

      if ZamienKolory(i, j, i-1, j, false) then begin
        if PotrojnyKolor(i-1, j, tablica[i-1, j].kolor) then begin
          zdobytePunkty := ZliczPunkty();
          if zdobytePunkty > punkty then begin
            punkty := zdobytePunkty;
            zaznaczonyX := i;
            zaznaczonyY := j;
            dobranyX := i-1;
            dobranyY := j;
          end;
        end;
        ZamienKolory(i,j,i-1,j,false);
      end;

      if ZamienKolory(i, j, i, j+1, false) then begin
        if PotrojnyKolor(i, j+1, tablica[i, j+1].kolor) then begin
          zdobytePunkty := ZliczPunkty();
          if zdobytePunkty > punkty then begin
            punkty := zdobytePunkty;
            zaznaczonyX := i;
            zaznaczonyY := j;
            dobranyX := i;
            dobranyY := j+1;
          end;
        end;
        ZamienKolory(i, j, i, j+1,false);
      end;

      if ZamienKolory(i, j, i+1, j, false) then begin
        if PotrojnyKolor(i+1, j, tablica[i+1, j].kolor) then begin
          zdobytePunkty := ZliczPunkty();
          if zdobytePunkty > punkty then begin
            punkty := zdobytePunkty;
            zaznaczonyX := i;
            zaznaczonyY := j;
            dobranyX := i+1;
            dobranyY := j;
          end;
        end;
        ZamienKolory(i, j, i+1, j, false);
      end;
    end;
  end;

  //Wykonuje najlepszy ruch
  zezwalaj := true;
  Form3.CustomImageClick(tablica[zaznaczonyX, zaznaczonyY].obraz);
  zezwalaj := false;

  Form3.Delay(500);

  zezwalaj := true;
  Form3.CustomImageClick(tablica[dobranyX, dobranyY].obraz);
  zezwalaj := false;
end;

{------------------------------------------------------------------------------}
//KLIKNIÊCIE NA KULKÊ
procedure TForm3.CustomImageClick(Sender: TObject);
var
  zamien: boolean;
  zmianaKameleona: boolean;
begin
  if zezwalaj and (not koniecGry) then begin

  zezwalaj := false;
  //Kulka jest ju¿ zaznaczona
  if kulkaWybrana then begin
    kulkaWybrana := false;

    //Rysowanie bia³ego prostok¹ta wokó³ zaznaczonej kulki
    Canvas.Pen.Color := clWhite;
    Canvas.Pen.Width := 2;
    Canvas.MoveTo(zaznaczonaKulka^.obraz.Left - 1,
      zaznaczonaKulka^.obraz.Top - 1);
    Canvas.LineTo(zaznaczonaKulka^.obraz.Left - 1,
      zaznaczonaKulka^.obraz.Top + 36);
    Canvas.LineTo(zaznaczonaKulka^.obraz.Left + 36,
      zaznaczonaKulka^.obraz.Top + 36);
    Canvas.LineTo(zaznaczonaKulka^.obraz.Left + 36,
      zaznaczonaKulka^.obraz.Top - 1);
    Canvas.LineTo(zaznaczonaKulka^.obraz.Left - 1,
      zaznaczonaKulka^.obraz.Top - 1);


    //Sprawdzanie czy zaznaczona kulka le¿y obok klikniêtej
    zamien := false;
    if ((TImage(Sender).Left + 40 = zaznaczonaKulka^.punkt.X) and
      (TImage(Sender).Top = zaznaczonaKulka^.punkt.Y))

      or

      ((TImage(Sender).Left = zaznaczonaKulka^.punkt.X) and
      (TImage(Sender).Top + 40 = zaznaczonaKulka^.punkt.Y))

      or

      ((TImage(Sender).Left - 40 = zaznaczonaKulka^.punkt.X) and
      (TImage(Sender).Top = zaznaczonaKulka^.punkt.Y))

      or

      ((TImage(Sender).Left = zaznaczonaKulka^.punkt.X) and
      (TImage(Sender).Top - 40 = zaznaczonaKulka^.punkt.Y))

      then zamien := true;

    //Zamiana kulek
    if zamien then begin
      dobranaKulka := nil;
      przypiszKulke(TImage(Sender).Left, TImage(Sender).Top, true);
      ZamienKolor();
      Delay(100);

      //Sprawdzanie czy wokó³ zamienionych kulek s¹ co najmniej trzy kulki
      //tego samego koloru
      if PotrojnyKolor(zaznaczonaKulka^.X, zaznaczonaKulka^.Y,
        zaznaczonaKulka^.kolor) or
        PotrojnyKolor(dobranaKulka^.X, dobranaKulka^.Y,
        dobranaKulka^.kolor) then begin

        BitBtn2.Enabled := false;
        EnableMenuItem( GetSystemMenu( handle, False ),SC_CLOSE, MF_BYCOMMAND
          or MF_GRAYED );

        wystapilaCzaszka := false;
        zdobytePunkty := 0;
        skumulowanyMnoznik := 1;
        odswiez := true;
        zmianaKameleona := true;
        while odswiez do begin
          //Usuwanie z planszy ci¹gów conajmniej 3 jednakowych kulek
          UsunCiagi();

          //Obsuniêcie kulek
          Obsun();

          //Dolosowanie nowych kulek bez powtórzeñ w puste pola
          LosujNowe();

          //Zmiana Kameleona;
          if odswiez and zmianaKameleona then begin
            ZmienKameleona();
            zmianaKameleona := false;
          end;
        end;

        if wystapilaCzaszka then begin
          case aktualnyGracz of
            1: begin
              Image1.Visible := true;
              Delay(500);
              wynik1 := wynik1 - zdobytePunkty;
              Label3.Caption := IntToStr(wynik1);
              Delay(100);
              Image1.Visible := false;
              end;
            2: begin
              Image2.Visible := true;
              Delay(500);
              wynik2 := wynik2 - zdobytePunkty;
              Label7.Caption := IntToStr(wynik2);
              Delay(100);
              Image2.Visible := false;
              end;
          end;
        end

        else if skumulowanyMnoznik <> 1 then begin
          if aktualnyGracz = 1 then begin
            wynik1 := wynik1 + zdobytePunkty * (skumulowanyMnoznik - 1);
            Label3.Caption := IntToStr(wynik1);
          end
          else begin
            wynik2 := wynik2 + zdobytePunkty * (skumulowanyMnoznik - 1);
            Label7.Caption := IntToStr(wynik2);
          end;
        end;

        //Zmniejszenie wartoœci kulek z klepsydr¹
        OdliczKlepsydre();

        //ZmianaGracza
        ZmienGracza();

        //Mo¿liwy jest jeszcze ruch
        if JestRuch and not koniecGry then begin
          //Ruch komputera
          if (trybGry = 2) and (aktualnyGracz = 2) then begin
            if poziom = 0 then LatwyRuchKomputera()
            else if poziom = 1 then TrudnyRuchKOmputera();
          end;
        end
        else begin
          koniecGry := true;
          if trybGry = 1 then begin
            if wynik1 > wynik2 then ShowMessage('Brak mo¿liwych ruchów. ' +
              'Wygra³ Gracz 1!')
            else if wynik1 = wynik2 then
              ShowMessage('Brak mo¿liwych ruchów. Remis!')
            else ShowMessage('Brak mo¿liwych ruchów. Wygra³ Gracz 2!');
          end
          else if trybGry = 2 then begin
            if wynik1 > wynik2 then
              ShowMessage('Brak mo¿liwych ruchów. Wygra³ Gracz!')
            else if wynik1 = wynik2 then
              ShowMessage('Brak mo¿liwych ruchów. Remis!')
            else ShowMessage('Brak mo¿liwych ruchów. Wygra³ Komputer!');
          end
          else if trybGry = 0 then begin
            ShowMessage('Brak mo¿liwych ruchów.');
          end
        end;

        BitBtn2.Enabled := true;
        EnableMenuItem( GetSystemMenu( handle, False ),SC_CLOSE, MF_BYCOMMAND
          or MF_ENABLED );

      end
      else begin
        Delay(90);
        ZamienKolor();
      end
    end;
  end

  //Kulka nie jest jeszcze zaznaczona
  else begin
    kulkaWybrana := true;
    zaznaczonaKulka := nil;
    przypiszKulke(TImage(Sender).Left, TImage(Sender).Top, false);

    //Rysowanie czarnego prostok¹ta wokó³ zaznaczonej kulki
    Canvas.Pen.Color := clBlack;
    Canvas.Pen.Width := 2;
    Canvas.MoveTo(TImage(Sender).Left-1, TImage(Sender).Top-1);
    Canvas.LineTo(TImage(Sender).Left-1, TImage(Sender).Top+36);
    Canvas.LineTo(TImage(Sender).Left+36, TImage(Sender).Top+36);
    Canvas.LineTo(TImage(Sender).Left+36, TImage(Sender).Top-1);
    Canvas.LineTo(TImage(Sender).Left-1, TImage(Sender).Top-1);
  end;
  zezwalaj := true;

  end;
end;

{------------------------------------------------------------------------------}
//WYJŒCIE DO MENU G£ÓWNEGO
procedure TForm3.BitBtn2Click(Sender: TObject);
begin
  //Wyœrodkowanie formularza
  Form5.Left := (Screen.Width div 2) - (Form5.Width div 2);
  Form5.Top := (Screen.Height div 2) - (Form5.Height div 2);
  Form5.Show;
end;

{------------------------------------------------------------------------------}
//ZAMYKANIE FORMULARZA
procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i,j: Integer;
begin
  //Czyszczenie tablicy
  for i := 0 to rozmiar-1 do
    for j := 0 to rozmiar-1 do
      tablica[i,j].obraz.Destroy;

  Form1.Visible := true;
end;

end.
