# Documentacao dos scripts `zz_*`

Inventario gerado em 2026-03-30 15:00:52. Foram encontrados **63** scripts Bash dentro de zz/.

## Premissas gerais
- O acervo foi pensado principalmente para Linux, com inclinacao a Debian/Ubuntu, `systemd` e uso frequente de root/sudo.
- Muitos scripts assumem a existencia de caminhos fixos como `/etc/scripts`, `/dados`, `/work`, `/dr` e pontos em `/mnt`.
- Varios arquivos guardam credenciais ou tokens diretamente no corpo do script ou em `.conf`; revise isso antes de usar em producao.
- O arquivo `dependências.txt` na raiz consolida programas, pacotes e servicos externos requeridos pelo conjunto todo.

## Scripts documentados
### zz
- zz/isync -> documentacao/zz/isync.md
  Função para executar cada opção de sincronia
- zz/syncALL -> documentacao/zz/syncALL.md
  Wrapper para executar uma ou mais sincronizacoes zz_sync com pares ja definidos.
- zz/zz_apagar -> documentacao/zz/zz_apagar.md
  Script: limpa_pastas.sh Função: Lista ou apaga pastas contidas em um arquivo de texto comando pra limpar uma lista
- zz/zz_attrcopy -> documentacao/zz/zz_attrcopy.md
  Nome.........: zz_attrcopy Descrição....: Copia owner, group e permissões (incluindo bits especiais) de um arquivo origem para um destino.
- zz/zz_careful -> documentacao/zz/zz_careful.md
  limpa_dir_rapido.sh - Limpa completamente uma pasta de forma otimizada ./limpa_dir_rapido.sh [CAMINHO_DA_PASTA] [-v|--verbose] CAMINHO_DA_PASTA Diretório que será limpo. Se não for informado, usa a pasta atual.
- zz/zz_del_old -> documentacao/zz/zz_del_old.md
  SCRIPT: zz_del_old DESCRICAO: Lista e remove arquivos antigos em um diretorio alvo e suas subpastas.
- zz/zz_dupfind -> documentacao/zz/zz_dupfind.md
  Documentacao automatica do script zz_dupfind, baseada em analise estatica do arquivo Bash.
- zz/zz_GDRIVE -> documentacao/zz/zz_GDRIVE.md
  Wrapper para sincronizacao rclone pre-configurada entre origens e destinos fixos.
- zz/zz_gitclone -> documentacao/zz/zz_gitclone.md
  Documentacao automatica do script zz_gitclone, baseada em analise estatica do arquivo Bash.
- zz/zz_gri2nas -> documentacao/zz/zz_gri2nas.md
  rclone sync 163-Grievous-L:Dados/ 167-NASareth-L:All/ --progress --retries 3 --low-level-retries 10 --transfers 20 --order-by size,asc --stats 1s --timeout 1h
- zz/zz_isync_gn -> documentacao/zz/zz_isync_gn.md
  Wrapper para sincronizacao rclone pre-configurada entre origens e destinos fixos.
- zz/zz_kamba -> documentacao/zz/zz_kamba.md
  KSMBD Auto Installer / Remover - Debian 13
- zz/zz_kill -> documentacao/zz/zz_kill.md
  Documentacao automatica do script zz_kill, baseada em analise estatica do arquivo Bash.
- zz/zz_mensal_grievous -> documentacao/zz/zz_mensal_grievous.md
  menores primeiro rclone sync CarboAlba-R:dr/bkp/ 163-Grievous-L:Dados/Trabalho/bkp --progress --retries 3 --low-level-retries 10 --transfers 20 --order-by size,asc --stats 1s --timeout 1h
- zz/zz_mensal_nasareth -> documentacao/zz/zz_mensal_nasareth.md
  menores primeiro rclone sync CarboAlba-R:dr/bkp/ 161-Tank-L:alba/bkp/ --progress --retries 3 --low-level-retries 10 --transfers 20 --order-by size,asc --stats 1s --timeout 1h
- zz/zz_mountSSH -> documentacao/zz/zz_mountSSH.md
  zz_mountSSH v1.0 Projeto zz_* - Montagem remota controlada via SSHFS FINALIDADE:
- zz/zz_new -> documentacao/zz/zz_new.md
  Wrapper para sincronizacao rclone pre-configurada entre origens e destinos fixos.
- zz/zz_ramdisk -> documentacao/zz/zz_ramdisk.md
  ZZ_RAMLOADER - Carrega scripts em RAM Disk (tmpfs)
- zz/zz_sbse -> documentacao/zz/zz_sbse.md
  find_sbse.sh - Lista ou deleta arquivos que começam com "sbse" (case-insensitive) ./find_sbse.sh [CAMINHO_DA_PASTA] -list ./find_sbse.sh [CAMINHO_DA_PASTA] -del
- zz/zz_size -> documentacao/zz/zz_size.md
  Documentacao automatica do script zz_size, baseada em analise estatica do arquivo Bash.
- zz/zz_sshfs -> documentacao/zz/zz_sshfs.md
  Monta ou desmonta diretorios remotos via SSHFS.
- zz/zz_start -> documentacao/zz/zz_start.md
  Caminhos e variáveis globais
- zz/zz_tam -> documentacao/zz/zz_tam.md
  SCRIPT: zz_sum_log_space.sh DESCRICAO: Processa arquivo de log contendo linhas no formato:
- zz/zz_tar -> documentacao/zz/zz_tar.md
  SCRIPT: zz_tar DATA: 2025-11 FINALIDADE:
- zz/zz_vel -> documentacao/zz/zz_vel.md
  Monitor de Rede simplificado Sem Unicode / Sem ANSI 100% compatível com qualquer terminal (cmd, powershell, ssh, web)
- zz/zz_web -> documentacao/zz/zz_web.md
  Gerencia o servico web Nginx e o arquivo .htpasswd.
- zz/zz_wire -> documentacao/zz/zz_wire.md
  Gerencia interfaces WireGuard e operacoes de peers.

### zz/ANALISAR
- zz/ANALISAR/zz_2wan.sh -> documentacao/zz/ANALISAR/zz_2wan.sh.md
  Script de Configuracao Dual WAN para Linux Este script configura duas interfaces de rede em modo failover ou balanceamento de carga, com suporte a DHCP.

### zz/bkp
- zz/bkp/zz_bkpcfg -> documentacao/zz/bkp/zz_bkpcfg.md
  SCRIPT DE BACKUP DE CONFIGURAÇÕES DE SISTEMA Nome.........: zz_bkpcfg Descrição....: Realiza o backup de diretórios importantes e da crontab
- zz/bkp/zz_bkpcfg.v0 -> documentacao/zz/bkp/zz_bkpcfg.v0.md
  SCRIPT DE BACKUP DE CONFIGURAÇÕES DE SISTEMA Nome.........: zz_bkpcfg Descrição....: Realiza o backup de diretórios importantes e da crontab
- zz/bkp/zz_compact -> documentacao/zz/bkp/zz_compact.md
  Documentacao automatica do script zz_compact, baseada em analise estatica do arquivo Bash.
- zz/bkp/zz_compactV2 -> documentacao/zz/bkp/zz_compactV2.md
  Documentacao automatica do script zz_compactV2, baseada em analise estatica do arquivo Bash.

### zz/bkp/zz_remote_bkp
- zz/bkp/zz_remote_bkp/zz_remote_bkp.sh -> documentacao/zz/bkp/zz_remote_bkp/zz_remote_bkp.sh.md
  Documentacao automatica do script zz_remote_bkp.sh, baseada em analise estatica do arquivo Bash.

### zz/deprecated
- zz/deprecated/ntools -> documentacao/zz/deprecated/ntools.md
  Documentacao automatica do script ntools, baseada em analise estatica do arquivo Bash.

### zz/deprecated/base
- zz/deprecated/base/zz_instala -> documentacao/zz/deprecated/base/zz_instala.md
  bash <(wget -qO- https://raw.githubusercontent.com/atedim/zz/main/zz_instala)

### zz/disktools
- zz/disktools/zz_discos -> documentacao/zz/disktools/zz_discos.md
  Verifica se o script esta sendo executado como root ou com sudo
- zz/disktools/zz_formata -> documentacao/zz/disktools/zz_formata.md
  Verifica se o parted esta instalado
- zz/disktools/zz_lvm -> documentacao/zz/disktools/zz_lvm.md
  Orquestra criacao de RAID, LVM, formatacao e montagem.
- zz/disktools/zz_monta -> documentacao/zz/disktools/zz_monta.md
  Documentacao automatica do script zz_monta, baseada em analise estatica do arquivo Bash.

### zz/down
- zz/down/zz_down -> documentacao/zz/down/zz_down.md
  zz_down - Gerenciador de instalação de scripts personalizados

### zz/file_folder
- zz/file_folder/zz_dif_tam -> documentacao/zz/file_folder/zz_dif_tam.md
  zz_dif_tam - Compara duas pastas em termos de tamanho total (bytes) e número de arquivos. zz_dif_tam [origem] [destino] [silent] origem - Caminho da pasta origem
- zz/file_folder/zz_perm -> documentacao/zz/file_folder/zz_perm.md
  Ajusta permissões e dono dos arquivos Antonio M. Tedim - 16/04/2025
- zz/file_folder/zz_removevazia -> documentacao/zz/file_folder/zz_removevazia.md
  Caminho base (pode ser ajustado ou passado como parâmetro futuramente)
- zz/file_folder/zz_temp -> documentacao/zz/file_folder/zz_temp.md
  Limpa Temps v0.01 - Apaga arquivos temporários antigos, pastas inuteis e afins ou apenas registra no log
- zz/file_folder/zz_trash -> documentacao/zz/file_folder/zz_trash.md
  Limpa Lixeira v0.03 - Antonio M. Tedim - 16/04/2025

### zz/ini
- zz/ini/zz_ini -> documentacao/zz/ini/zz_ini.md
  Script de Leitura de Arquivo INI - Bash Funcionalidades: Busca o valor de uma chave dentro de uma seção (família) de um arquivo .ini.

### zz/kill_switch
- zz/kill_switch/zz_crypt -> documentacao/zz/kill_switch/zz_crypt.md
  Utilitário de Criptografia e Descriptografia de Datas Funções: Criptografia leve: ROT13 + base64 + rev
- zz/kill_switch/zz_ks -> documentacao/zz/kill_switch/zz_ks.md
  Verificador de prazo criptografado via HTTP Este script realiza as seguintes funções: 1. Atualiza a data/hora do sistema via NTP (obrigatório).

### zz/mail
- zz/mail/zz_mail -> documentacao/zz/mail/zz_mail.md
  Envia e-mails com ou sem anexo pela linha de comando.

### zz/monitor
- zz/monitor/zz_mon -> documentacao/zz/monitor/zz_mon.md
  Documentacao automatica do script zz_mon, baseada em analise estatica do arquivo Bash.
- zz/monitor/zz_sys -> documentacao/zz/monitor/zz_sys.md
  Sistema de Monitoramento - Script Melhorado

### zz/network
- zz/network/zz_ddns -> documentacao/zz/network/zz_ddns.md
  Verificar se está sendo executado como root
- zz/network/zz_ip -> documentacao/zz/network/zz_ip.md
  zz_ip - Script para exibir informações de rede Opções: (nenhuma) Mostra HOSTNAME, IP LAN e IP WAN
- zz/network/zz_tcon -> documentacao/zz/network/zz_tcon.md
  Executa testes de conectividade por DNS e por IP.
- zz/network/zz_wanm -> documentacao/zz/network/zz_wanm.md
  Documentacao automatica do script zz_wanm, baseada em analise estatica do arquivo Bash.

### zz/prompt
- zz/prompt/zz_banner -> documentacao/zz/prompt/zz_banner.md
  Documentacao automatica do script zz_banner, baseada em analise estatica do arquivo Bash.
- zz/prompt/zz_prompt -> documentacao/zz/prompt/zz_prompt.md
  Define o arquivo de configuracao e a customizacao desejada do prompt

### zz/proxmox_calc
- zz/proxmox_calc/zz_restore_calc -> documentacao/zz/proxmox_calc/zz_restore_calc.md
  Documentacao automatica do script zz_restore_calc, baseada em analise estatica do arquivo Bash.

### zz/sync
- zz/sync/syncALL -> documentacao/zz/sync/syncALL.md
  Wrapper para executar uma ou mais sincronizacoes zz_sync com pares ja definidos.
- zz/sync/zz_1to2 -> documentacao/zz/sync/zz_1to2.md
  1to2_sync 09:46 19/12/2023 ver 0.01
- zz/sync/zz_dtm -> documentacao/zz/sync/zz_dtm.md
  zz_dtm Script para sincronizar backups do DTM usando o RCLONE ver 0.01 12/11/2024
- zz/sync/zz_status -> documentacao/zz/sync/zz_status.md
  Acompanha continuamente um arquivo de log especifico.
- zz/sync/zz_sync -> documentacao/zz/sync/zz_sync.md
  zz_sync improved 22/10/2024 Sincronizacao de 2 pontos com protecao contra ransomware

