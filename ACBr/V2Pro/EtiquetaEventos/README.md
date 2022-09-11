# Etiquetas Eventos V2Pro

## Descrição do Projeto
Esse projeto permite a impressão de Etiquetas para Eventos (crachás) de forma Simples e rápida em um equipamento V2Pro da TecToy

## Modo de Funcionamento
A lista de participantes do evento, pode/deve ser previamente importada no aplicativo, de maneira que ele funcionará, mesmo quando estiver off-line.
Após selecionar um membro da lista de inscritos, os Dados da etiqueta podem ser editados ou conferidos, antes da Impressão.
O aplicativo também permite a impressão de etiquetas de forma avulsa, informando todos os dados de um novo participante, diretamente na interface do programa

A importação da lista de inscritos usará um endereço em nuvem (no formato http), para baixar um arquivo em formato específico (ver abaixo)
Após o download do arquivo, o aplicativo exibirá o número de inscritos encontrados no arquivo, e os exibirá na tela principal do aplicativo

Atualmente, nessa versão a impressão irá remover a acentuação e cedilha dos Nomes dos incritos, e usará sempre letras MAIÚSCULAS.

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
