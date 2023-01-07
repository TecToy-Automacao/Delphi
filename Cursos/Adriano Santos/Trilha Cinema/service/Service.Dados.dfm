object ServiceDados: TServiceDados
  OldCreateOrder = False
  Height = 475
  Width = 943
  object fdConn: TFDConnection
    Params.Strings = (
      
        'Database=C:\Projetos\TecToy_Oficial\Cursos\Adriano Santos\databa' +
        'ses\Filmes.db'
      'OpenMode=ReadWrite'
      'DriverID=SQLite')
    LoginPrompt = False
    BeforeConnect = fdConnBeforeConnect
    Left = 40
    Top = 24
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 192
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 192
    Top = 80
  end
  object QryFilmes: TFDQuery
    Connection = fdConn
    SQL.Strings = (
      'SELECT * FROM FILMES ORDER BY TITULO')
    Left = 40
    Top = 80
    object QryFilmesID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
    end
    object QryFilmesTITULO: TStringField
      FieldName = 'TITULO'
      Origin = 'TITULO'
      Size = 200
    end
    object QryFilmesSINOPSE: TStringField
      FieldName = 'SINOPSE'
      Origin = 'SINOPSE'
      Size = 300
    end
    object QryFilmesFOTO: TBlobField
      FieldName = 'FOTO'
      Origin = 'FOTO'
    end
    object QryFilmesAVALIACAO: TIntegerField
      FieldName = 'AVALIACAO'
      Origin = 'AVALIACAO'
    end
  end
end
