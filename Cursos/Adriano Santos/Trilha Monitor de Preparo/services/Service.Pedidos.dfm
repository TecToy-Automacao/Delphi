inherited ServicePedidos: TServicePedidos
  Height = 233
  Width = 370
  object memPedidos: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 64
    Top = 40
    object memPedidosID: TIntegerField
      FieldName = 'ID'
    end
    object memPedidosNOME_CLIENTE: TStringField
      FieldName = 'NOME_CLIENTE'
      Size = 50
    end
    object memPedidosVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
      ProviderFlags = []
    end
    object memPedidosSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 1
    end
    object memPedidosID_GARCOM: TIntegerField
      FieldName = 'ID_GARCOM'
    end
    object memPedidosID_MESA: TIntegerField
      FieldName = 'ID_MESA'
    end
  end
  object memItensPedido: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 256
    Top = 40
    object memItensPedidoID: TIntegerField
      FieldName = 'ID'
    end
    object memItensPedidoID_PEDIDO: TIntegerField
      FieldName = 'ID_PEDIDO'
    end
    object memItensPedidoQTDE: TIntegerField
      FieldName = 'QTDE'
    end
    object memItensPedidoID_PRODUTO: TIntegerField
      FieldName = 'ID_PRODUTO'
    end
    object memItensPedidoNOME: TStringField
      FieldName = 'NOME'
      ProviderFlags = []
      Size = 30
    end
    object memItensPedidoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      ProviderFlags = []
      Size = 100
    end
    object memItensPedidoVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
      ProviderFlags = []
    end
    object memItensPedidoSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 1
    end
    object memItensPedidoID_COMANDA: TIntegerField
      FieldName = 'ID_COMANDA'
    end
  end
  object DtsMaster: TDataSource
    DataSet = memPedidos
    Left = 160
    Top = 112
  end
end
