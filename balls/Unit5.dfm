object Form5: TForm5
  Left = 460
  Top = 503
  Width = 295
  Height = 119
  Caption = 'Kulki'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 16
    Width = 255
    Height = 13
    Caption = 'Czy na pewno chcesz zakonczyc biezaca rozgrywke?'
  end
  object Button1: TButton
    Left = 45
    Top = 41
    Width = 75
    Height = 25
    Caption = 'Tak'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 157
    Top = 41
    Width = 75
    Height = 25
    Caption = 'Nie'
    TabOrder = 1
    OnClick = Button2Click
  end
end
