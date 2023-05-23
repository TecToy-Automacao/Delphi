# SecondDisplay

## Onde estão os fontes ?
Os fontes desse projeto, forum incorporados ao Projeto ACBr, veja mais informações em **Como Instalar**

## Como instalar
1. Rode o Instalador do Projeto ACBr, e marque o novo Package **ACBr_Android.dpk**
2. Abra o Demo em: *\ACBr\Exemplos\ACBrAndroid\SecondDisplay*
3. O Projeto ACBr, já distribui a biblioteca **tectoy.jar** em: *\ACBr\Fontes\Terceiros\TecToy*

## Descrição do Projeto
Esse pretende criar uma classe, que permitirá aplicações Delphi, acessar fácilmente recursos da Segunda Tela, em aparelhos Android

Equipamentos com duas telas, são um grande diferencial para aplicações de Ponto de Venda, permitindo às aplicações exibir o Total da Venda, Promoções, Imagens do Produto Vendido, QRCode para pagamento, etc

- Exemplo de equipamento com 2 Telas  
	https://tectoyautomacao.com.br/produtos/terminais-pdv/pdv-desktop-t2s  
	https://tectoyautomacao.com.br/produtos/terminais-pdv/pos-desktop-d2-mini  


## Como Funciona
Esse componente depende da biblioteca **tectoy.jar**, que deverá ser anexada em sua aplicação. O código fonte dessa bibliteca, também está aberto, e ela pode ser modificada ou extendida...
https://github.com/TecToy-Automacao/Java/tree/master/jar/Tectoy

Essa biblioteca irá expor Classes nativas do Android, que permitem "pintar" na Segunda Tela
O componente usará o evento OnDraw do Delphi, para gerar um BitMap do Form onde ele está, e enviará esse BitMap para a exibição da biblioteca em Java
Dessa maneira, a aplicação não precisa se preocupar com a atualização da Sefunda Tela, basta trabalhar normalmente como em uma aplicação Delphi
