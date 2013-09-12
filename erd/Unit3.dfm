object Form3: TForm3
  Left = 755
  Top = 254
  Width = 385
  Height = 270
  Caption = 'Dodaj zwi'#261'zek'
  Color = clBtnFace
  Constraints.MaxHeight = 270
  Constraints.MaxWidth = 385
  Constraints.MinHeight = 270
  Constraints.MinWidth = 385
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 53
    Top = 5
    Width = 261
    Height = 13
    Caption = 'Wybierz encje mi'#281'dzy kt'#243'rymi chcesz utworzy'#263' zwi'#261'zek'
  end
  object Label2: TLabel
    Left = 8
    Top = 74
    Width = 102
    Height = 13
    Caption = 'Podaj nazw'#281' zwi'#261'zku'
  end
  object Label3: TLabel
    Left = 8
    Top = 98
    Width = 114
    Height = 13
    Caption = 'Liczebno'#347#263' przy Encji 1.'
  end
  object Label4: TLabel
    Left = 8
    Top = 122
    Width = 114
    Height = 13
    Caption = 'Liczebno'#347#263' przy Encji 2.'
  end
  object Label5: TLabel
    Left = 72
    Top = 24
    Width = 39
    Height = 13
    Caption = 'Encja 1.'
  end
  object Label6: TLabel
    Left = 256
    Top = 24
    Width = 39
    Height = 13
    Caption = 'Encja 2.'
  end
  object Label7: TLabel
    Left = 8
    Top = 146
    Width = 109
    Height = 13
    Caption = 'Nazwa roli przy Encji 1.'
  end
  object Label8: TLabel
    Left = 8
    Top = 170
    Width = 109
    Height = 13
    Caption = 'Nazwa roli przy Encji 2.'
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 40
    Width = 169
    Height = 21
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
  end
  object ComboBox2: TComboBox
    Left = 192
    Top = 40
    Width = 169
    Height = 21
    ItemHeight = 13
    Sorted = True
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 128
    Top = 72
    Width = 233
    Height = 21
    TabOrder = 2
  end
  object ComboBox3: TComboBox
    Left = 128
    Top = 96
    Width = 65
    Height = 21
    ItemHeight = 13
    TabOrder = 3
    Items.Strings = (
      '1'
      '*')
  end
  object ComboBox4: TComboBox
    Left = 128
    Top = 120
    Width = 65
    Height = 21
    ItemHeight = 13
    TabOrder = 4
    Items.Strings = (
      '1'
      '*')
  end
  object Edit2: TEdit
    Left = 128
    Top = 144
    Width = 233
    Height = 21
    TabOrder = 5
  end
  object Edit3: TEdit
    Left = 128
    Top = 168
    Width = 233
    Height = 21
    TabOrder = 6
  end
  object Button1: TButton
    Left = 8
    Top = 200
    Width = 129
    Height = 25
    Caption = 'Dodaj zwi'#261'zek'
    TabOrder = 7
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 232
    Top = 200
    Width = 129
    Height = 25
    Caption = 'Anuluj'
    TabOrder = 8
    OnClick = Button2Click
  end
end
