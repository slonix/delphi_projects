object Form1: TForm1
  Left = 458
  Top = 264
  Width = 644
  Height = 421
  Caption = 'Diagram Zwiazk'#243'w Encji'
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 600
    object Nowyprojekt1: TMenuItem
      Caption = 'Menu'
      object Nowyprojekt2: TMenuItem
        Caption = 'Nowy projekt'
        OnClick = Nowyprojekt2Click
      end
      object Otworz: TMenuItem
        Caption = 'Otw'#243'rz projekt z pliku'
        OnClick = OtworzClick
      end
      object Zapisz: TMenuItem
        Caption = 'Zapisz projekt do pliku'
        OnClick = ZapiszClick
      end
      object Wyj1: TMenuItem
        Caption = 'Wyj'#347'cie'
        OnClick = Wyj1Click
      end
    end
    object Pomoc1: TMenuItem
      Caption = 'Pomoc'
      OnClick = Pomoc1Click
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 568
    object Dodajencj1: TMenuItem
      Caption = 'Dodaj encj'#281
      OnClick = Dodajencj1Click
    end
    object Zwiazek: TMenuItem
      Caption = 'Dodaj zwi'#261'zek'
      OnClick = ZwiazekClick
    end
    object Edytujzwizek1: TMenuItem
      Caption = 'Edycja zwi'#261'zk'#243'w'
      OnClick = Edytujzwizek1Click
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.erd'
    Filter = '[ERD] Entity Relationship Diagram|*.erd'
    Left = 600
    Top = 32
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.erd'
    Filter = '[ERD] Entity Relationship Diagram|*.erd'
    Left = 568
    Top = 32
  end
end
