# SecondDisplay

## Descrição do Projeto
Esse pretende criar uma classe, que permitirá aplicações Delphi, acessar fácilmente recursos da Segunda Tela, em aparelhos Android

Equipamentos com duas telas, são um grande diferencial para aplicações de Ponto de Venda, permitindo às aplicações exibir o Total da Venda, Promoções, Imagens do Produto Vendido, QRCode para pagamento, etc

- Exemplo de equipamento com 2 Telas  
	https://tectoyautomacao.com.br/produtos/terminais-pdv/pdv-desktop-t2s
	https://tectoyautomacao.com.br/produtos/terminais-pdv/pos-desktop-d2-mini

## Como Funciona
Esse componente depende da biblioteca *Lib\SecondDisplay.jar*, que deverá ser anexada em sua aplicação. O código fonte dessa bibliteca, também está aberto, e ela pode ser modificada ou extendida...  
Essa biblioteca irá expor Classes nativas do Android, que permitem "pintar" na Segunda Tela
O componente usará o evento OnDraw do Delphi, para gerar um BitMap do Form onde ele está, e enviará esse BitMap para a exibição da biblioteca em Java
Dessa maneira, a aplicação não precisa se preocupar com a atualização da Sefunda Tela, basta trabalhar normalmente como em uma aplicação Delphi

## Como instalar
1. Instale o componente em *Componente\FMX.ACBr.dpk*
2. Abra o Demo em: *TestSecondDisplay\TesteSegundaTela.dproj*
