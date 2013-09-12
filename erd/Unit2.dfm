object Form2: TForm2
  Left = 204
  Top = 277
  Width = 230
  Height = 340
  Caption = 'Dodaj encj'#281
  Color = clBtnFace
  Constraints.MaxHeight = 340
  Constraints.MaxWidth = 230
  Constraints.MinHeight = 340
  Constraints.MinWidth = 230
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 58
    Height = 13
    Caption = 'Nazwa encji'
  end
  object Label2: TLabel
    Left = 8
    Top = 104
    Width = 71
    Height = 13
    Caption = 'Lista atrybut'#243'w'
  end
  object Label3: TLabel
    Left = 8
    Top = 55
    Width = 33
    Height = 13
    Caption = 'Atrybut'
  end
  object Edit1: TEdit
    Left = 8
    Top = 24
    Width = 201
    Height = 21
    TabOrder = 0
  end
  object ListBox1: TListBox
    Tag = 1
    Left = 8
    Top = 120
    Width = 201
    Height = 105
    ItemHeight = 13
    TabOrder = 1
  end
  object Button1: TButton
    Left = 136
    Top = 71
    Width = 75
    Height = 25
    Caption = 'Dodaj atrybut'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Edit2: TEdit
    Left = 8
    Top = 71
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object Button2: TButton
    Left = 120
    Top = 264
    Width = 91
    Height = 25
    Caption = 'Anuluj'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 232
    Width = 145
    Height = 25
    Caption = 'Usu'#324' zaznaczony atrybut'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 264
    Width = 105
    Height = 25
    Caption = 'Dodaj'
    TabOrder = 6
    OnClick = Button4Click
  end
end
