object frConfiguraSerial: TfrConfiguraSerial
  Left = 398
  Top = 174
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Porta Serial'
  ClientHeight = 260
  ClientWidth = 178
  Color = clBtnFace
  Constraints.MinHeight = 260
  Constraints.MinWidth = 180
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Pitch = fpVariable
  Font.Style = []
  OldCreateOrder = True
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 8
    Top = 8
    Width = 136
    Height = 13
    Caption = '&Baud rate (Bits por Segundo)'
    Color = clBtnFace
    FocusControl = cmbBaudRate
    ParentColor = False
  end
  object Label6: TLabel
    Left = 8
    Top = 53
    Width = 118
    Height = 13
    Caption = '&Data Bits (Bits de Dados)'
    Color = clBtnFace
    FocusControl = cmbDataBits
    ParentColor = False
  end
  object Label7: TLabel
    Left = 8
    Top = 97
    Width = 77
    Height = 13
    Caption = '&Parity (Paridade)'
    Color = clBtnFace
    FocusControl = cmbParity
    ParentColor = False
  end
  object Label11: TLabel
    Left = 8
    Top = 140
    Width = 120
    Height = 13
    Caption = '&Stop Bits (Bits de Parada)'
    Color = clBtnFace
    FocusControl = cmbStopBits
    ParentColor = False
  end
  object cmbBaudRate: TComboBox
    Left = 8
    Top = 26
    Width = 161
    Height = 21
    ItemHeight = 13
    ItemIndex = 6
    TabOrder = 0
    Text = '9600'
    Items.Strings = (
      '110'
      '300'
      '600'
      '1200'
      '2400'
      '4800'
      '9600'
      '14400'
      '19200'
      '38400'
      '56000'
      '57600'
      '115200')
  end
  object cmbDataBits: TComboBox
    Left = 8
    Top = 69
    Width = 161
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 3
    TabOrder = 1
    Text = '8'
    Items.Strings = (
      '5'
      '6'
      '7'
      '8')
  end
  object cmbParity: TComboBox
    Left = 8
    Top = 114
    Width = 161
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 2
    Text = 'None'
    Items.Strings = (
      'None'
      'Odd'
      'Even'
      'Mark'
      'Space')
  end
  object cmbStopBits: TComboBox
    Left = 8
    Top = 158
    Width = 161
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 3
    Text = '1'
    Items.Strings = (
      '1'
      '1,5'
      '2')
  end
  object BitBtn1: TBitBtn
    Left = 51
    Top = 222
    Width = 75
    Height = 25
    Caption = '&OK'
    TabOrder = 4
    Kind = bkOK
  end
  object chHardFlow: TCheckBox
    Left = 16
    Top = 196
    Width = 63
    Height = 17
    Caption = 'HardFlow'
    TabOrder = 5
  end
  object chSoftFlow: TCheckBox
    Left = 104
    Top = 196
    Width = 59
    Height = 17
    Caption = 'SoftFlow'
    TabOrder = 6
  end
end
