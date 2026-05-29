# zz_copiade

Script bash para localizar arquivos antigos cujo nome tenha varias ocorrencias de `copia` ou `cópia`, ignorando acentos e maiusculas/minusculas.

## Como usar

Edite as variaveis no bloco `CONFIGURACAO` no comeco do arquivo `zz_copiade.sh`:

```bash
TARGET_DIR="."
MIN_COPIA_COUNT=3
MIN_AGE_DAYS=30
REMOVE_MATCHES=false
LOG_FILE="./zz_copiade.log"
```

Depois execute:

```bash
chmod +x zz_copiade.sh
./zz_copiade.sh "/caminho/da/pasta"
```

Por padrao ele apenas registra no log:

```bash
./zz_copiade.sh "/mnt/arquivos"
```

Para ajustar o filtro:

```bash
# Edite no script:
MIN_COPIA_COUNT=5
MIN_AGE_DAYS=90
```

Para remover os arquivos encontrados:

```bash
# Edite no script:
REMOVE_MATCHES=true
```

Para escolher o arquivo de log:

```bash
# Edite no script:
LOG_FILE="/tmp/zz_copiade.log"
```

## Variaveis

| Variavel | Padrao | Descricao |
| --- | --- | --- |
| `TARGET_DIR` | `.` | Pasta verificada quando nenhum argumento e passado. |
| `MIN_COPIA_COUNT` | `3` | Quantidade minima de ocorrencias de `copia`/`cópia` no nome. |
| `MIN_AGE_DAYS` | `30` | Arquivo precisa ter modificacao mais antiga que essa quantidade de dias. |
| `REMOVE_MATCHES` | `false` | Quando `true`, remove os arquivos filtrados. |
| `LOG_FILE` | `./zz_copiade.log` | Caminho do arquivo de log. |

## Log

Cada arquivo listado mostra a quantidade de copias no nome e a idade em dias:

```text
2026-05-28 11:36:21 | encontrado | copias=9 | idade_dias=1372 | minimo_dias=30 | modificado=2022-08-25 06:31:30 | arquivo=/dados/exemplo.xlsx
```

O script so registra ou remove arquivos com `idade_dias` maior que `MIN_AGE_DAYS`.

## Exemplo de alvo

Um arquivo como:

```text
PANILHA MOVIMENTAÇÃO 08 11 21 - Copia - Cópia - Copia - Cópia.xlsx
```

sera contado como 4 ocorrencias de `copia`.
