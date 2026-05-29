# zz_toolong

Script Linux para verificar caminhos longos de pastas e arquivos.

## O que o script mede

Para arquivos, o `zz_toolong.sh` mede tres tamanhos diferentes:

- `LIMITE_PASTAS=230`: tamanho do caminho relativo das pastas, sem contar o nome do arquivo.
- `LIMITE_NOME_ARQUIVO=30`: tamanho somente do nome do arquivo.
- `LIMITE_TOTAL=257`: tamanho do caminho relativo total, somando pastas, barras e nome do arquivo.
- `ANISTIA=0`: quantidade de caracteres descontada de cada medicao antes da comparacao.
- `ignora_temp=N`: use `S` para ignorar arquivos temporarios do Office que comecam com `~$`.
- `INTERVALO_STATUS=1000`: mostra progresso no terminal a cada 1000 itens analisados. Use `0` para desligar.

Para pastas, o script mede o tamanho do caminho relativo da propria pasta e compara com `LIMITE_PASTAS`.

A anistia e aplicada uma unica vez em cada medicao. Por exemplo, com `ANISTIA=10`, um nome de arquivo com 62 caracteres sera considerado como 52. Um caminho de pastas com 270 caracteres sera considerado como 260. No tamanho total, o desconto tambem acontece uma unica vez sobre o caminho total completo, sem descontar novamente as partes separadas.

## Como usar

Uso simples:

```bash
chmod +x zz_toolong.sh
./zz_toolong.sh /caminho/da/pasta/para/analisar
```

Se nenhum caminho for informado, o script analisa a pasta atual:

```bash
./zz_toolong.sh
```

## Parametros

Voce pode passar limites sem editar o script:

```bash
./zz_toolong.sh /dados/bkp/filiais/40 --pastas 230 --arquivo 40 --total 257 --anistia 10 --ignora-temp S
```

Opcoes disponiveis:

```text
--pastas N       Limite para caminho de pastas.
--arquivo N      Limite para nome de arquivo.
--total N        Limite para caminho total.
--anistia N      Desconto aplicado uma vez em cada medicao.
--ignora-temp S  Ignora arquivos temporarios do Office que comecam com ~$.
--ignora-temp N  Nao ignora arquivos temporarios do Office.
--status N       Mostra progresso a cada N itens analisados. Use 0 para desligar.
--log ARQUIVO    Nome do arquivo de log.
--help           Mostra a ajuda.
```

## Log

O script cria um log com nome parecido com:

```text
zz_toolong_20260528_093000.log
```

O relatorio e ordenado pelo maior excesso primeiro, para os piores casos aparecerem no topo.

Exemplo de entrada para arquivo:

```text
[ARQUIVO]
Motivo: pastas>230, nome_arquivo>30, total>257
Maior excesso: 49 caracteres
Excedeu pastas em: 8 caracteres
Excedeu nome do arquivo em: 2 caracteres
Excedeu total em: 49 caracteres
Anistia: 10
Tamanho real das pastas: 248
Tamanho considerado das pastas: 238
Limite das pastas: 230
Tamanho real do nome do arquivo: 42
Tamanho considerado do nome do arquivo: 32
Limite do nome do arquivo: 30
Tamanho real total: 316
Tamanho considerado total: 306
Limite total: 257
Nome do arquivo: Ronda Posto O- Junho .xlsx
Caminho das pastas: filiais/40/inspetores/Noturno/Ednaldo (Rota 601)/Posto Caixa e Posto O Banco do Brasil
Caminho relativo total: filiais/40/inspetores/Noturno/Ednaldo (Rota 601)/Posto Caixa e Posto O Banco do Brasil/Ronda Posto O- Junho .xlsx
Caminho completo: /dados/filiais/40/inspetores/Noturno/Ednaldo (Rota 601)/Posto Caixa e Posto O Banco do Brasil/Ronda Posto O- Junho .xlsx
```

No final, o log inclui um resumo com totais de pastas, arquivos, alertas por tipo de limite e arquivos temporarios ignorados.
