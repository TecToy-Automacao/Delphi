inherited ServiceProdutos: TServiceProdutos
  object memProdutos: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 88
    Top = 56
    object memProdutosID: TIntegerField
      FieldName = 'ID'
    end
    object memProdutosNOME: TStringField
      FieldName = 'NOME'
      Size = 30
    end
    object memProdutosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 100
    end
    object memProdutosVLR_UNITARIO: TFloatField
      FieldName = 'VLR_UNITARIO'
    end
  end
end
