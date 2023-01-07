# Etiquetas Eventos V2Pro

## Sobre o V2Pro
Trata-se de um SmartPOS, com Impressora, que suporta Bobinas com Etiquetas térmicas  
Saiba mais em: https://tectoyautomacao.com.br/produtos/terminais-moveis/pdv-portatil-v2-pro

## Descrição do Projeto
Esse projeto permite a impressão de Etiquetas para Eventos (crachás) de forma Simples e rápida em um equipamento V2Pro da TecToy

## Modo de Funcionamento
A lista de participantes do evento, pode/deve ser previamente importada no aplicativo, de maneira que ele funcionará, mesmo quando estiver off-line.  
O aplicativo exibirá em sua tela principal, a lista com todos os participantes do evento, caso a mesma já tenha sido previamente importada.  
A lista de usuários será exibida em ordem alfabética, pelo Nome do Usuário.  
O usuário pode digitar na janela de Filtro, dados do participante, como Nome, Empresa ou número da inscrição... O aplicativo aplicará o filtro de forma dinâmica.

Ainda é possível, escanear um QRCode, com o voucher do participante... Esse QRCode deve conter o número da inscrição, e após a leitura do mesmo, o aplicativo exibirá o participante, caso encontre-o na lista.  

Após selecionar um membro da lista de inscritos, o aplicativo altenará para a tela de impressão da Etiqueta.
Nessa Tela, é possível editar ou conferir, antes da Impressão, os dados a serem impressos.  

O aplicativo também permite a impressão de etiquetas de forma avulsa, informando todos os dados de um novo participante, diretamente na interface do programa.

A importação da lista de inscritos usará um endereço em nuvem (no formato http), para baixar um arquivo em formato específico (ver abaixo).  
Após o download do arquivo, o aplicativo exibirá o número de inscritos encontrados no arquivo, e os exibirá na tela principal do aplicativo.

Atualmente, nessa versão, a impressão irá remover a acentuação e cedilha dos Nomes dos incritos, e usará sempre letras MAIÚSCULAS.

Nota: Apesar do V2Pro possuir um Scanner com suporte a códigos 2D, no momento, essa aplicação utiliza a câmera traseira do equipamento, para leitura do QRCode

## Características da Etiqueta
- O Rolo de Etiquetas deve ser térmico
- As etiquetas devem ter o tamanho 60x40mm

## Layout da Etiqueta
A etiqueta conterá os seguintes itens:
- Nome do Participante
- Nomo na Empresa
- Cod.Barras com o número da inscrição (Code39)

## Exemplo de Etiqueta Impressa
Veja na figura abaixo, um Crachá usado no Evento **TecToy na Estrada**. A Caneta na foto, é utilizada para dar uma noção de perspectiva e tamanho

![Exemplo TecToy na Estrada](https://github.com/TecToy-Automacao/Delphi/blob/main/ACBr/V2Pro/EtiquetaEventos/img/Exemplo_Cracha_TecToy_na_Estrada.png)

## Formato do arquivo
O Arquivo deve estar no formato .CSV (TXT formatado), com as seguintes definições:
- O Seprador de Campos, deve ser o caractere **vírgula**
- Cada participante deve estar em uma linha do arquivo
- O arquivo deve usar o Encoding UTF8 (no caso de caracteres acentuados)
- O separador de linha, geralmente será o caractere LF (Linux), mas também pode ser CR+LF (Windows)

## Exemplo de Arquivo
Inscricao1,nome_participante1,nome_empresa1,cargo1  
Inscricao2,nome_participante2,nome_empresa2,cargo2  
Inscricao3,nome_participante3,nome_empresa3,cargo3  
...  
InscricaoN,nome_participanteN,nome_empresaN,cargoN  

Você pode ver um exemplo de arquivo, [nesse link](https://raw.githubusercontent.com/TecToy-Automacao/Delphi/main/ACBr/V2Pro/EtiquetaEventos/csv/exemplo_lista.csv)

Um exemplo de Endereço válido, para baixar o arquivo acima, direto no aplicativo, seria:  
https://raw.githubusercontent.com/TecToy-Automacao/Delphi/main/ACBr/V2Pro/EtiquetaEventos/csv/exemplo_lista.csv

## Configurando o aplicativo
- Clique no icone de Ferramenta, no canto direito superior, do aplicativo  
	- Digite o endereço da URL, de onde baixar a lista (link direto)  
	- Clique no botão "Baixar"  
	- Observe as mensagens de sucesso ou falha, na importação da lista  
- O programa assumirá por padrão, as configurações para a impressão no V2Pro
- Se necessário, modifique os parâmetros de impressão, para melhor ajuste na etiqueta, como:  
	- Linhas de Pulo  
	- Espaços
- Clique em "Salvar" e retorne a tela principal
	
## Usando o Scanner do V2Pro
O V2Pro tem um poderoso Scanner, que lê muito rapidamente códigos de Barras 1D e 2D.. As imagens abaixo, mostram como você pode configurar o seu V2Pro, para fazer uso desse Scanner, em qualquer aplicação

![Tela_V2Pro_ScannerSettings1](https://github.com/TecToy-Automacao/Delphi/blob/main/ACBr/V2Pro/EtiquetaEventos/img/Tela_V2Pro_ScannerSettings1.png)
![Tela_V2Pro_ScannerSettings2](https://github.com/TecToy-Automacao/Delphi/blob/main/ACBr/V2Pro/EtiquetaEventos/img/Tela_V2Pro_ScannerSettings2.png)
![Tela_V2Pro_ScannerSettings3](https://github.com/TecToy-Automacao/Delphi/blob/main/ACBr/V2Pro/EtiquetaEventos/img/Tela_V2Pro_ScannerSettings3.png)
![Tela_V2Pro_ScannerSettings4](https://github.com/TecToy-Automacao/Delphi/blob/main/ACBr/V2Pro/EtiquetaEventos/img/Tela_V2Pro_ScannerSettings4.png)
![Tela_V2Pro_ScannerSettings5](https://github.com/TecToy-Automacao/Delphi/blob/main/ACBr/V2Pro/EtiquetaEventos/img/Tela_V2Pro_ScannerSettings5.png)

## Como abrir o Projeto no Delphi
- **Importante**, esse projeto depende dos componentes do **[Projeto ACBr](https://projetoacbr.com.br/)**
- Se você precisa de mais informações de como baixar e instalar os componentes do ACBr em sua IDE, por favor leia com atenção as intruções dessa página:  
	https://projetoacbr.com.br/fontes/
- Esse projeto foi compilado em Delphi 10.3.3
- Se abrir em versões mais recentes do Delphi, não esqueça de atualizar as Bibliotecas 
	![DelphiAndroid_RevertSystemFilesToDefault](https://github.com/TecToy-Automacao/Delphi/blob/main/ACBr/V2Pro/EtiquetaEventos/img/DelphiAndroid_RevertSystemFilesToDefault.png)

## Download do APK
[APK Compilado](https://raw.githubusercontent.com/TecToy-Automacao/Delphi/main/ACBr/V2Pro/EtiquetaEventos/apk/EtiquetaEventos.apk)

## Histórico
| **Versão** | **Data** | **Autor** | **Mudanças** |  
| --- | --- | --- | --- |  
| 0.9 | 01/08/2022 | DSA | Primeira Versão |  
| 1.0 | 11/09/2022 | DSA | Impressão com Cod.Barras Code93 |  
| 1.1 | 03/10/2022 | DSA | Controle de Presentes e Num.Impressoes por participante |
| 1.2 | 03/09/2022 | DSA | Impressão com Cod.Barras em Code39 |  
