# Etiquetas Eventos V2Pro

## Descrição do Projeto
Esse projeto permite a impressão de Etiquetas para Eventos (crachás) de forma Simples e rápida em um equipamento V2Pro da TecToy

## Modo de Funcionamento
A lista de participantes do evento, pode/deve ser previamente importada no aplicativo, de maneira que ele funcionará, mesmo quando estiver off-line.
Após selecionar um membro da lista de inscritos, os Dados da etiqueta podem ser editados, antes da Impressão.
O aplicativo também permite a impressão de etiquetas de forma avulsa, informando todos os dados de um novo participante, diretamente na interface do programa

A importação da lista de inscritos usará um endereço em nuvem (no formato http), para baixar um arquivo em formato específico (ver abaixo)
Após o download do arquivo, o aplicativo exibirá o número de inscritos baixados, e os exibirá na tela principal do aplicativo

## Características da Etiqueta
- O Rolo de Etiquetas deve ser térmico
- As etiquetas devem ter o tamanho 60x40mm

## Layout da Etiqueta
A etiqueta conterá os seguintes itens:
- Nome do Participante
- Nomo na Empresa
- QRCode, com o número da inscrição

Veja na figura abaixo, um exemplo da impressão

## Formato do arquivo

- O Seprador de Campos, deve ser o caractere vírgula
- O Arquivo deve estar no formato .CSV (TXT formatado), com a seguinte definição de Campos:

Inscricao1,nome_participante1,nome_empresa1
Inscricao2,nome_participante2,nome_empresa2
Inscricao3,nome_participante3,nome_empresa3
...
InscricaoN,nome_participanteN,nome_empresaN


## Histórico
| **Versão** | **Data** | **Autor** | **Mudanças** |
| 0.9 | 01/08/2022 | DSA | Primeira Versão |
| 1.0 | 11/09/2022 | DSA | Adição de Impressão do QRCode |
