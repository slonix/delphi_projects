object Form6: TForm6
  Left = 646
  Top = 282
  Width = 297
  Height = 470
  Caption = 'Edycja zwi'#261'zk'#243'w'
  Color = clBtnFace
  Constraints.MaxHeight = 470
  Constraints.MaxWidth = 297
  Constraints.MinHeight = 470
  Constraints.MinWidth = 295
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
    Width = 197
    Height = 13
    Caption = 'Wybierz zwi'#261'zek, kt'#243'ry chcesz edytowa'#263':'
  end
  object Label2: TLabel
    Left = 8
    Top = 208
    Width = 156
    Height = 13
    Caption = 'Wprowadzanie nowych warto'#347'ci:'
  end
  object Label3: TLabel
    Left = 51
    Top = 231
    Width = 39
    Height = 13
    Caption = 'Encja 1.'
  end
  object Label4: TLabel
    Left = 187
    Top = 231
    Width = 39
    Height = 13
    Caption = 'Encja 2.'
  end
  object Label5: TLabel
    Left = 8
    Top = 279
    Width = 74
    Height = 13
    Caption = 'Nazwa zwi'#261'zku'
  end
  object Label6: TLabel
    Left = 40
    Top = 303
    Width = 54
    Height = 13
    Caption = 'Liczebno'#347#263
  end
  object Label7: TLabel
    Left = 176
    Top = 303
    Width = 54
    Height = 13
    Caption = 'Liczebno'#347#263
  end
  object Label8: TLabel
    Left = 56
    Top = 351
    Width = 22
    Height = 13
    Caption = 'Rola'
  end
  object Label9: TLabel
    Left = 192
    Top = 351
    Width = 22
    Height = 13
    Caption = 'Rola'
  end
  object ListBox1: TListBox
    Left = 8
    Top = 24
    Width = 265
    Height = 129
    ItemHeight = 13
    TabOrder = 0
    OnClick = ListBox1Click
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 247
    Width = 129
    Height = 21
    ItemHeight = 13
    Sorted = True
    TabOrder = 1
  end
  object ComboBox2: TComboBox
    Left = 144
    Top = 247
    Width = 129
    Height = 21
    ItemHeight = 13
    Sorted = True
    TabOrder = 2
  end
  object Edit1: TEdit
    Left = 96
    Top = 277
    Width = 177
    Height = 21
    TabOrder = 3
  end
  object ComboBox3: TComboBox
    Left = 40
    Top = 319
    Width = 57
    Height = 21
    ItemHeight = 13
    TabOrder = 4
    Items.Strings = (
      '1'
      '*')
  end
  object ComboBox4: TComboBox
    Left = 176
    Top = 319
    Width = 57
    Height = 21
    ItemHeight = 13
    TabOrder = 5
    Items.Strings = (
      '1'
      '*')
  end
  object Edit2: TEdit
    Left = 8
    Top = 365
    Width = 129
    Height = 21
    TabOrder = 6
  end
  object Edit3: TEdit
    Left = 144
    Top = 365
    Width = 129
    Height = 21
    TabOrder = 7
  end
  object Button1: TButton
    Left = 8
    Top = 399
    Width = 129
    Height = 25
    Caption = 'Zapisz zmiany'
    TabOrder = 8
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 144
    Top = 399
    Width = 129
    Height = 25
    Caption = 'Anuluj'
    TabOrder = 9
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 136
    Top = 168
    Width = 139
    Height = 25
    Caption = 'Usu'#324' zaznaczony zwi'#261'zek'
    TabOrder = 10
    OnClick = Button3Click
  end
end
