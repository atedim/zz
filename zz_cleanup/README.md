# zz_cleanup

`zz_cleanup` e a versao consolidada do `zz_del_old` com a mecanica de temporarios do `zz_temp`.

## Ordem de execucao

1. Limpa temporarios por tipo/padrao.
2. Limpa arquivos antigos por `DATA_CORTE` ou `DAYS_OLD`.
3. Limpa pastas vazias em profundidade.
4. Registra estatisticas finais.

Essa ordem e importante porque a limpeza de arquivos, tanto temporarios quanto antigos, pode deixar pastas vazias para a ultima etapa.

Tambem e possivel executar cada etapa separadamente quando necessario.

## Criterio de temporarios

A primeira etapa usa a mecanica do `zz_temp`, padronizada e protegida:

| Tipo | Criterio | Idade |
| --- | --- | --- |
| `*.tmp` | `-iname` | Mais de `TEMP_DAYS` dias |
| `~*` | `-name` | Mais de `TEMP_DAYS` dias |
| `*.lnk` | `-iname` | Mais de `TEMP_DAYS` dias |
| `Novo(a)*` | arquivo com tamanho zero | Sem criterio de idade |
| `Nova pasta*` | pasta vazia | Sem criterio de idade |

Valor atual:

```bash
TEMP_DAYS=3
```

## Criterio de arquivos antigos

Existem dois parametros:

```bash
DATA_CORTE=""
DAYS_OLD=1000
```

A regra e:

- Se `DATA_CORTE` estiver preenchida, ela prevalece.
- Se `DATA_CORTE` estiver vazia, o script usa `DAYS_OLD`.

Com a configuracao atual, `DATA_CORTE` esta vazia, entao o script usa `DAYS_OLD=1000`.

## Diretorios

Configuracao atual:

```bash
DEFAULT_TARGET_DIR="/dr/bkp/filiais"
EXCLUDE_DIR="/dr/bkp/matriz"
LOG_BASE_DIR="/var/log/zz_cleanup"
```

Esses valores podem ser sobrescritos por variaveis de ambiente, sem editar o script:

```bash
DEFAULT_TARGET_DIR="/tmp/teste" LOG_BASE_DIR="/tmp/logs" ./zz_cleanup log
```

O script nao remove nem percorre arquivos dentro de `EXCLUDE_DIR` durante as buscas de arquivos. Na limpeza de pastas vazias, ele tambem filtra `EXCLUDE_DIR` e seus filhos.

## Modos

```bash
./zz_cleanup [modo] [acao] [diretorio]
```

| Modo | Alias | Acao |
| --- | --- | --- |
| `log` | `l` | Apenas registra o que seria afetado, sem remover. |
| `silent` | `s` | Remove normalmente, sem output no terminal. |
| `verbose` | `v` | Remove normalmente, mostrando acoes. |
| `cron` | `full-silent`, `fs` | Executa `full` silencioso, mantendo log. |
| `help` | `h` | Mostra ajuda. |

## Acoes

| Acao | Alias | Etapa executada |
| --- | --- | --- |
| `full` | `all`, `completo` | Executa temporarios, arquivos antigos e pastas vazias. |
| `temp` | `temps`, `temporarios` | Executa apenas limpeza de temporarios. |
| `old` | `antigos` | Executa apenas limpeza de arquivos antigos. |
| `empty` | `pastas`, `vazias` | Executa apenas limpeza de pastas vazias. |

Se nenhuma acao for informada, o padrao e `full`.

Exemplos:

```bash
./zz_cleanup log
./zz_cleanup verbose /dr/bkp/filiais
./zz_cleanup silent /dr/bkp/filiais
./zz_cleanup temp log
./zz_cleanup old verbose /dr/bkp/filiais
./zz_cleanup empty silent /dr/bkp/filiais
./zz_cleanup cron
```

Os argumentos podem ser informados em ordem flexivel. Por exemplo, `./zz_cleanup temp log` e `./zz_cleanup log temp` executam a mesma acao: somente temporarios, sem remover fisicamente.

## Uso em crontab

Para crontab, use o modo `cron`, `full-silent` ou `fs`. Ele executa o fluxo completo, nao escreve no terminal e registra tudo em arquivo de log:

```cron
0 2 * * * /caminho/zz_cleanup/zz_cleanup cron
```

Se quiser garantir silencio absoluto tambem para mensagens externas do cron, pode usar:

```cron
0 2 * * * /caminho/zz_cleanup/zz_cleanup cron >/dev/null 2>&1
```

O log do proprio script continua sendo gravado em `LOG_BASE_DIR`.

## Estatisticas

O log inclui:

- perfil de execucao;
- acao executada;
- etapas habilitadas;
- snapshot de temporarios antes da execucao;
- snapshot de temporarios depois da execucao;
- quantidade e tamanho de temporarios candidatos;
- quantidade e tamanho de temporarios removidos;
- quantidade e tamanho de temporarios apenas listados em modo `log`;
- quantidade e tamanho de arquivos antigos candidatos;
- quantidade e tamanho de arquivos antigos removidos;
- quantidade e tamanho de arquivos antigos apenas listados em modo `log`;
- pastas vazias candidatas;
- pastas vazias removidas;
- pastas vazias listadas em modo `log`;
- erros por grupo.

## Seguranca

O script usa:

- `find ... -print0` e `read -d ''` para suportar espacos e caracteres especiais;
- `rm -f -- "$FILE"` para arquivos;
- `rmdir -- "$DIR"` para pastas, removendo apenas pastas realmente vazias;
- `-mindepth 1` para nao remover o diretorio alvo;
- `-depth` na limpeza de pastas para processar subpastas antes das pastas pai;
- codigo de saida `1` quando alguma remocao falha.

## Validacao local

Foi feita validacao de sintaxe com o Bash do Git para Windows:

```bash
bash -n zz_cleanup
```

Tambem foi feita uma execucao completa em modo `log`, apontando para o workspace e gravando log dentro de `zz_cleanup/logs`:

```bash
DEFAULT_TARGET_DIR="." \
EXCLUDE_DIR="./.nao_existe" \
LOG_BASE_DIR="zz_cleanup/logs" \
DATA_CORTE="" \
DAYS_OLD="1000" \
TEMP_DAYS="3" \
./zz_cleanup log
```

Essa execucao validou o fluxo sem remocao fisica:

- etapa de temporarios;
- snapshots antes/depois;
- etapa de arquivos antigos;
- etapa final de pastas vazias;
- estatisticas finais;
- criacao de log.

Tambem foram validados os formatos de chamada por etapa e o modo de cron:

```bash
./zz_cleanup temp log
./zz_cleanup old log
./zz_cleanup empty log
./zz_cleanup cron
```

O modo `cron` foi validado sem output no terminal e com log contendo:

- `Modo: silent`;
- `Perfil: cron`;
- `Acao: full`;
- as tres etapas habilitadas.

O WSL da maquina existe, mas nao tem distribuicao Linux instalada; por isso a validacao nao foi feita pelo Bash do WSL.
