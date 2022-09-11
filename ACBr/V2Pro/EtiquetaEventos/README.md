# Etiquetas Eventos V2Pro

## Descrição do Projeto
Esse projeto permite a impressão de Etiquetas para Eventos (crachás) de forma Simples e rápida em um equipamento V2Pro da TecToy

## Modo de Funcionamento
A lista de participantes do evento, pode/deve ser previamente importada no aplicativo, de maneira que ele funcionará, mesmo quando estiver off-line.
O aplicativo exibirá em sua tela principal, a lista com todos os participantes do evento, caso a mesma já tenha sido previamente importada.
O usuário pode digitar na janela de Filtro, dados do participante, como Nome, Empresa ou número da inscrição... O aplicativo aplicará o filtro de forma dinâmica.

Ainda é possível, escanear um QRCode, com o voucher do participante... Esse QRCode deve conter o número da inscrição, e após a leitura do mesmo, o aplicativo exibirá o participante, caso encontre-o na lista.  

Após selecionar um membro da lista de inscritos, o aplicativo altenará para a tela de impressão da Etiqueta.
Nessa Tela, é possível editar ou conferir, antes da Impressão, os dados a serem impressos.  

O aplicativo também permite a impressão de etiquetas de forma avulsa, informando todos os dados de um novo participante, diretamente na interface do programa.

A importação da lista de inscritos usará um endereço em nuvem (no formato http), para baixar um arquivo em formato específico (ver abaixo).  
Após o download do arquivo, o aplicativo exibirá o número de inscritos encontrados no arquivo, e os exibirá na tela principal do aplicativo.

Atualmente, nessa versão, a impressão irá remover a acentuação e cedilha dos Nomes dos incritos, e usará sempre letras MAIÚSCULAS.

## Características da Etiqueta
- O Rolo de Etiquetas deve ser térmico
- As etiquetas devem ter o tamanho 60x40mm

## Layout da Etiqueta
A etiqueta conterá os seguintes itens:
- Nome do Participante
- Nomo na Empresa
- QRCode, com o número da inscrição

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
Inscricao1,nome_participante1,nome_empresa1  
Inscricao2,nome_participante2,nome_empresa2  
Inscricao3,nome_participante3,nome_empresa3  
...  
InscricaoN,nome_participanteN,nome_empresaN  

Você pode ver um exemplo de arquivo, [nesse link](https://raw.githubusercontent.com/TecToy-Automacao/Delphi/main/ACBr/V2Pro/EtiquetaEventos/csv/exemplo_lista.csv)

Um exemplo de Endereço válido, para baixar o arquivo acima, direto no aplicativo, seria:  
https://raw.githubusercontent.com/TecToy-Automacao/Delphi/main/ACBr/V2Pro/EtiquetaEventos/csv/exemplo_lista.csv

## Configurando o aplicativo
- Clique no icone de Ferramenta, no canto esquerdo superior, do aplicativo  
	- Digite o endereço da URL, de onde baixar a lista (link direto)  
	- Clique no botão "Baixar"  
	- Observe as mensagens de sucesso ou falha, na importação da lista  
- O programa assumirá por padrão, as configurações para a impressão no V2Pro
- Se necessário, modifique os parâmetros de impressão, para melhor ajuste na etiqueta, como:  
	- Linhas de Pulo  
	- Espaços
- Clique em "Salvar" e retorne a tela principal
	
## Como abrir o Projeto
- **Importante**, esse projeto depende dos componentes do **[Projeto ACBr](https://projetoacbr.com.br/)**
- Se você precisa de mais informações de como baixar e instalar os componentes do ACBr em sua IDE, por favor leia com atenção as intruções dessa página:  
	https://projetoacbr.com.br/fontes/
- Esse projeto foi compilado em Delphi 10.3.3
- Se abrir em versões mais recentes do Delphi, não esqueça de atualizar as Bibliotecas 
	![DelphiAndroid_RevertSystemFilesToDefault](https://github.com/TecToy-Automacao/Delphi/blob/main/ACBr/V2Pro/EtiquetaEventos/img/DelphiAndroid_RevertSystemFilesToDefault.png)

## Histórico
| **Versão** | **Data** | **Autor** | **Mudanças** |  
| --- | --- | --- | --- |  
| 0.9 | 01/08/2022 | DSA | Primeira Versão |  
| 1.0 | 11/09/2022 | DSA | Adição de Impressão do QRCode |  
