$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$docsRoot = Join-Path $root 'documentacao'
$depsFile = Join-Path $root 'dependências.txt'

function NormalizeText([string]$Text) {
    if ([string]::IsNullOrWhiteSpace($Text)) { return '' }
    return (($Text -replace "`r", '') -replace '\s+', ' ').Trim()
}

function GetCategory([string]$RelativePath) {
    $dir = Split-Path $RelativePath -Parent
    if ([string]::IsNullOrWhiteSpace($dir)) { return 'zz/raiz' }
    return ($dir -replace '\\', '/')
}

function GetSummary([string]$RelativePath, [string]$Content, [string[]]$Lines) {
    $comments = New-Object System.Collections.Generic.List[string]
    $started = $false
    foreach ($line in $Lines) {
        $trim = $line.Trim()
        if (-not $started) {
            if ($trim -match '^(#!|o#!/)') { continue }
            if (-not $trim) { continue }
            if ($trim.StartsWith('#')) { $started = $true } else { break }
        }
        if ($started) {
            if (-not $trim.StartsWith('#')) { break }
            $clean = $trim -replace '^#+', ''
            $clean = $clean.Trim(' ', '-', '=', '*')
            if (-not $clean) { continue }
            if ($clean -match '^(Uso|USO|Exemplo|EXEMPLO|Parametros|Parâmetros|Autor|Vers|Configur|Vari[aá]veis|Labels|Defina)') { continue }
            $comments.Add($clean)
            if ($comments.Count -ge 3) { break }
        }
    }
    $summary = NormalizeText(($comments -join ' '))
    if ($summary -and $summary.Length -ge 20) { return $summary }

    if ($Content -match 'rclone\s+sync') { return 'Wrapper para sincronizacao rclone pre-configurada entre origens e destinos fixos.' }
    if ($Content -match 'zz_sync' -and $Content -notmatch 'mount\.cifs') { return 'Wrapper para executar uma ou mais sincronizacoes zz_sync com pares ja definidos.' }
    if ($Content -match 'tail -f') { return 'Acompanha continuamente um arquivo de log especifico.' }
    if ($Content -match 'wg show interfaces|wg-quick@') { return 'Gerencia interfaces WireGuard e operacoes de peers.' }
    if ($Content -match 'htpasswd' -and $Content -match 'nginx') { return 'Gerencia o servico web Nginx e o arquivo .htpasswd.' }
    if ($Content -match 'ksmbd') { return 'Instala, configura ou remove o servico KSMBD.' }
    if ($Content -match 'sshfs' -and $Content -match 'mountpoint') { return 'Monta ou desmonta diretorios remotos via SSHFS.' }
    if ($Content -match 'msmtp' -and $Content -match 'mime-construct') { return 'Envia e-mails com ou sem anexo pela linha de comando.' }
    if ($Content -match 'parted' -and $Content -match 'mkfs\.ext4') { return 'Executa preparacao de discos com particionamento e formatacao.' }
    if ($Content -match 'mdadm' -and $Content -match 'lvcreate') { return 'Orquestra criacao de RAID, LVM, formatacao e montagem.' }
    if ($Content -match 'rsync' -and $Content -match 'mount\.cifs') { return 'Monta compartilhamentos CIFS e sincroniza dados com rsync.' }
    if ($Content -match 'ping' -and $Content -match 'dig') { return 'Executa testes de conectividade por DNS e por IP.' }
    if ($Content -match 'openssl' -and $Content -match 'pbkdf2') { return 'Executa criptografia, descriptografia ou validacao temporal com openssl.' }
    if ($Content -match 'apt(-get)?\s+install') { return 'Automatiza preparacao do ambiente e instalacao de pacotes/scripts auxiliares.' }
    return ('Documentacao automatica do script ' + (Split-Path $RelativePath -Leaf) + ', baseada em analise estatica do arquivo Bash.')
}

function GetUsage([string]$Content, [string[]]$Lines) {
    $items = New-Object System.Collections.Generic.List[string]
    $capture = 0
    foreach ($line in $Lines) {
        $trim = $line.Trim()
        if ($trim -match '^(#\s*)?(Uso|USO|Modo de uso|Exemplos?|EXEMPLOS?)[:]?') {
            $items.Add(($trim -replace '^(#\s*)?', '').Trim())
            $capture = 3
            continue
        }
        if ($capture -gt 0 -and $trim.StartsWith('#')) {
            $clean = ($trim -replace '^(#\s*)?', '').Trim()
            if ($clean) { $items.Add($clean) }
            $capture--
            continue
        }
    }
    foreach ($m in [regex]::Matches($Content, '(?m)^\s+(-{1,2}[A-Za-z0-9][^\)\r\n]*)\)')) {
        foreach ($part in ($m.Groups[1].Value -split '\|')) {
            $flag = NormalizeText($part)
            if ($flag) { $items.Add("Flag detectada: $flag") }
        }
    }
    foreach ($m in [regex]::Matches($Content, '(?m)\$1"\s*(==|=)\s*"(-{1,2}[A-Za-z0-9][^"]*)"')) {
        $items.Add("Flag detectada: $($m.Groups[2].Value)")
    }
    $out = $items | ForEach-Object { NormalizeText($_) } | Where-Object { $_ } | Select-Object -Unique
    return ,$out
}

function GetRelated([string]$Content) {
    $patterns = @(
        '/etc/[A-Za-z0-9_./-]+',
        '/var/log/[A-Za-z0-9_./-]+',
        '/mnt/[A-Za-z0-9_./-]+',
        '/work/[A-Za-z0-9_./-]+',
        '/dr/[A-Za-z0-9_./-]+',
        '\$HOME/[A-Za-z0-9_./-]+',
        '~\/\.[A-Za-z0-9_./-]+',
        '[A-Za-z0-9_.-]+\.(conf|ini|txt|lst|log)'
    )
    $items = New-Object System.Collections.Generic.List[string]
    foreach ($pattern in $patterns) {
        foreach ($match in [regex]::Matches($Content, $pattern)) {
            $items.Add($match.Value.Trim('"', "'", ' '))
        }
    }
    return ,($items | Where-Object { $_ } | Select-Object -Unique)
}

function GetFlow([string]$Category, [string]$Content) {
    $flow = New-Object System.Collections.Generic.List[string]
    if ($Content -match 'EUID|id -u') { $flow.Add('Valida privilegios de execucao antes de seguir.') }
    if ($Content -match 'command -v|which ') { $flow.Add('Confere dependencias externas e aborta cedo se algo obrigatorio estiver ausente.') }
    if ($Content -match '\bread\b|whiptail') { $flow.Add('Solicita entradas do operador para definir parametros ou confirmar a operacao.') }
    if ($Content -match 'mkdir -p') { $flow.Add('Prepara diretorios de trabalho, logs ou pontos de montagem.') }
    switch ($Category) {
        'zz/network' { $flow.Add('Executa consultas, testes ou alteracoes de rede e registra o resultado.'); break }
        'zz/monitor' { $flow.Add('Coleta indicadores, escreve relatorio ou acompanha mudanca de estado.'); break }
        'zz/file_folder' { $flow.Add('Percorre o sistema de arquivos para listar, medir, ajustar atributos ou remover itens.'); break }
        'zz/disktools' { $flow.Add('Opera discos/volumes diretamente e pode alterar particionamento, fstab, RAID ou montagens.'); break }
        'zz/bkp' { $flow.Add('Gera backup, compacta dados ou aplica retencao sobre artefatos antigos.'); break }
        'zz/sync' { $flow.Add('Carrega origem/destino e executa sincronizacao com rsync ou rclone.'); break }
        default { $flow.Add('Executa a rotina principal definida no proprio arquivo e mostra o resultado em tela.'); break }
    }
    return ,($flow | Select-Object -Unique)
}

function GetNotes([string]$Content) {
    $notes = New-Object System.Collections.Generic.List[string]
    if ($Content -match 'rm -rf|wipefs|mkfs\.|dd if=/dev/urandom|kill -9') { $notes.Add('Possui operacoes potencialmente destrutivas; revisar caminhos, discos e parametros antes de executar.') }
    if ($Content -match '(?im)(token|senha|password|pass)\s*=\s*["''][^"'']+["'']') { $notes.Add('O arquivo contem valores sensiveis hardcoded; revise credenciais, tokens e senhas antes de usar em producao.') }
    if ($Content -match 'o#!/bin/bash') { $notes.Add('O shebang da primeira linha esta malformado (`o#!/bin/bash`).') }
    if ($Content -match '/etc/scripts|/work/|/dr/|/dados') { $notes.Add('Assume uma estrutura de caminhos fixa no host e pode exigir ajuste manual em outro ambiente.') }
    return ,($notes | Select-Object -Unique)
}
$depCatalog = @(
    @{ Name = 'bash'; Package = 'bash'; Note = 'Interpretador principal dos scripts.'; Patterns = @('(?m)^#!/bin/bash', '(?m)^o#!/bin/bash') },
    @{ Name = 'coreutils/findutils/grep/sed/awk/tar'; Package = 'coreutils, findutils, grep, sed, gawk, tar'; Note = 'Conjunto basico de utilitarios GNU usado no acervo.'; Patterns = @('\bfind\b', '\bawk\b', '\bsed\b', '\bgrep\b', '\btar\b', '\bstat\b', '\bcut\b') },
    @{ Name = 'curl'; Package = 'curl'; Note = 'Downloads HTTP/HTTPS, descoberta de IP publico e chamadas a APIs.'; Patterns = @('\bcurl\b') },
    @{ Name = 'wget'; Package = 'wget'; Note = 'Fallback de download e consultas simples via HTTP/HTTPS.'; Patterns = @('\bwget\b') },
    @{ Name = 'ntpdate'; Package = 'ntpdate'; Note = 'Sincronizacao de horario antes de rotinas sensiveis a data/hora.'; Patterns = @('\bntpdate\b') },
    @{ Name = 'openssl'; Package = 'openssl'; Note = 'Criptografia e descriptografia de conteudo.'; Patterns = @('\bopenssl\b') },
    @{ Name = 'rclone'; Package = 'rclone'; Note = 'Sincronizacao com remotos locais e nuvem.'; Patterns = @('\brclone\b') },
    @{ Name = 'rsync'; Package = 'rsync'; Note = 'Sincronizacao local ou entre mounts CIFS.'; Patterns = @('\brsync\b') },
    @{ Name = 'git'; Package = 'git'; Note = 'Clone e espelhamento de repositorios.'; Patterns = @('\bgit\b') },
    @{ Name = 'openssh-client/scp'; Package = 'openssh-client'; Note = 'Conexao SSH e transferencia SCP.'; Patterns = @('\bssh\b', '\bscp\b') },
    @{ Name = 'sshpass'; Package = 'sshpass'; Note = 'Automacao de autenticacao em SSH, SSHFS e SCP.'; Patterns = @('\bsshpass\b') },
    @{ Name = 'sshfs'; Package = 'sshfs'; Note = 'Montagem de diretorios remotos via FUSE.'; Patterns = @('\bsshfs\b') },
    @{ Name = 'cifs-utils'; Package = 'cifs-utils'; Note = 'Montagem de compartilhamentos SMB/CIFS.'; Patterns = @('mount\.cifs') },
    @{ Name = 'wireguard-tools'; Package = 'wireguard-tools'; Note = 'Comandos wg e operacao de interfaces wg-quick.'; Patterns = @('\bwg\b', 'wg-quick@') },
    @{ Name = 'iproute2'; Package = 'iproute2'; Note = 'Consulta e configuracao de interfaces, rotas e regras.'; Patterns = @('\bip\b', 'rt_tables') },
    @{ Name = 'net-tools'; Package = 'net-tools'; Note = 'Fallback legado via ifconfig e route.'; Patterns = @('\bifconfig\b', '\broute -n\b') },
    @{ Name = 'dnsutils'; Package = 'dnsutils'; Note = 'Resolucao DNS via dig.'; Patterns = @('\bdig\b') },
    @{ Name = 'ping'; Package = 'iputils-ping ou inetutils-ping'; Note = 'Teste de conectividade.'; Patterns = @('\bping\b') },
    @{ Name = 'ethtool'; Package = 'ethtool'; Note = 'Consulta de velocidade e duplex de interfaces.'; Patterns = @('\bethtool\b') },
    @{ Name = 'ipcalc'; Package = 'ipcalc'; Note = 'Calculo de rede CIDR em configuracao dual WAN.'; Patterns = @('\bipcalc\b') },
    @{ Name = 'parted'; Package = 'parted'; Note = 'Particionamento de discos.'; Patterns = @('\bparted\b') },
    @{ Name = 'e2fsprogs/util-linux'; Package = 'e2fsprogs, util-linux'; Note = 'Ferramentas como mkfs.ext4, e2label, blkid, wipefs, lsblk, mount e umount.'; Patterns = @('\bmkfs\.ext4\b', '\be2label\b', '\bblkid\b', '\bwipefs\b', '\blsblk\b', '\bmount\b', '\bumount\b') },
    @{ Name = 'mdadm'; Package = 'mdadm'; Note = 'Criacao e gerenciamento de arrays RAID.'; Patterns = @('\bmdadm\b') },
    @{ Name = 'lvm2'; Package = 'lvm2'; Note = 'Criacao de PV, VG e LV.'; Patterns = @('\bpvcreate\b', '\bvgcreate\b', '\blvcreate\b') },
    @{ Name = 'whiptail'; Package = 'whiptail'; Note = 'Menus interativos em modo texto.'; Patterns = @('\bwhiptail\b') },
    @{ Name = 'dos2unix'; Package = 'dos2unix'; Note = 'Normalizacao de finais de linha apos download.'; Patterns = @('\bdos2unix\b') },
    @{ Name = 'msmtp'; Package = 'msmtp, msmtp-mta'; Note = 'Envio de e-mail via SMTP.'; Patterns = @('\bmsmtp\b') },
    @{ Name = 'mime-construct'; Package = 'mime-construct'; Note = 'Montagem de mensagem MIME e anexos.'; Patterns = @('\bmime-construct\b') },
    @{ Name = 'nginx'; Package = 'nginx'; Note = 'Servico web controlado por zz_web.'; Patterns = @('\bnginx\b') },
    @{ Name = 'apache2-utils'; Package = 'apache2-utils'; Note = 'Fornece o comando htpasswd.'; Patterns = @('\bhtpasswd\b') },
    @{ Name = 'ksmbd-tools'; Package = 'ksmbd-tools'; Note = 'Instalacao e manutencao do servico KSMBD.'; Patterns = @('\bksmbd\b') },
    @{ Name = 'samba'; Package = 'samba'; Note = 'Arquivos de configuracao SMB e cenarios de compartilhamento local.'; Patterns = @('/etc/samba', 'smb\.conf', '\bsmbd\b') },
    @{ Name = 'mergerfs'; Package = 'mergerfs'; Note = 'Uniao de varios discos em um destino logico.'; Patterns = @('\bmergerfs\b') },
    @{ Name = 'bc'; Package = 'bc'; Note = 'Calculos com ponto flutuante.'; Patterns = @('\bbc\b') },
    @{ Name = 'fd-find'; Package = 'fd-find'; Note = 'Comando fdfind usado para inventario rapido de arquivos.'; Patterns = @('\bfdfind\b') },
    @{ Name = 'zstd'; Package = 'zstd'; Note = 'Compressao para backups remotos.'; Patterns = @('\bzstd\b') },
    @{ Name = 'xz-utils'; Package = 'xz-utils'; Note = 'Compressao xz.'; Patterns = @('\bxz\b') },
    @{ Name = 'gzip'; Package = 'gzip'; Note = 'Compressao gzip.'; Patterns = @('\bgzip\b') },
    @{ Name = 'systemd'; Package = 'systemd'; Note = 'Controle de servicos e unidades do sistema.'; Patterns = @('\bsystemctl\b', '\.service') }
)

function FindDeps([string]$Content) {
    $found = New-Object System.Collections.Generic.List[object]
    foreach ($dep in $depCatalog) {
        foreach ($pattern in $dep.Patterns) {
            if ($Content -match $pattern) { $found.Add($dep); break }
        }
    }
    return ,$found
}

if (Test-Path $docsRoot) {
    Get-ChildItem -LiteralPath $docsRoot -Force | Where-Object { $_.Name -ne '_gerar_documentacao.ps1' } | Remove-Item -Recurse -Force
}

$paths = & rg -l "^#!.*(bash|sh)" zz
if (Test-Path (Join-Path $root 'zz\zz_mountSSH')) { $paths += 'zz\zz_mountSSH' }
$paths = $paths | Sort-Object -Unique
$index = New-Object System.Collections.Generic.List[object]
$depUsage = @{}

foreach ($rel in $paths) {
    $full = Join-Path $root $rel
    $content = Get-Content -LiteralPath $full -Raw
    $lines = Get-Content -LiteralPath $full
    $category = GetCategory $rel
    $summary = GetSummary $rel $content $lines
    $usage = GetUsage $content $lines
    $related = GetRelated $content
    $flow = GetFlow $category $content
    $notes = GetNotes $content
    $deps = FindDeps $content
    foreach ($dep in $deps) {
        if (-not $depUsage.ContainsKey($dep.Name)) { $depUsage[$dep.Name] = New-Object System.Collections.Generic.List[string] }
        $depUsage[$dep.Name].Add($rel)
    }
    $docPath = Join-Path $docsRoot ($rel + '.md')
    New-Item -ItemType Directory -Force -Path (Split-Path $docPath -Parent) | Out-Null
    $requiresRoot = if ($content -match 'EUID|id -u') { 'sim' } else { 'nao detectado explicitamente' }
    $interactive = if ($content -match '\bread\b|whiptail') { 'sim' } else { 'nao' }
    $md = New-Object System.Collections.Generic.List[string]
    $md.Add("# $(Split-Path $rel -Leaf)")
    $md.Add('')
    $md.Add('## Resumo')
    $md.Add($summary)
    $md.Add('')
    $md.Add('## Execucao e parametros')
    $md.Add("- Local original: " + ($rel -replace '\\','/'))
    $md.Add("- Categoria: " + $category)
    $md.Add("- Exige root: $requiresRoot")
    $md.Add("- Interativo: $interactive")
    if ($usage.Count -gt 0) { foreach ($u in ($usage | Select-Object -First 8)) { $md.Add("- $u") } } else { $md.Add('- Nao foi encontrada ajuda embutida clara; revisar variaveis internas e chamadas diretas no arquivo.') }
    $md.Add('')
    $md.Add('## Requisitos')
    if ($deps.Count -gt 0) { foreach ($dep in $deps) { $md.Add("- " + $dep.Name + " (" + $dep.Package + ") - " + $dep.Note) } } else { $md.Add('- Apenas o ambiente Bash basico foi identificado na analise estatica.') }
    $md.Add('')
    $md.Add('## Arquivos e caminhos usados')
    if ($related.Count -gt 0) { foreach ($r in ($related | Select-Object -First 12)) { $md.Add("- " + $r) } } else { $md.Add('- O script nao referencia arquivos auxiliares de forma evidente na analise estatica.') }
    $md.Add('')
    $md.Add('## Funcionamento')
    foreach ($f in $flow) { $md.Add("- $f") }
    $md.Add('')
    $md.Add('## Observacoes')
    if ($notes.Count -gt 0) { foreach ($n in $notes) { $md.Add("- $n") } } else { $md.Add('- Nao foram detectados alertas adicionais alem dos requisitos normais de execucao.') }
    Set-Content -LiteralPath $docPath -Value $md -Encoding UTF8
    $index.Add([PSCustomObject]@{ Rel = $rel; Category = $category; Doc = ($docPath.Substring($root.Length + 1) -replace '\\','/'); Summary = $summary })
}
$readme = New-Object System.Collections.Generic.List[string]
$readme.Add('# Documentacao dos scripts `zz_*`')
$readme.Add('')
$readme.Add("Inventario gerado em $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss'). Foram encontrados **$($index.Count)** scripts Bash dentro de `zz/`.")
$readme.Add('')
$readme.Add('## Premissas gerais')
$readme.Add('- O acervo foi pensado principalmente para Linux, com inclinacao a Debian/Ubuntu, `systemd` e uso frequente de root/sudo.')
$readme.Add('- Muitos scripts assumem a existencia de caminhos fixos como `/etc/scripts`, `/dados`, `/work`, `/dr` e pontos em `/mnt`.')
$readme.Add('- Varios arquivos guardam credenciais ou tokens diretamente no corpo do script ou em `.conf`; revise isso antes de usar em producao.')
$readme.Add('- O arquivo `dependências.txt` na raiz consolida programas, pacotes e servicos externos requeridos pelo conjunto todo.')
$readme.Add('')
$readme.Add('## Scripts documentados')
foreach ($group in ($index | Group-Object Category | Sort-Object Name)) {
    $readme.Add("### $($group.Name)")
    foreach ($item in ($group.Group | Sort-Object Rel)) {
        $readme.Add("- " + ($item.Rel -replace '\\','/') + " -> " + $item.Doc)
        $readme.Add("  " + $item.Summary)
    }
    $readme.Add('')
}
Set-Content -LiteralPath (Join-Path $docsRoot 'README.md') -Value $readme -Encoding UTF8

$depsOut = New-Object System.Collections.Generic.List[string]
$depsOut.Add('DEPENDENCIAS IDENTIFICADAS PARA EXECUTAR O CONJUNTO DE SCRIPTS')
$depsOut.Add('')
$depsOut.Add("Data da varredura: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')")
$depsOut.Add("Total de scripts considerados: $($index.Count)")
$depsOut.Add('')
$depsOut.Add('AMBIENTE BASE')
$depsOut.Add('- Linux com Bash e systemd.')
$depsOut.Add('- Acesso de root/sudo para tarefas de instalacao, discos, rede, montagem e backup.')
$depsOut.Add('- Rede com DNS e acesso HTTP/HTTPS para downloads, descoberta de IP publico e APIs externas.')
$depsOut.Add('')
$depsOut.Add('PACOTES E FERRAMENTAS')
foreach ($dep in ($depCatalog | Sort-Object Name)) {
    if ($depUsage.ContainsKey($dep.Name)) {
        $scripts = ($depUsage[$dep.Name] | Sort-Object -Unique | ForEach-Object { $_ -replace '\\','/' }) -join ', '
        $depsOut.Add("- $($dep.Name)")
        $depsOut.Add("  Pacote sugerido: $($dep.Package)")
        $depsOut.Add("  Motivo: $($dep.Note)")
        $depsOut.Add("  Scripts: $scripts")
    }
}
$depsOut.Add('')
$depsOut.Add('SERVICOS E INFRAESTRUTURA EXTERNA')
$depsOut.Add('- `pool.ntp.org`: usado por varios scripts para sincronizacao de horario via `ntpdate`.')
$depsOut.Add('- GitHub Raw: necessario para `zz_start`, `zz_down`, `zz_instala` e rotinas que baixam scripts ou INIs.')
$depsOut.Add('- Remotos `rclone` previamente configurados em `rclone.conf`: exigidos por wrappers de backup/sincronizacao com rclone.')
$depsOut.Add('- Servidores SSH acessiveis: exigidos por `zz_sshfs`, `zz_mountSSH` e `zz_remote_bkp.sh`.')
$depsOut.Add('- Compartilhamentos SMB/CIFS acessiveis: exigidos por `zz_sync`, `syncALL`, `isync` e wrappers relacionados.')
$depsOut.Add('- SMTP configurado no `msmtp`: necessario para `zz_mail`, `zz_mon`, `zz_wanm` e `zz_bkpcfg` quando o envio esta habilitado.')
$depsOut.Add('- DuckDNS: necessario para `zz_ddns` e `zz_wanm`.')
$depsOut.Add('- WireGuard (`wg-quick`/`wg`): necessario para `zz_wire`.')
$depsOut.Add('')
$depsOut.Add('PACOTE BASE INSTALADO PELOS INSTALADORES')
$depsOut.Add('- `zz_start` e `deprecated/base/zz_instala` tambem instalam um bundle operacional com `bmon`, `htop`, `mc`, `rcconf`, `iptraf-ng`, `gdu`, `etherwake`, `screen`, `samba`, `mergerfs`, `rclone`, `rsync`, `sshpass`, `dos2unix`, `msmtp`, `mime-construct`, `ntpdate`, `curl`, `bc`, `cifs-utils`, `parted`, `mdadm` e correlatos.')
Set-Content -LiteralPath $depsFile -Value $depsOut -Encoding UTF8
