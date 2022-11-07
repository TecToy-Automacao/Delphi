unit Comanda.SQL.Constantes;

interface

const
  SQL_PEDIDOS            =
    'SELECT                         ' +
    '  ID,                          ' +
    '  NOME_CLIENTE,                ' +
    '  VALOR_TOTAL,                 ' +
    '  STATUS,                      ' +
    '  ID_GARCOM,                   ' +
    '  ID_MESA                      ' +
    'FROM                           ' +
    '  PEDIDO PED                   ' +
    'WHERE                          ' +
    '      STATUS = ''A''           ' +
    '  AND ID_GARCOM = :pID_GARCOM  ' +
    'ORDER BY                       ' +
    '  ID                           ';

  SQL_PEDIDO_BY_MESA     =
    'SELECT                         ' +
    '  ID,                          ' +
    '  NOME_CLIENTE,                ' +
    '  VALOR_TOTAL,                 ' +
    '  STATUS,                      ' +
    '  ID_GARCOM,                   ' +
    '  ID_MESA                      ' +
    'FROM                           ' +
    '  PEDIDO PED                   ' +
    'WHERE                          ' +
    '      STATUS = ''A''           ' +
    '  AND ID_GARCOM = :pID_GARCOM  ' +
    '  AND ID_MESA   = :pID_MESA    ' +
    'ORDER BY                       ' +
    '  ID                           ';

  SQL_ITENS_PEDIDO =
    'SELECT                                         ' +
    '  IT.ID,                                        ' +
    '  IT.ID_PEDIDO,                                 ' +
    '  IT.ID_PRODUTO,                                ' +
    '  IT.QTDE,                                      ' +
    '  PD.NOME,                                      ' +
    '  PD.DESCRICAO,                                 ' +
    '  SUM(IT.QTDE * PD.VLR_UNITARIO) AS VALOR_TOTAL ' +
    'FROM                                            ' +
    '  ITEM_PEDIDO IT                                ' +
    '  INNER JOIN PRODUTO PD                         ' +
    '  ON IT.ID_PRODUTO = PD.ID                      ' +
    'WHERE                                           ' +
    '  ID_PEDIDO = :pID_PEDIDO                       ' +
    'GROUP BY                                        ' +
    '  IT.ID,                                        ' +
    '  IT.ID_PEDIDO,                                 ' +
    '  IT.ID_PRODUTO,                                ' +
    '  IT.QTDE,                                      ' +
    '  PD.NOME,                                      ' +
    '  PD.DESCRICAO                                  ';


  SQL_PRODUTOS     =
    'SELECT           ' +
    '  ID           , ' +
    '  NOME         , ' +
    '  DESCRICAO    , ' +
    '  VLR_UNITARIO   ' +
    'FROM             ' +
    '  PRODUTO        ' +
    'ORDER BY         ' +
    '  DESCRICAO      ';

  //SQL_MESAS        =

implementation

end.
