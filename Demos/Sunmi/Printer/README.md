# SunmiPrinter

## Onde estão os fontes ?
Os fontes desse projeto, forum incorporados ao Projeto ACBr, veja mais informações em **Como Instalar**

## Como instalar
1. Rode o Instalador do Projeto ACBr, e marque o novo Package **ACBr_Android.dpk**
2. Abra o Demo em: *\ACBr\Exemplos\ACBrAndroid\SunmiPrinter*
3. O Projeto ACBr, já distribui a biblioteca **tectoy.jar** em: *\ACBr\Fontes\Terceiros\TecToy*

## Descrição do Projeto
Esse projeto cria o componente ACBrSunmiPrinter, que usará o Serviço de Impressão disponível nos equipamentos da Sunmi.
Isso pode ser útil, qual o equipamento não tem um bom suporte a todas as funcionalidades do ACBrPosPrinter em EscPos, mas observe que no Projeto ACBr, já existe a Unit *\ACBr\Fontes\ACBrSerial\ACBrEscSunmi.pas*, que implemnenta uma Classe compatível com o ABCrPosPrinter, usando o ACBrSunmiPrinter

## Como Funciona
Esse componente depende da biblioteca **tectoy.jar**, que deverá ser anexada em sua aplicação. O código fonte dessa bibliteca, também está aberto, e ela pode ser modificada ou extendida...
https://github.com/TecToy-Automacao/Java/tree/master/jar/Tectoy

Essa biblioteca irá expor Classes nativas do Android, que permitem "pintar" na Segunda Tela
O componente usará o evento OnDraw do Delphi, para gerar um BitMap do Form onde ele está, e enviará esse BitMap para a exibição da biblioteca em Java
Dessa maneira, a aplicação não precisa se preocupar com a atualização da Sefunda Tela, basta trabalhar normalmente como em uma aplicação Delphi
