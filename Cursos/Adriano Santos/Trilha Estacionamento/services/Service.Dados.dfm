object ServiceDados: TServiceDados
  OldCreateOrder = False
  Height = 293
  Width = 511
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 224
    Top = 16
  end
  object fdConn: TFDConnection
    Params.Strings = (
      
        'Database=C:\Projetos\TecToy_Oficial\Cursos\Adriano Santos\databa' +
        'ses\Park.db'
      'OpenMode=ReadWrite'
      'DriverID=SQLite')
    LoginPrompt = False
    BeforeConnect = fdConnBeforeConnect
    Left = 40
    Top = 16
  end
  object QryCarros: TFDQuery
    Connection = fdConn
    SQL.Strings = (
      'SELECT * FROM CARROS WHERE BAIXADO = 0 ORDER BY PLACA')
    Left = 40
    Top = 72
    object QryCarrosPLACA: TStringField
      FieldName = 'PLACA'
      Origin = 'PLACA'
      Required = True
      Size = 8
    end
    object QryCarrosMARCA: TStringField
      FieldName = 'MARCA'
      Origin = 'MARCA'
      Size = 50
    end
    object QryCarrosMODELO: TStringField
      FieldName = 'MODELO'
      Origin = 'MODELO'
      Size = 100
    end
    object QryCarrosDATA_ENTRADA: TDateField
      FieldName = 'DATA_ENTRADA'
      Origin = 'DATA_ENTRADA'
    end
    object QryCarrosHORA_ENTRADA: TTimeField
      FieldName = 'HORA_ENTRADA'
      Origin = 'HORA_ENTRADA'
    end
    object QryCarrosDATA_SAIDA: TDateField
      FieldName = 'DATA_SAIDA'
      Origin = 'DATA_SAIDA'
    end
    object QryCarrosHORA_SAIDA: TTimeField
      FieldName = 'HORA_SAIDA'
      Origin = 'HORA_SAIDA'
    end
    object QryCarrosTOTAL: TFloatField
      FieldName = 'TOTAL'
      Origin = 'TOTAL'
    end
    object QryCarrosTICKET: TIntegerField
      FieldName = 'TICKET'
      Origin = 'TICKET'
    end
    object QryCarrosBAIXADO: TIntegerField
      FieldName = 'BAIXADO'
      Origin = 'BAIXADO'
    end
    object QryCarrosCOR: TStringField
      FieldName = 'COR'
      Origin = 'COR'
      Size = 30
    end
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 224
    Top = 72
  end
  object QryIncTicket: TFDQuery
    Connection = fdConn
    SQL.Strings = (
      'SELECT MAX(TICKET) + 1 AS MAX_TICKET FROM CARROS')
    Left = 224
    Top = 144
    object QryIncTicketMAX_TICKET: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'MAX_TICKET'
      Origin = 'MAX_TICKET'
      ProviderFlags = []
      ReadOnly = True
    end
  end
end
