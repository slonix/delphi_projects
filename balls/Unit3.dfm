object Form3: TForm3
  Left = 416
  Top = 279
  BorderStyle = bsSingle
  Caption = 'Kulki'
  ClientHeight = 278
  ClientWidth = 287
  Color = clWhite
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
    Left = 8
    Top = 7
    Width = 67
    Height = 18
    Caption = 'Gracz 1'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clHighlight
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 31
    Width = 11
    Height = 18
    Caption = '0'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 55
    Width = 67
    Height = 18
    Caption = 'Gracz 2'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 8
    Top = 79
    Width = 11
    Height = 18
    Caption = '0'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Image1: TImage
    Left = 98
    Top = 8
    Width = 17
    Height = 17
    Picture.Data = {
      07544269746D6170AA030000424DAA0300000000000036000000280000001100
      000011000000010018000000000074030000232E0000232E0000000000000000
      0000FFFFFFFFFFFFFFFFFFFFFFFFF6F6F6A0A0A0515151232323161616242424
      535353A2A2A2F5F5F5FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFB6
      B6B61F1F1F000000000000000000000000000000000000000000212121B3B3B3
      FCFCFCFFFFFFFFFFFF00FFFFFFFFFFFF95959505050500000000000000000000
      0000000000000000000000000000303030131313909090FCFCFCFFFFFF00FFFF
      FFB7B7B7202020C7C7C7B2B2B222222200000000000000000000000001010173
      7373D9D9D9CBCBCB353535AFAFAFFEFEFE00F7F7F7202020BFBFBFF3F3F3FEFE
      FEF7F7F79B9B9B2C2C2C0202025A5A5AD5D5D5DADADABEBEBE9E9E9E32323223
      2323F0F0F000A2A2A20000000303030707070606062D2D2D8D8D8DD7D7D7D1D1
      D1DFDFDF535353020202000000000000000000000000A3A3A300535353000000
      000000000000050505515151C2C2C2EDEDED818181D8D8D8D3D3D37777772D2D
      2D020202000000000000595959002424240000005E5E5E939393D2D2D2F7F7F7
      8E8E8E6060608383834747476F6F6FE7E7E7E7E7E7E0E0E09C9C9C0000002E2E
      2E00161616000000A9A9A9F9F9F9E4E4E42A2A2A2D2D2D9F9F9F707070A9A9A9
      171717121212C8C8C8FAFAFA5757570000001A1A1A0023232300000001010180
      80803939390000005F5F5F6262628989897B7B7B3A3A3A0000001919194C4C4C
      00000000000030303000515151000000000000000000000000030303747474F1
      F1F1C1C1C1F1F1F16969690000000000000000000000000000005E5E5E009F9F
      9F0000000000000000000000000F0F0FB8B8B8797979BCBCBC727272AFAFAF04
      0404000000000000000000000000ADADAD00F5F5F51D1D1D0000000000000000
      00393939B1B1B1393939E1E1E13A3A3AD3D3D328282800000000000000000027
      2727FAFAFA00FFFFFFB2B2B20202020000000000003B3B3BBDBDBDFFFFFFFFFF
      FFFFFFFFFFFFFF2B2B2B000000000000040404BEBEBEFFFFFF00FFFFFFFFFFFF
      8E8E8E020202000000060606BFBFBFFFFFFFFFFFFFFFFFFFCFCFCF0303030000
      000303039C9C9CFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFAFAFAF1A1A1A000000
      0D0D0D7777779999997C7C7C1111110000001F1F1FB8B8B8FFFFFFFFFFFFFFFF
      FF00FFFFFFFFFFFFFFFFFFFFFFFFF3F3F39898984949491A1A1A0B0B0B1C1C1C
      4D4D4D9E9E9EF6F6F6FFFFFFFFFFFFFFFFFFFFFFFF00}
    Visible = False
  end
  object Image2: TImage
    Left = 98
    Top = 56
    Width = 17
    Height = 17
    Picture.Data = {
      07544269746D6170AA030000424DAA0300000000000036000000280000001100
      000011000000010018000000000074030000232E0000232E0000000000000000
      0000FFFFFFFFFFFFFFFFFFFFFFFFF6F6F6A0A0A0515151232323161616242424
      535353A2A2A2F5F5F5FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFB6
      B6B61F1F1F000000000000000000000000000000000000000000212121B3B3B3
      FCFCFCFFFFFFFFFFFF00FFFFFFFFFFFF95959505050500000000000000000000
      0000000000000000000000000000303030131313909090FCFCFCFFFFFF00FFFF
      FFB7B7B7202020C7C7C7B2B2B222222200000000000000000000000001010173
      7373D9D9D9CBCBCB353535AFAFAFFEFEFE00F7F7F7202020BFBFBFF3F3F3FEFE
      FEF7F7F79B9B9B2C2C2C0202025A5A5AD5D5D5DADADABEBEBE9E9E9E32323223
      2323F0F0F000A2A2A20000000303030707070606062D2D2D8D8D8DD7D7D7D1D1
      D1DFDFDF535353020202000000000000000000000000A3A3A300535353000000
      000000000000050505515151C2C2C2EDEDED818181D8D8D8D3D3D37777772D2D
      2D020202000000000000595959002424240000005E5E5E939393D2D2D2F7F7F7
      8E8E8E6060608383834747476F6F6FE7E7E7E7E7E7E0E0E09C9C9C0000002E2E
      2E00161616000000A9A9A9F9F9F9E4E4E42A2A2A2D2D2D9F9F9F707070A9A9A9
      171717121212C8C8C8FAFAFA5757570000001A1A1A0023232300000001010180
      80803939390000005F5F5F6262628989897B7B7B3A3A3A0000001919194C4C4C
      00000000000030303000515151000000000000000000000000030303747474F1
      F1F1C1C1C1F1F1F16969690000000000000000000000000000005E5E5E009F9F
      9F0000000000000000000000000F0F0FB8B8B8797979BCBCBC727272AFAFAF04
      0404000000000000000000000000ADADAD00F5F5F51D1D1D0000000000000000
      00393939B1B1B1393939E1E1E13A3A3AD3D3D328282800000000000000000027
      2727FAFAFA00FFFFFFB2B2B20202020000000000003B3B3BBDBDBDFFFFFFFFFF
      FFFFFFFFFFFFFF2B2B2B000000000000040404BEBEBEFFFFFF00FFFFFFFFFFFF
      8E8E8E020202000000060606BFBFBFFFFFFFFFFFFFFFFFFFCFCFCF0303030000
      000303039C9C9CFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFAFAFAF1A1A1A000000
      0D0D0D7777779999997C7C7C1111110000001F1F1FB8B8B8FFFFFFFFFFFFFFFF
      FF00FFFFFFFFFFFFFFFFFFFFFFFFF3F3F39898984949491A1A1A0B0B0B1C1C1C
      4D4D4D9E9E9EF6F6F6FFFFFFFFFFFFFFFFFFFFFFFF00}
    Visible = False
  end
  object BitBtn2: TBitBtn
    Left = 9
    Top = 104
    Width = 101
    Height = 29
    Caption = 'Zakoncz rozgrywke'
    TabOrder = 0
    OnClick = BitBtn2Click
  end
end
