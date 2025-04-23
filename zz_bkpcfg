#!/bin/bash

#script para salvar configurações de servidores
#criado em 26/01/2024 por Antonio Tedim

# Obtém a data no formato DDMMAAAA
data=$(date +"%d%m%Y")

# Define o nome do arquivo com base na data
arquivo="configs_${data}_etc.tgz"

# Diretório de destino
diretorio_destino="/dados/configs"

# Diretórios a serem incluídos no arquivo
diretorios="/etc/scripts /etc/ssh /etc/samba"

# Executa o comando crontab -l e salva em um arquivo
crontab -l > "/etc/scripts/cron.txt"

# Cria o arquivo tar.gz
tar zcvfp "${diretorio_destino}/${arquivo}" $diretorios

# Exibe uma mensagem indicando que o processo foi concluído
echo "Backup diário e crontab concluídos em $(date +"%Y-%m-%d %H:%M:%S")"
