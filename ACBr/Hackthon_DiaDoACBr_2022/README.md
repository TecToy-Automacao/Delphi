# Desafio Hackthon Dia do ACBr 2022

## Descrição do Projeto
Esse projeto demonstra como vencer todas as etapas do Desafio do Hackthon que foi apresentado no **Dia do ACBr 2022**
![ScreenShot](https://github.com/Projeto-ACBr-Oficial/ACBrLab/blob/main/Pascal/Hackthon/img/ScreenShot_Hackthon1.png)

## Você aprende nesse Demo
Estudando os fontes desse projeto você terá exemplo de como efetuar as seguintes tarefas:
- Ler uma Tag NFC, sob demanda
- Consumir uma API Rest
- Decodificar uma String de Base64
- Descompactar uma String em Zip (ZipFile, PKZip)
- Imprimir usando Bluetooh
- Imprimir um QRCode usando Esc\Pos


## Project Deployment
Observe que adicionamos as bibliotecas do `OpenSSL`, no Deploy do Projeto
Você pode encontrar elas na subpasta `so`

## Permissões
Esse projeto precisa de permissões de `NFC` e `Bluetooh` (para impressão)

## Créditos
A leitura de NFC foi feita através de um exemplo do artigo de Brian Long  
http://blong.com/Articles/Delphi10NFC/NFC.htm  

A consulta a API usa a poderosa biblioteca Synapse, com OpenSSL, para  comunicação Segura  
http://www.ararat.cz/synapse/doku.php  

A impressão e várias funções utilitárias, ficam por conta dos fontes do Projeto ACBr  
https://www.projetoacbr.com.br/  

## Testes
Utilizamos um V2Pro da TecToy, para nossos testes  
https://tectoyautomacao.com.br/produtos/terminais-moveis/pdv-portatil-v2-pro  

# Desafio Hackathon
Os times devem criar uma aplicação que contenha um Memo, para exibir os resultados, e botões, que comprovem o funcionamento dos passos a seguir

## 1  – RFID
Todos os participantes recebem um Cartão com um RFID.  
Os times devem criar uma rotina, que leia o conteúdo do RFID, e exibam o mesmo, na tela da aplicação.  
O Conteúdo do RFID, terá as instruções para a próxima fase. Exemplo de conteúdo:  
`"POST https://projetoacbr.com.br/hackathon?cod=2034CA53-866A-449A-BF33-8804359B6A4F Body:DiaDoACBr2022 ct:text/plain"`

## 2 – Consumo de API
Usando o código obtido na fase 1, o time deve fazer um POST na API do Projeto ACBr  
"POST https://projetoacbr.com.br/hackathon?cod=2034CA53-866A-449A-BF33-8804359B6A4F  

O conteúdo do Body deve ser `DiaDoACBr2022`, cujo content type é `text/plain`  

A Resposta dessa API, será uma String em Base64.  
Após converter de Base64 para binário, o conteúdo do Stream será um dado compactado, usando o Algoritmo PKZIP (ou ZipFile)  

## 3 – Descompactando
Para saber o que deve ser feito com esse Stream, os times devem prestar atenção no cabeçalho do Stream, que dá a compreender que trata-se de um conteúdo Zipado.
Exemplo:  
![DicaConteudoZip](https://github.com/Projeto-ACBr-Oficial/ACBrLab/blob/main/Pascal/Hackthon/img/DicaConteudoZip.png)

A aplicação deverá usar o Stream obtido por HTTP, no passo 2, decodificar de Base64, e descompactar o mesmo, para obter a String legível com instruções para o próximo passo.  
Exemplo de Conteúdo final:

`Parabéns Equipe 1,  você conseguiu vencer essa etapa.`  
` `   
`Agora como teste Final, você deve Imprimir um QRCode com o seguinte conteúdo:`  
` `  
`Somos a equipe 1.`  
`Completamos o desafio.`  
`Nosso código final:`  
`0A696E6D-2A61-4A98-A285-C38250B65994`  

## 4 – Impressão de QRCode
A aplicação deve imprimir um QRCode, com o texto obtido no passo 3  
