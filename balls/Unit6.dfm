object Form6: TForm6
  Left = 367
  Top = 417
  Width = 390
  Height = 134
  Caption = 'Kulki'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    374
    96)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 15
    Top = 13
    Width = 71
    Height = 13
    Caption = 'Tw'#243'j wynik to: '
  end
  object Label2: TLabel
    Left = 87
    Top = 13
    Width = 3
    Height = 13
  end
  object Label3: TLabel
    Left = 15
    Top = 29
    Width = 260
    Height = 13
    Caption = 'Biorac pod uwage ustawienia rozgrywki, Tw'#243'j wynik to:'
  end
  object Label4: TLabel
    Left = 287
    Top = 19
    Width = 5
    Height = 24
    Anchors = [akLeft]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 15
    Top = 45
    Width = 308
    Height = 13
    Caption = 'Brawo, Tw'#243'j wynik zostanie wpisany na liscie najlepszych graczy!'
    Visible = False
  end
  object Label6: TLabel
    Left = 15
    Top = 64
    Width = 81
    Height = 13
    Caption = 'Podaj swoje imie:'
    Visible = False
  end
  object Edit1: TEdit
    Left = 103
    Top = 61
    Width = 97
    Height = 21
    TabOrder = 0
    Visible = False
  end
  object Button1: TButton
    Left = 287
    Top = 61
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = Button1Click
  end
end
