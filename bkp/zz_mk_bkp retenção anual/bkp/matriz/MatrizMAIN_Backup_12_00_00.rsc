# 2026-04-26 12:00:00 by RouterOS 7.21.1
# software id = ZWS1-DBFJ
#
# model = RB5009UG+S+
# serial number = EC190F3DAF52
/interface bridge add admin-mac=DC:2C:6E:45:C2:31 auto-mac=no comment=defconf name=bridge port-cost-mode=short
/interface ethernet set [ find default-name=ether1 ] comment="ALGAR 1G" l2mtu=1514 name=ether1-LINK-SEC
/interface ethernet set [ find default-name=ether2 ] comment=LAN l2mtu=1514
/interface ethernet set [ find default-name=ether3 ] l2mtu=1514
/interface ethernet set [ find default-name=ether4 ] l2mtu=1514
/interface ethernet set [ find default-name=ether5 ] l2mtu=1514
/interface ethernet set [ find default-name=ether6 ] l2mtu=1514
/interface ethernet set [ find default-name=ether7 ] l2mtu=1514
/interface ethernet set [ find default-name=ether8 ] l2mtu=1514
/interface ethernet set [ find default-name=sfp-sfpplus1 ] comment="ALGAR 2G" l2mtu=1514 name=sfp--LINK-PRI
/interface wireguard add comment=back-to-home-vpn listen-port=53452 mtu=1420 name=back-to-home-vpn private-key="aGLyugKUqSDSZ8mlEh+hCEGWdzGeKbY5CC8/mqTr8nU="
/interface list add comment=defconf name=WAN
/interface list add comment=defconf name=LAN
/ip dhcp-server option add code=242 name=option-242 value="'MCIPADD=192.168.0.10,MCPORT=1719,HTTPSRVR=192.168.0.10, VLANTEST=0'"
/ip dhcp-server option add code=6 name=DNS_Google value="'8.8.8.8''8.8.4.4'"
/ip dhcp-server option add code=6 name=Quad9 value="'9.9.9.9''149.112.112.112'"
/ip dhcp-server option add code=6 name=CloudFlare value="'1.1.1.1''1.0.0.1'"
/ip ipsec profile set [ find default=yes ] dpd-interval=2m dpd-maximum-failures=5
/ip ipsec profile add dh-group=modp1024 dpd-interval=2m dpd-maximum-failures=5 enc-algorithm=3des name=phase2
/ip ipsec profile add dh-group=ecp521 dpd-interval=2m dpd-maximum-failures=5 enc-algorithm=aes-256 hash-algorithm=sha256 name=phase21
/ip ipsec peer add address=179.190.40.61/32 comment="Novo DC Prim\E1rio" disabled=yes exchange-mode=ike2 local-address=200.170.180.100 name=CeC1 profile=phase2
/ip ipsec peer add address=177.185.15.202/32 comment="Novo DC Secund\E1rio" disabled=yes exchange-mode=ike2 local-address=189.20.65.194 name=CeC2 profile=phase2
/ip ipsec peer add address=8.242.74.202/32 comment="Novo DC (Implantado em 27122025)" exchange-mode=ike2 local-address=200.170.180.100 name=NovoDC profile=phase21
/ip ipsec proposal add disabled=yes enc-algorithms=3des lifetime=1d name=phase1
/ip ipsec proposal add auth-algorithms=sha256 enc-algorithms=aes-256-cbc,aes-256-ctr,aes-256-gcm lifetime=1d name=phase12 pfs-group=ecp521
/ip pool add name=dhcp ranges=192.168.1.65-192.168.1.126
/ip dhcp-server add address-pool=dhcp interface=bridge lease-time=10m name=dhcp1
/interface sstp-client add authentication=chap,mschap1,mschap2 connect-to=hydravpn.tialbatroz.com.br disabled=no name=HydraVPN password=4lb4tr0z port=1443 profile=default-encryption user=matriz-105
/queue simple add max-limit=3G/3G name=TI target=192.168.10.16/32
/queue simple add disabled=yes max-limit=10M/10M name=rede_toda target=192.168.6.0/24
/queue simple add disabled=yes max-limit=10M/10M name=rede_dir target=192.168.10.0/24
/queue simple add comment="Queue de DHCP com 3k U/D - Flow PODTEST" max-limit=3k/3k name="IGOR 3k" target=192.168.1.64/26
/queue simple add comment=Postes max-limit=1M/1M name=Postes target=192.168.3.224/27
/queue simple add comment="Postes UPLOAD" dst=82.25.74.101/32 max-limit=5M/5M name="Postes UPLOAD" target=192.168.3.0/24
/queue simple add max-limit=64k/64k name=FemtoCell target=192.168.3.70/32
/queue simple add comment="Wifi Diretoria" max-limit=150M/150M name="Wifi Diretoria" target=192.168.5.8/29
/queue simple add comment="Wifi Geral" max-limit=150M/150M name="Wifi Geral" target=192.168.5.0/29
/queue simple add comment="Biovida e Datamace" max-limit=10M/10M name=Prestadores target=192.168.9.0/24
/queue simple add comment="Test William" disabled=yes max-limit=32k/32k name="William Jur noturno" target=192.168.6.103/32 time=19h-5h,sun,mon,tue,wed,thu,fri,sat
/queue simple add comment="Queue prara monitorar velocidade de um individuo, colocar o ip a ser monitorado" disabled=yes max-limit=1G/1G name="monitorar velocidade" target=192.168.6.102/32
/queue simple add comment="Infra da Eletronica" max-limit=400M/800M name=Eletronica queue=hotspot-default/hotspot-default target=192.168.3.0/24 total-queue=hotspot-default
/system logging action set 0 memory-lines=9000
/system logging action set 1 disk-lines-per-file=10000
/zerotier set zt1 identity=7d6aeb5515:0:84ac58ae3128e44fa13589ac3f4d530573c2553acbfea55a5585e48d26898b555f5d2325b5c7997dab111839ae39a21e7593e310d73c3c71c5a188bbd1033d14:92fa544a9d4dc1f9f54bb123b6e7533a1c7ce0a1bb8c2f60f20fa12f176c6dd7a5fd63c68cf6a15362e669eb0f637b8fb09735a2f2c877846b234d38c50044ab
/interface bridge filter add action=drop chain=forward comment="Bloqueio de MAC na OSI 2" disabled=yes log=yes log-prefix="Bloq OSI 2" src-mac-address=10:FF:E0:68:DA:C4/FF:FF:FF:FF:FF:FF
/interface bridge filter add action=drop chain=input comment="Bloqueio de MAC na OSI 2" disabled=yes log=yes log-prefix="Bloq OSI 2" src-mac-address=10:FF:E0:68:DA:C4/FF:FF:FF:FF:FF:FF
/interface bridge filter add action=drop chain=output comment="Bloqueio de MAC na OSI 2" disabled=yes dst-mac-address=10:FF:E0:68:DA:C4/FF:FF:FF:FF:FF:FF log=yes log-prefix="Bloq OSI 2"
/interface bridge port add bridge=bridge comment=defconf interface=ether2 internal-path-cost=10 path-cost=10
/interface bridge port add bridge=bridge comment=defconf interface=ether3 internal-path-cost=10 path-cost=10
/interface bridge port add bridge=bridge comment=defconf interface=ether4 internal-path-cost=10 path-cost=10
/interface bridge port add bridge=bridge comment=defconf interface=ether5 internal-path-cost=10 path-cost=10
/interface bridge port add bridge=bridge comment=defconf interface=ether6 internal-path-cost=10 path-cost=10
/interface bridge port add bridge=bridge comment=defconf interface=ether7 internal-path-cost=10 path-cost=10
/interface bridge port add bridge=bridge comment=defconf interface=ether8 internal-path-cost=10 path-cost=10
/interface bridge port add bridge=bridge disabled=yes interface=ether1-LINK-SEC
/interface bridge port add bridge=bridge comment=defconf disabled=yes interface=sfp--LINK-PRI internal-path-cost=10 path-cost=10
/ip firewall connection tracking set generic-timeout=1m tcp-established-timeout=1m udp-timeout=10s
/ip neighbor discovery-settings set discover-interface-list=!dynamic
/ipv6 settings set accept-redirects=no accept-router-advertisements=no disable-ipv6=yes forward=no
/interface detect-internet set detect-interface-list=all
/interface l2tp-server server set enabled=yes ipsec-secret=grup04lb4tr0z use-ipsec=required
/interface list member add comment=defconf interface=bridge list=LAN
/interface list member add interface=sfp--LINK-PRI list=WAN
/interface list member add comment="alterado em 1303" interface=ether1-LINK-SEC list=WAN
/interface ovpn-server server add mac-address=FE:E3:C1:96:1F:DB name=ovpn-server1
/ip address add address=192.168.1.1/20 comment=defconf interface=bridge network=192.168.0.0
/ip address add address=200.170.180.100/29 comment="ALGAR 2G" interface=sfp--LINK-PRI network=200.170.180.96
/ip address add address=189.112.167.45/30 comment="ALGAR 1G" interface=ether1-LINK-SEC network=189.112.167.44
/ip cloud set back-to-home-vpn=enabled ddns-enabled=yes ddns-update-interval=1m
/ip dhcp-client add comment=defconf disabled=yes interface=sfp--LINK-PRI
/ip dhcp-server alert add disabled=no interface=bridge on-alert="\"/log info \\\"Servidor DHCP INVASOR detectado\\\"\"" valid-server=DC:2C:6E:45:C2:31
/ip dhcp-server lease add address=192.168.5.3 client-id=1:10:be:f5:d1:e8:3 comment="(Juridico) SSID: WifiAlb3\r\
    \nSenha: @lbatr0z12345\r\
    \n\r\
    \nuser: admin\r\
    \nsenha:4lb4tr0z\r\
    \n\r\
    \nIPWAN: 192.168.5.3\r\
    \nIPLAN: 192.168.150.1\r\
    \nDHCP: 150.100 - 150.120\r\
    \n\r\
    \nAcesso remoto na porta 8080" mac-address=10:BE:F5:D1:E8:03 server=dhcp1
/ip dhcp-server lease add address=192.168.5.1 client-id=1:0:26:5a:fe:e4:57 comment="(Operacional) SSID: WifiAlb7\r\
    \nSenha: @lbatr0z12345\r\
    \n\r\
    \nuser: admin\r\
    \nsenha:4lb4tr0z\r\
    \n\r\
    \nIPWAN: 192.168.5.7\r\
    \nIPLAN: 192.168.150.1\r\
    \nDHCP: 150.10 - 150.70\r\
    \n\r\
    \nAcesso remoto na porta 8080" mac-address=00:26:5A:FE:E4:57 server=dhcp1
/ip dhcp-server lease add address=192.168.5.2 client-id=1:d4:6e:e:3d:61:85 comment="(Plantao) SSID: WifiAlb8\r\
    \nSenha: @lbatr0z12345\r\
    \n\r\
    \nuser: admin\r\
    \nsenha:4lb4tr0z\r\
    \n\r\
    \nIPWAN: 192.168.5.2\r\
    \nIPLAN: 192.168.150.1\r\
    \nDHCP: 150.100 - 150.120\r\
    \n\r\
    \nAcesso remoto na porta 8080" mac-address=D4:6E:0E:3D:61:85 server=dhcp1
/ip dhcp-server lease add address=192.168.0.105 client-id=20fd.f1ee.dd50-Vlan-interface1 comment=Switch mac-address=20:FD:F1:EE:DD:50 server=dhcp1
/ip dhcp-server lease add address=192.168.0.102 client-id=4001.c63d.79e3-Vlan-interface1 comment=Switch mac-address=40:01:C6:3D:79:E3 server=dhcp1
/ip dhcp-server lease add address=192.168.0.104 client-id=20fd.f1ee.df94-Vlan-interface1 comment=Switch mac-address=20:FD:F1:EE:DF:94 server=dhcp1
/ip dhcp-server lease add address=192.168.0.103 client-id=0024.7381.d759-Vlan-interface1 comment=Switch mac-address=00:24:73:81:D7:59 server=dhcp1
/ip dhcp-server lease add address=192.168.0.106 client-id=b8af.671d.2613-Vlan-interface1 comment=Switch mac-address=B8:AF:67:1D:26:13 server=dhcp1
/ip dhcp-server lease add address=192.168.0.101 comment=Switch mac-address=04:09:73:34:2F:C0 server=dhcp1
/ip dhcp-server lease add address=192.168.3.12 comment="DVR Alb2 - Porta 37771 " mac-address=00:1A:3F:3C:63:07 server=dhcp1
/ip dhcp-server lease add address=192.168.3.11 comment="DVR Alb1 - Porta 37770 " disabled=yes mac-address=00:1A:3F:3A:CD:38 server=dhcp1
/ip dhcp-server lease add address=192.168.3.14 block-access=yes comment="DVR Espelho1 - Porta 37773" disabled=yes mac-address=58:10:8C:2B:0D:E8 server=dhcp1
/ip dhcp-server lease add address=192.168.3.15 block-access=yes comment="DVR Espelho2 - Porta 37774" disabled=yes mac-address=00:1A:3F:3A:E2:6C server=dhcp1
/ip dhcp-server lease add address=192.168.3.61 comment=FemtoCell mac-address=B0:46:FC:52:59:76 server=dhcp1
/ip dhcp-server lease add address=192.168.6.14 client-id=1:c8:9c:dc:c5:ed:a4 comment="PC - Maquina 6 (Operacional)" mac-address=C8:9C:DC:C5:ED:A4 server=dhcp1
/ip dhcp-server lease add address=192.168.6.105 block-access=yes client-id=1:fc:aa:14:f5:47:b4 comment="PC - Eduardo (JurTrab)" mac-address=FC:AA:14:F5:47:B4 server=dhcp1
/ip dhcp-server lease add address=192.168.6.115 client-id=1:4:d9:f5:76:5d:66 comment="PC - Cristina (ComPriv)" mac-address=04:D9:F5:76:5D:66 server=dhcp1
/ip dhcp-server lease add address=192.168.6.62 client-id=1:4c:72:b9:9f:5c:70 comment="PC - Vago (Arcolimp) debaixo do ar-condicionado" mac-address=4C:72:B9:9F:5C:70 server=dhcp1
/ip dhcp-server lease add address=192.168.6.3 client-id=1:fc:aa:14:f5:46:da comment="PC - Assist. Operacional (Operacional)" mac-address=FC:AA:14:F5:46:DA server=dhcp1
/ip dhcp-server lease add address=192.168.6.127 client-id=1:1c:1b:d:f4:4b:aa comment="PC - Jessica (Financeiro)" mac-address=1C:1B:0D:F4:4B:AA server=dhcp1
/ip dhcp-server lease add address=192.168.6.123 client-id=1:1c:1b:d:f4:54:d8 comment="PC - Adrielle (Faturamento)" mac-address=1C:1B:0D:F4:54:D8 server=dhcp1
/ip dhcp-server lease add address=192.168.6.89 client-id=1:70:4d:7b:ce:e9:d3 comment="PC - Ana Paula (Secretaria Diretoria)" mac-address=70:4D:7B:CE:E9:D3 server=dhcp1
/ip dhcp-server lease add address=192.168.6.135 client-id=1:70:4d:7b:ce:e8:c8 comment="PC - Fernanda (Contratos)" mac-address=70:4D:7B:CE:E8:C8 server=dhcp1
/ip dhcp-server lease add address=192.168.6.91 client-id=1:4:d9:f5:76:41:d comment="PC - Alan (ComPub)" mac-address=04:D9:F5:76:41:0D server=dhcp1
/ip dhcp-server lease add address=192.168.6.92 client-id=1:4:d9:f5:76:41:16 comment="PC - Paula (ComPub)" mac-address=04:D9:F5:76:41:16 server=dhcp1
/ip dhcp-server lease add address=192.168.3.52 comment="Controladora 1 (motos e diretoria) " disabled=yes mac-address=D8:80:39:36:5B:DA server=dhcp1
/ip dhcp-server lease add address=192.168.3.53 comment="Controladora 2 (portao aluminio saida motos)" disabled=yes mac-address=00:1E:C0:E9:A3:3F server=dhcp1
/ip dhcp-server lease add address=192.168.3.54 comment="Controladora 3 (catraca e cofre de crachas)" disabled=yes mac-address=D8:80:39:30:FD:DF server=dhcp1
/ip dhcp-server lease add address=192.168.6.120 client-id=1:e0:d5:5e:f0:ab:1a comment="PC - Henrique (Faturamento)" mac-address=E0:D5:5E:F0:AB:1A server=dhcp1
/ip dhcp-server lease add address=192.168.6.4 client-id=1:c8:9c:dc:4d:e:ea comment="PC - Viviane/Andre (Operacional)" mac-address=C8:9C:DC:4D:0E:EA server=dhcp1
/ip dhcp-server lease add address=192.168.5.6 client-id=1:d8:d:17:68:79:39 comment="(Suprimentos) SSID: WifiAlb6\r\
    \nSenha: @lbatr0z12345\r\
    \n\r\
    \nuser: admin\r\
    \nsenha:4lb4tr0z\r\
    \n\r\
    \nIPWAN: 192.168.5.6\r\
    \nIPLAN: 192.168.150.1\r\
    \nDHCP: 150.100 - 150.120\r\
    \n\r\
    \nAcesso remoto na porta 8080" dhcp-option=DNS_Google mac-address=D8:0D:17:68:79:39 server=dhcp1
/ip dhcp-server lease add address=192.168.3.17 client-id=1:d8:77:8b:b4:33:1f comment="DVR Espelho3 - Mesa Operacional" mac-address=D8:77:8B:B4:33:1F server=dhcp1
/ip dhcp-server lease add address=192.168.3.18 client-id=1:d8:77:8b:b4:15:c9 comment="DVR Espelho4 - Mesa Operacional" mac-address=D8:77:8B:B4:15:C9 server=dhcp1
/ip dhcp-server lease add address=192.168.3.20 client-id=1:d8:77:8b:b4:33:1a comment="DVR Espelho6 - Mesa Operacional" mac-address=D8:77:8B:B4:33:1A server=dhcp1
/ip dhcp-server lease add address=192.168.3.19 client-id=1:d8:77:8b:b4:15:c3 comment="DVR Espelho5 - Mesa Operacional" mac-address=D8:77:8B:B4:15:C3 server=dhcp1
/ip dhcp-server lease add address=192.168.3.16 client-id=1:80:8f:e8:a4:5:f1 comment="DVR Estacionamento" mac-address=80:8F:E8:A4:05:F1 server=dhcp1
/ip dhcp-server lease add address=192.168.3.148 block-access=yes comment="Antena - Matriz2\
    \n\
    \nHost:\
    \nAnt-Matriz2\
    \n\
    \nSSID:\
    \nALB_PTP\
    \n\
    \nPASS:\
    \n@lb4tr0z12345\
    \n\
    \n\
    \nadmin:\
    \n4lb4tr0z\
    \n\
    \n\
    \nIP:\
    \n192.168.3.102\
    \n" mac-address=44:3B:32:33:0B:EB server=dhcp1
/ip dhcp-server lease add address=192.168.3.149 block-access=yes comment="Antena - Almoxarifado\
    \n\
    \nHost:\
    \nAnt-Almox\
    \n\
    \nSSID:\
    \nALB_PTP2\
    \n\
    \nPASS:\
    \n@lb4tr0z12345\
    \n\
    \n\
    \nadmin:\
    \n4lb4tr0z\
    \n\
    \n\
    \nIP:\
    \n192.168.3.103\
    \n" mac-address=44:3B:32:33:0C:1B server=dhcp1
/ip dhcp-server lease add address=192.168.6.29 client-id=1:e0:d5:5e:f6:93:fe comment="PC - Frank (Controladoria)" mac-address=E0:D5:5E:F6:93:FE server=dhcp1
/ip dhcp-server lease add address=192.168.6.101 client-id=1:fc:aa:14:f8:90:c comment="PC - Larissa (JurTrab)" mac-address=FC:AA:14:F8:90:0C server=dhcp1
/ip dhcp-server lease add address=192.168.10.54 client-id=1:e0:d5:5e:f6:94:c0 comment="PC - Francisca (Contabilidade)" dhcp-option=DNS_Google mac-address=E0:D5:5E:F6:94:C0 server=dhcp1
/ip dhcp-server lease add address=192.168.6.94 client-id=1:8c:89:a5:fa:29:8c comment="PC - Vago (ComPub)" mac-address=8C:89:A5:FA:29:8C server=dhcp1
/ip dhcp-server lease add address=192.168.6.152 client-id=1:4:d9:f5:76:5d:63 comment="PC - Joao (Almoxarifado)" mac-address=04:D9:F5:76:5D:63 server=dhcp1
/ip dhcp-server lease add address=192.168.0.2 block-access=yes client-id=1:d4:6e:e:7c:17:8d comment="(Auditorio) FreeWifi - Need Unblock DHCP" dhcp-option=DNS_Google mac-address=D4:6E:0E:7C:17:8D server=dhcp1
/ip dhcp-server lease add address=192.168.3.60 comment="Interface Medidor Paineis Solares" disabled=yes mac-address=60:C5:A8:76:7F:7E server=dhcp1
/ip dhcp-server lease add address=192.168.3.55 comment="Corredor Armamento e Armamento" mac-address=54:10:EC:8A:BA:73 server=dhcp1
/ip dhcp-server lease add address=192.168.3.56 comment="Entrada Eletronica/Monitoramento/Treinamento" mac-address=54:10:EC:C0:52:72 server=dhcp1
/ip dhcp-server lease add address=192.168.6.64 client-id=1:fc:34:97:7a:ed:12 comment="PC - Cesar (DP)" mac-address=FC:34:97:7A:ED:12 server=dhcp1
/ip dhcp-server lease add address=192.168.6.100 client-id=1:d0:17:c2:8e:87:b5 comment="PC - Jean (JurTrab)" mac-address=D0:17:C2:8E:87:B5 server=dhcp1
/ip dhcp-server lease add address=192.168.7.48 comment="Ramal - 2156" mac-address=C8:1F:EA:8F:53:A8 server=dhcp1
/ip dhcp-server lease add address=192.168.7.52 comment="Ramal - 2108" mac-address=C8:1F:EA:8F:5C:EA server=dhcp1
/ip dhcp-server lease add address=192.168.7.21 comment="Ramal - 2127" mac-address=C8:1F:EA:8F:5C:F6 server=dhcp1
/ip dhcp-server lease add address=192.168.7.46 comment="Ramal - 2233" mac-address=C8:1F:EA:8F:67:71 server=dhcp1
/ip dhcp-server lease add address=192.168.7.31 comment="Ramal - 2132" mac-address=C8:1F:EA:8F:45:15 server=dhcp1
/ip dhcp-server lease add address=192.168.7.66 comment="Ramal - 2222" mac-address=C8:1F:EA:8F:52:FE server=dhcp1
/ip dhcp-server lease add address=192.168.7.90 comment="Ramal - 2121" mac-address=C8:1F:EA:8F:45:B2 server=dhcp1
/ip dhcp-server lease add address=192.168.7.75 comment="Ramal - 2164" mac-address=C8:1F:EA:8F:50:12 server=dhcp1
/ip dhcp-server lease add address=192.168.7.50 comment="Ramal - 2173" mac-address=C8:1F:EA:8F:5C:B4 server=dhcp1
/ip dhcp-server lease add address=192.168.7.49 comment="Ramal - 2167" mac-address=C8:1F:EA:8F:5C:D1 server=dhcp1
/ip dhcp-server lease add address=192.168.7.55 comment="Ramal - 2170" mac-address=C8:1F:EA:8F:54:C0 server=dhcp1
/ip dhcp-server lease add address=192.168.7.78 comment="Ramal - 2124" mac-address=C8:1F:EA:8F:50:18 server=dhcp1
/ip dhcp-server lease add address=192.168.7.61 comment="Ramal - 2177" mac-address=C8:1F:EA:8F:4B:4E server=dhcp1
/ip dhcp-server lease add address=192.168.7.76 comment="Ramal - 2131" mac-address=C8:1F:EA:8F:4F:D2 server=dhcp1
/ip dhcp-server lease add address=192.168.7.24 comment="Ramal - 2152" mac-address=C8:1F:EA:8F:67:3A server=dhcp1
/ip dhcp-server lease add address=192.168.7.41 comment="Ramal - 2299" mac-address=C8:1F:EA:8F:4C:74 server=dhcp1
/ip dhcp-server lease add address=192.168.7.65 comment="Ramal - 2155" mac-address=C8:1F:EA:8D:7E:47 server=dhcp1
/ip dhcp-server lease add address=192.168.7.18 comment="Ramal - 2178" mac-address=C8:1F:EA:8D:7D:22 server=dhcp1
/ip dhcp-server lease add address=192.168.7.40 comment="Ramal - 2144" mac-address=C8:1F:EA:8D:7D:1A server=dhcp1
/ip dhcp-server lease add address=192.168.7.57 comment="Ramal - 2283" mac-address=C8:1F:EA:8B:49:93 server=dhcp1
/ip dhcp-server lease add address=192.168.7.85 comment="Ramal - 2103" mac-address=C8:1F:EA:8F:5C:E6 server=dhcp1
/ip dhcp-server lease add address=192.168.7.38 comment="Ramal - 2290 (Plano de Saude)" mac-address=C8:1F:EA:8D:89:44 server=dhcp1
/ip dhcp-server lease add address=192.168.7.93 comment="Ramal - 2125" mac-address=C8:1F:EA:8F:67:61 server=dhcp1
/ip dhcp-server lease add address=192.168.7.86 comment="Ramal - 2179" mac-address=C8:1F:EA:8F:51:83 server=dhcp1
/ip dhcp-server lease add address=192.168.7.26 comment="Ramal - 2123" mac-address=C8:1F:EA:8F:45:49 server=dhcp1
/ip dhcp-server lease add address=192.168.7.39 comment="Ramal - 2119" mac-address=C8:1F:EA:8D:7E:59 server=dhcp1
/ip dhcp-server lease add address=192.168.7.34 comment="Ramal - 2130" mac-address=C8:1F:EA:8F:51:E8 server=dhcp1
/ip dhcp-server lease add address=192.168.7.37 comment="Ramal - 2117" mac-address=C8:1F:EA:8F:44:F1 server=dhcp1
/ip dhcp-server lease add address=192.168.7.64 comment="Ramal - 2148" mac-address=C8:1F:EA:8F:67:D7 server=dhcp1
/ip dhcp-server lease add address=192.168.7.89 comment="Ramal - 2163" mac-address=C8:1F:EA:8F:4D:15 server=dhcp1
/ip dhcp-server lease add address=192.168.7.36 comment="Ramal - 2126" mac-address=C8:1F:EA:8F:54:29 server=dhcp1
/ip dhcp-server lease add address=192.168.7.27 comment="Ramal - 2135" mac-address=C8:1F:EA:8F:67:A1 server=dhcp1
/ip dhcp-server lease add address=192.168.7.70 comment="Ramal - 2140" mac-address=C8:1F:EA:8F:67:7E server=dhcp1
/ip dhcp-server lease add address=192.168.7.35 comment="Ramal - 2287" mac-address=C8:1F:EA:8D:89:8D server=dhcp1
/ip dhcp-server lease add address=192.168.7.58 comment="Ramal - 2110" mac-address=C8:1F:EA:8D:7E:44 server=dhcp1
/ip dhcp-server lease add address=192.168.7.20 comment="Ramal - 2118" mac-address=C8:1F:EA:8B:DB:99 server=dhcp1
/ip dhcp-server lease add address=192.168.7.54 comment="Ramal - 2129" mac-address=C8:1F:EA:8D:88:7F server=dhcp1
/ip dhcp-server lease add address=192.168.7.33 comment="Ramal - 2102" mac-address=C8:1F:EA:8F:50:21 server=dhcp1
/ip dhcp-server lease add address=192.168.7.96 comment="Ramal - 2136" mac-address=C8:1F:EA:7A:B6:4D server=dhcp1
/ip dhcp-server lease add address=192.168.7.69 comment="Ramal - 2151" mac-address=C8:1F:EA:8D:77:F5 server=dhcp1
/ip dhcp-server lease add address=192.168.7.12 comment="Ramal - 2190" mac-address=C8:1F:EA:8F:54:45 server=dhcp1
/ip dhcp-server lease add address=192.168.7.29 comment="Ramal - 2295" mac-address=C8:1F:EA:8F:4B:59 server=dhcp1
/ip dhcp-server lease add address=192.168.7.42 comment="Ramal - 2138" mac-address=C8:1F:EA:8F:44:E7 server=dhcp1
/ip dhcp-server lease add address=192.168.7.30 comment="Ramal - 2134" mac-address=C8:1F:EA:8F:5C:DB server=dhcp1
/ip dhcp-server lease add address=192.168.7.28 comment="Ramal - 2297" mac-address=C8:1F:EA:8F:4B:5F server=dhcp1
/ip dhcp-server lease add address=192.168.7.79 comment="Ramal - 2195" mac-address=C8:1F:EA:8F:4B:65 server=dhcp1
/ip dhcp-server lease add address=192.168.7.62 comment="Ramal - 2232" mac-address=C8:1F:EA:8D:7E:13 server=dhcp1
/ip dhcp-server lease add address=192.168.7.23 comment="Ramal - 2137" mac-address=C8:1F:EA:78:DB:BF server=dhcp1
/ip dhcp-server lease add address=192.168.7.77 comment="Ramal - 2200" mac-address=C8:1F:EA:8D:88:70 server=dhcp1
/ip dhcp-server lease add address=192.168.7.32 comment="Ramal - 2168" mac-address=C8:1F:EA:8D:7E:45 server=dhcp1
/ip dhcp-server lease add address=192.168.7.60 comment="Ramal - 2169" mac-address=C8:1F:EA:8F:67:87 server=dhcp1
/ip dhcp-server lease add address=192.168.7.43 comment="Ramal - 2191" mac-address=C8:1F:EA:8D:88:53 server=dhcp1
/ip dhcp-server lease add address=192.168.7.72 comment="Ramal - 2113" mac-address=C8:1F:EA:8F:45:7E server=dhcp1
/ip dhcp-server lease add address=192.168.7.63 comment="Ramal - 2253" mac-address=C8:1F:EA:8D:89:3D server=dhcp1
/ip dhcp-server lease add address=192.168.7.47 comment="Ramal - 2257" mac-address=C8:1F:EA:8D:88:95 server=dhcp1
/ip dhcp-server lease add address=192.168.7.94 comment="Ramal - 2185" mac-address=C8:1F:EA:8D:7D:01 server=dhcp1
/ip dhcp-server lease add address=192.168.7.97 comment="Ramal - 2223" mac-address=C8:1F:EA:8D:7D:02 server=dhcp1
/ip dhcp-server lease add address=192.168.7.16 comment="Ramal - 2192" mac-address=C8:1F:EA:8B:E3:43 server=dhcp1
/ip dhcp-server lease add address=192.168.7.22 comment="Ramal - 2180" mac-address=C8:1F:EA:8D:88:FF server=dhcp1
/ip dhcp-server lease add address=192.168.7.15 comment="Ramal - 2289" mac-address=C8:1F:EA:8F:5C:B0 server=dhcp1
/ip dhcp-server lease add address=192.168.7.14 comment="Ramal - 2285" mac-address=C8:1F:EA:8F:4B:61 server=dhcp1
/ip dhcp-server lease add address=192.168.7.67 comment="Ramal - 2188" mac-address=C8:1F:EA:8F:5C:E2 server=dhcp1
/ip dhcp-server lease add address=192.168.7.13 comment="Ramal - 2104" mac-address=C8:1F:EA:8F:5C:AF server=dhcp1
/ip dhcp-server lease add address=192.168.7.56 comment="Ramal - 2172" mac-address=C8:1F:EA:78:DB:73 server=dhcp1
/ip dhcp-server lease add address=192.168.7.45 comment="Ramal - 2105" mac-address=C8:1F:EA:8D:71:FF server=dhcp1
/ip dhcp-server lease add address=192.168.7.11 comment="Ramal - 2171" mac-address=C8:1F:EA:8D:7D:4B server=dhcp1
/ip dhcp-server lease add address=192.168.7.59 comment="Ramal - 2193" mac-address=C8:1F:EA:8D:7E:3C server=dhcp1
/ip dhcp-server lease add address=192.168.7.92 comment="Ramal - 2154" mac-address=C8:1F:EA:7A:C0:1A server=dhcp1
/ip dhcp-server lease add address=192.168.7.10 comment="Ramal - 2194" mac-address=C8:1F:EA:8B:E2:E9 server=dhcp1
/ip dhcp-server lease add address=192.168.7.87 comment="Ramal - 2229" mac-address=C8:1F:EA:8B:E2:D6 server=dhcp1
/ip dhcp-server lease add address=192.168.7.19 comment="Ramal - 2183" disabled=yes mac-address=C8:1F:EA:8D:7D:13 server=dhcp1
/ip dhcp-server lease add address=192.168.7.17 comment="Ramal - 2180" mac-address=C8:1F:EA:8F:50:0F server=dhcp1
/ip dhcp-server lease add address=192.168.7.51 comment="Ramal - 2109" mac-address=C8:1F:EA:8D:78:41 server=dhcp1
/ip dhcp-server lease add address=192.168.3.57 disabled=yes mac-address=54:10:EC:8C:33:54 server=dhcp1
/ip dhcp-server lease add address=192.168.7.84 comment="Ramal - 2165" mac-address=C8:1F:EA:8F:50:1F server=dhcp1
/ip dhcp-server lease add address=192.168.7.25 comment="Ramal - 2280" mac-address=C8:1F:EA:8B:DB:7C server=dhcp1
/ip dhcp-server lease add address=192.168.7.95 comment="Ramal - 2116" mac-address=C8:1F:EA:8F:4F:D4 server=dhcp1
/ip dhcp-server lease add address=192.168.7.71 comment="Ramal - 2235" mac-address=C8:1F:EA:8B:DF:4E server=dhcp1
/ip dhcp-server lease add address=192.168.7.44 comment="Ramal - 2161" mac-address=C8:1F:EA:8F:67:60 server=dhcp1
/ip dhcp-server lease add address=192.168.7.83 comment="Ramal - 2158" mac-address=C8:1F:EA:8D:7E:63 server=dhcp1
/ip dhcp-server lease add address=192.168.7.81 comment="Ramal - 2175" mac-address=C8:1F:EA:8F:5C:E7 server=dhcp1
/ip dhcp-server lease add address=192.168.7.82 comment="Ramal - 2255" mac-address=C8:1F:EA:8F:49:21 server=dhcp1
/ip dhcp-server lease add address=192.168.7.88 comment="Ramal - 2160" mac-address=C8:1F:EA:8B:E2:FE server=dhcp1
/ip dhcp-server lease add address=192.168.7.73 comment="Ramal - 2234" mac-address=C8:1F:EA:8F:5C:FD server=dhcp1
/ip dhcp-server lease add address=192.168.7.98 comment="Ramal - 2187" mac-address=C8:1F:EA:8B:DB:9D server=dhcp1
/ip dhcp-server lease add address=192.168.7.99 comment="Ramal - 2133" mac-address=C8:1F:EA:8F:45:55 server=dhcp1
/ip dhcp-server lease add address=192.168.7.100 comment="Ramal - 2291" mac-address=C8:1F:EA:8D:75:8E server=dhcp1
/ip dhcp-server lease add address=192.168.7.101 comment="Ramal - 2145" mac-address=C8:1F:EA:8F:5D:AA server=dhcp1
/ip dhcp-server lease add address=192.168.7.102 comment="Ramal - 2157" mac-address=C8:1F:EA:8F:4F:F4 server=dhcp1
/ip dhcp-server lease add address=192.168.7.103 comment="Ramal - 2181" mac-address=C8:1F:EA:8F:67:AD server=dhcp1
/ip dhcp-server lease add address=192.168.7.105 comment="Ramal - 2286" mac-address=C8:1F:EA:8F:4B:6F server=dhcp1
/ip dhcp-server lease add address=192.168.7.104 comment="Ramal - 2122" mac-address=C8:1F:EA:8F:50:DF server=dhcp1
/ip dhcp-server lease add address=192.168.7.106 comment="Ramal - 2292" mac-address=C8:1F:EA:8D:89:31 server=dhcp1
/ip dhcp-server lease add address=192.168.7.74 comment="Ramal - \?\?\?\?" mac-address=C8:1F:EA:8F:4B:7D server=dhcp1
/ip dhcp-server lease add address=192.168.7.107 comment="Ramal - 2101" mac-address=C8:1F:EA:8F:4B:7B server=dhcp1
/ip dhcp-server lease add address=192.168.3.51 client-id=1:10:78:d2:b8:51:4a comment="Servidor Controle de Catraca" mac-address=10:78:D2:B8:51:4A server=dhcp1
/ip dhcp-server lease add address=192.168.7.53 comment="Ramal - 2147" mac-address=C8:1F:EA:8D:7E:7C server=dhcp1
/ip dhcp-server lease add address=192.168.6.131 client-id=1:34:97:f6:ea:65:68 comment="PC - Luciana (JurCiv)" mac-address=34:97:F6:EA:65:68 server=dhcp1
/ip dhcp-server lease add address=192.168.6.121 client-id=1:1c:1b:d:f4:4b:8e comment="PC - Jose Matos (Faturamento)" mac-address=1C:1B:0D:F4:4B:8E server=dhcp1
/ip dhcp-server lease add address=192.168.6.111 client-id=1:d0:94:66:ba:23:79 comment="PC - Ailton (ComPriv)" dhcp-option=DNS_Google mac-address=D0:94:66:BA:23:79 server=dhcp1
/ip dhcp-server lease add address=192.168.6.112 client-id=1:5c:cd:5b:1b:87:e9 comment="PC - Ailton (ComPriv) (Wifi)" mac-address=5C:CD:5B:1B:87:E9 server=dhcp1
/ip dhcp-server lease add address=192.168.10.52 client-id=1:0:d7:6d:24:93:93 comment="PC - Marco Antonio Novo (Wifi)" dhcp-option=DNS_Google mac-address=00:D7:6D:24:93:93 server=dhcp1
/ip dhcp-server lease add address=192.168.6.17 client-id=1:70:4d:7b:ce:e9:d4 comment="PC - Maquina 9 (Operacional)" mac-address=70:4D:7B:CE:E9:D4 server=dhcp1
/ip dhcp-server lease add address=192.168.6.15 client-id=1:88:d7:f6:1a:15:a2 comment="PC - Maquina 7 (Operacional)" mac-address=88:D7:F6:1A:15:A2 server=dhcp1
/ip dhcp-server lease add address=192.168.6.61 client-id=1:a8:a1:59:30:28:f6 comment="PC - Fatima (Arcolimp)" mac-address=A8:A1:59:30:28:F6 server=dhcp1
/ip dhcp-server lease add address=192.168.6.103 client-id=1:a8:a1:59:30:3f:18 comment="PC - William (JurTrab)" mac-address=A8:A1:59:30:3F:18 server=dhcp1
/ip dhcp-server lease add address=192.168.6.5 client-id=1:70:4d:7b:ce:e9:c8 comment="PC - Roberto (Operacional)" mac-address=70:4D:7B:CE:E9:C8 server=dhcp1
/ip dhcp-server lease add address=192.168.7.80 comment="Ramal - 2114" mac-address=C8:1F:EA:8B:48:F6 server=dhcp1
/ip dhcp-server lease add address=192.168.6.99 client-id=1:a8:a1:59:30:28:e1 comment="PC - Milan (JurTrab)" mac-address=A8:A1:59:30:28:E1 server=dhcp1
/ip dhcp-server lease add address=192.168.10.53 client-id=1:0:e:c6:85:2a:ab comment="PC - Marco Antonio Novo (Hub USB)" dhcp-option=DNS_Google mac-address=00:0E:C6:85:2A:AB server=dhcp1
/ip dhcp-server lease add address=192.168.6.110 client-id=1:88:d7:f6:1a:c:a7 comment="PC - Araujo (ComPriv)" mac-address=88:D7:F6:1A:0C:A7 server=dhcp1
/ip dhcp-server lease add address=192.168.10.27 client-id=1:8c:f1:12:11:3a:1e comment="Motorola BTG - Leandro (Diretoria)" mac-address=8C:F1:12:11:3A:1E server=dhcp1
/ip dhcp-server lease add address=192.168.6.1 client-id=1:8c:4:ba:fc:72:66 comment="PC - Cleber (Ger. OP) (Wired)" dhcp-option=DNS_Google mac-address=8C:04:BA:FC:72:66 server=dhcp1
/ip dhcp-server lease add address=192.168.7.91 comment="Ramal - 2182" mac-address=C8:1F:EA:8D:7C:EB server=dhcp1
/ip dhcp-server lease add address=192.168.7.68 comment="Ramal - 2176" mac-address=C8:1F:EA:8F:44:DC server=dhcp1
/ip dhcp-server lease add address=192.168.6.102 client-id=1:d4:5d:64:34:aa:47 comment="PC - Samuel (JurTrab)" dhcp-option=DNS_Google mac-address=D4:5D:64:34:AA:47 server=dhcp1
/ip dhcp-server lease add address=192.168.6.77 client-id=1:d8:5e:d3:f3:1e:d1 comment="PC - Jadiane (DP)" mac-address=D8:5E:D3:F3:1E:D1 server=dhcp1
/ip dhcp-server lease add address=192.168.6.78 client-id=1:d8:5e:d3:f3:86:79 comment="PC - Brenda (DP)" mac-address=D8:5E:D3:F3:86:79 server=dhcp1
/ip dhcp-server lease add address=192.168.6.82 client-id=1:d8:5e:d3:f3:86:7a comment="PC - Jessica (DP)" mac-address=D8:5E:D3:F3:86:7A server=dhcp1
/ip dhcp-server lease add address=192.168.6.84 client-id=1:d8:5e:d3:f3:86:75 comment="PC - Janaina Candelo (DP)" mac-address=D8:5E:D3:F3:86:75 server=dhcp1
/ip dhcp-server lease add address=192.168.6.141 client-id=1:d8:5e:d3:f3:86:70 comment="PC - Matheus (Apoio)" mac-address=D8:5E:D3:F3:86:70 server=dhcp1
/ip dhcp-server lease add address=192.168.5.10 client-id=1:e4:c3:2a:f9:ed:47 comment="(Jacaranda)\r\
    \nSSID: Jacaranda\r\
    \nSenha: A1l2b3a4\r\
    \n\r\
    \nuser: admin\r\
    \nsenha: 4lb4tr0z\r\
    \n\r\
    \nIPWAN: 192.168.5.10\r\
    \nIPLAN: 192.168.150.1\r\
    \nDHCP: 150.100 - 150.120\r\
    \n\r\
    \nAcesso remoto na porta 8080\r\
    \n" dhcp-option=DNS_Google mac-address=E4:C3:2A:F9:ED:47 server=dhcp1
/ip dhcp-server lease add address=192.168.6.75 client-id=1:d8:5e:d3:f3:86:72 comment="PC - Valeria (DP)" mac-address=D8:5E:D3:F3:86:72 server=dhcp1
/ip dhcp-server lease add address=192.168.6.72 client-id=1:d8:5e:d3:f3:86:76 comment="PC - Tamara (DP)" mac-address=D8:5E:D3:F3:86:76 server=dhcp1
/ip dhcp-server lease add address=192.168.6.67 client-id=1:d8:5e:d3:f3:86:69 comment="PC - Luiz (DP)" mac-address=D8:5E:D3:F3:86:69 server=dhcp1
/ip dhcp-server lease add address=192.168.6.73 client-id=1:d8:5e:d3:f3:1f:e comment="PC - Renan (DP)" mac-address=D8:5E:D3:F3:1F:0E server=dhcp1
/ip dhcp-server lease add address=192.168.6.68 client-id=1:d8:5e:d3:f3:86:63 comment="PC - Lucas Avelhan (DP)" mac-address=D8:5E:D3:F3:86:63 server=dhcp1
/ip dhcp-server lease add address=192.168.6.66 client-id=1:d8:5e:d3:f3:86:73 comment="PC - Elisabete (DP)" mac-address=D8:5E:D3:F3:86:73 server=dhcp1
/ip dhcp-server lease add address=192.168.6.81 client-id=1:d8:5e:d3:f3:86:6f comment="PC - Camila (DP)" mac-address=D8:5E:D3:F3:86:6F server=dhcp1
/ip dhcp-server lease add address=192.168.6.80 client-id=1:d8:5e:d3:f3:86:4f comment="PC - Mariana (DP)" mac-address=D8:5E:D3:F3:86:4F server=dhcp1
/ip dhcp-server lease add address=192.168.6.70 client-id=1:d8:5e:d3:f3:86:6a comment="PC - Lucas (DP)" mac-address=D8:5E:D3:F3:86:6A server=dhcp1
/ip dhcp-server lease add address=192.168.6.86 client-id=1:d8:5e:d3:f3:86:6c comment="PC - Melissa (DP)" mac-address=D8:5E:D3:F3:86:6C server=dhcp1
/ip dhcp-server lease add address=192.168.6.85 client-id=1:d8:5e:d3:f3:86:4e comment="PC - Admissao JA (DP)" mac-address=D8:5E:D3:F3:86:4E server=dhcp1
/ip dhcp-server lease add address=192.168.6.51 client-id=1:d8:5e:d3:f3:86:6b comment="PC - Alex Moreto (Arquivo)" mac-address=D8:5E:D3:F3:86:6B server=dhcp1
/ip dhcp-server lease add address=192.168.6.53 client-id=1:88:d7:f6:19:fb:3b comment="PC - Maquina 2 (Arquivo)" mac-address=88:D7:F6:19:FB:3B server=dhcp1
/ip dhcp-server lease add address=192.168.6.54 client-id=1:70:4d:7b:ce:e9:b0 comment="PC - Maquina 3 (Arquivo)" mac-address=70:4D:7B:CE:E9:B0 server=dhcp1
/ip dhcp-server lease add address=192.168.6.52 client-id=1:70:4d:7b:ce:e9:b7 comment="PC - Maquina 1 (Arquivo)" mac-address=70:4D:7B:CE:E9:B7 server=dhcp1
/ip dhcp-server lease add address=192.168.6.139 client-id=1:d0:17:c2:8e:87:b8 comment="PC - Gabriel (Apoio)" mac-address=D0:17:C2:8E:87:B8 server=dhcp1
/ip dhcp-server lease add address=192.168.6.83 client-id=1:d8:5e:d3:f3:86:74 comment="PC - Kauany (DP)" mac-address=D8:5E:D3:F3:86:74 server=dhcp1
/ip dhcp-server lease add address=192.168.6.140 client-id=1:e0:d5:5e:f1:7a:92 comment="PC - JA (Apoio)" mac-address=E0:D5:5E:F1:7A:92 server=dhcp1
/ip dhcp-server lease add address=192.168.6.87 client-id=1:88:d7:f6:1a:c:b0 comment="PC - Julia (DP)" mac-address=88:D7:F6:1A:0C:B0 server=dhcp1
/ip dhcp-server lease add address=192.168.6.65 client-id=1:d8:5e:d3:f3:86:67 comment="PC - Janaina (DP)" mac-address=D8:5E:D3:F3:86:67 server=dhcp1
/ip dhcp-server lease add address=192.168.6.16 client-id=1:fc:aa:14:f5:46:d7 comment="PC - Maquina 8 (Operacional)" mac-address=FC:AA:14:F5:46:D7 server=dhcp1
/ip dhcp-server lease add address=192.168.3.31 comment="Botao de Panico Estacionamento" disabled=yes mac-address=80:34:28:18:AD:A3 server=dhcp1
/ip dhcp-server lease add address=192.168.3.32 comment="Luz Emergencia Estacionamento" disabled=yes mac-address=80:34:28:19:34:5C server=dhcp1
/ip dhcp-server lease add address=192.168.3.33 comment="Porteiro Eletronico Estacionamento" disabled=yes mac-address=04:91:62:CB:67:80 server=dhcp1
/ip dhcp-server lease add address=192.168.10.181 client-id=1:30:83:d2:18:2a:68 comment="Cel Antonio" dhcp-option=DNS_Google mac-address=30:83:D2:18:2A:68 server=dhcp1
/ip dhcp-server lease add address=192.168.10.11 client-id=1:d8:5e:d3:f3:c:4 comment="antiga Suporte (TI2)" dhcp-option=DNS_Google mac-address=D8:5E:D3:F3:0C:04 server=dhcp1
/ip dhcp-server lease add address=192.168.3.22 client-id=1:d8:36:5f:3f:2c:8e comment="DVR Alb4 - Porta 37710 (CPD)" mac-address=D8:36:5F:3F:2C:8E server=dhcp1
/ip dhcp-server lease add address=192.168.6.25 client-id=1:4:d9:f5:75:e8:c2 comment="PC - Atendimento Operacional (Plantao)" mac-address=04:D9:F5:75:E8:C2 server=dhcp1
/ip dhcp-server lease add address=192.168.3.50 client-id=1:88:d7:f6:19:ce:5 comment="SRV - Condor - Receptor GPRS" mac-address=88:D7:F6:19:CE:05 server=dhcp1
/ip dhcp-server lease add address=192.168.3.13 client-id=1:d8:36:5f:6b:50:6 comment="DVR Alb3 - Porta 37772" mac-address=D8:36:5F:6B:50:06 server=dhcp1
/ip dhcp-server lease add address=192.168.3.26 client-id=1:d0:17:c2:8e:64:e9 comment="Cameras Gerencia (Operacional)" mac-address=D0:17:C2:8E:64:E9 server=dhcp1
/ip dhcp-server lease add address=192.168.6.26 client-id=1:70:4d:7b:ce:e8:dc comment="PC - Matheus (Treinamentos) " mac-address=70:4D:7B:CE:E8:DC server=dhcp1
/ip dhcp-server lease add address=192.168.1.13 client-id=1:aa:51:1:ae:ce:73 comment="NDD (CF Brasil)" dhcp-option=DNS_Google mac-address=AA:51:01:AE:CE:73 server=dhcp1
/ip dhcp-server lease add address=192.168.6.125 client-id=1:78:24:af:ba:72:51 comment="Notebook Acer Prata" mac-address=78:24:AF:BA:72:51 server=dhcp1
/ip dhcp-server lease add address=192.168.10.215 block-access=yes client-id=1:86:d8:7c:dd:68:a7 comment="Terminal OBB" mac-address=86:D8:7C:DD:68:A7 server=dhcp1
/ip dhcp-server lease add address=192.168.11.19 block-access=yes comment="InPro Comm" mac-address=00:08:22:7C:D3:FB server=dhcp1
/ip dhcp-server lease add address=192.168.11.20 block-access=yes comment="InPro Comm 2" mac-address=00:08:22:9A:C9:FB server=dhcp1
/ip dhcp-server lease add address=192.168.3.49 client-id=1:c0:74:ad:69:c9:9d comment="Ramal Grandstream " mac-address=C0:74:AD:69:C9:9D server=dhcp1
/ip dhcp-server lease add address=192.168.3.48 client-id=1:c0:74:ad:88:76:af comment="Ramal Grandstream 2" mac-address=C0:74:AD:88:76:AF server=dhcp1
/ip dhcp-server lease add address=192.168.10.7 client-id=1:90:32:4b:79:1e:99 comment="Notebook - Ana Laura" dhcp-option=DNS_Google mac-address=90:32:4B:79:1E:99 server=dhcp1
/ip dhcp-server lease add address=192.168.0.7 client-id=1:fa:3b:f7:8f:1c:95 comment=TSHK mac-address=FA:3B:F7:8F:1C:95 server=dhcp1
/ip dhcp-server lease add address=192.168.1.7 client-id=1:ee:a3:16:72:1f:d2 comment="TSRDP Admin" mac-address=EE:A3:16:72:1F:D2 server=dhcp1
/ip dhcp-server lease add address=192.168.0.4 client-id=ff:80:f0:32:d2:0:1:0:1:2c:ad:95:18:4e:1d:80:f0:32:d2 comment="FTP Themis BKP" dhcp-option=DNS_Google mac-address=4E:1D:80:F0:32:D2 server=dhcp1
/ip dhcp-server lease add address=192.168.3.153 client-id=1:c8:7f:54:d1:9c:75 comment="SRV Rack 1" mac-address=C8:7F:54:D1:9C:75 server=dhcp1
/ip dhcp-server lease add address=192.168.3.206 client-id=1:d8:5e:d3:f4:bc:af comment="Lider - Monitoramento" mac-address=D8:5E:D3:F4:BC:AF server=dhcp1
/ip dhcp-server lease add address=192.168.3.205 client-id=1:d8:5e:d3:f4:bc:86 comment=Projetista mac-address=D8:5E:D3:F4:BC:86 server=dhcp1
/ip dhcp-server lease add address=192.168.3.201 client-id=1:d8:5e:d3:f4:bc:ac comment="Rose - Monitoramento" mac-address=D8:5E:D3:F4:BC:AC server=dhcp1
/ip dhcp-server lease add address=192.168.3.202 client-id=1:d8:5e:d3:f3:b:db comment="Rose - Monitoramento" mac-address=D8:5E:D3:F3:0B:DB server=dhcp1
/ip dhcp-server lease add address=192.168.3.200 client-id=1:d8:5e:d3:f4:bc:bb comment="Ediclei - Eletronica" mac-address=D8:5E:D3:F4:BC:BB server=dhcp1
/ip dhcp-server lease add address=192.168.3.203 client-id=1:d8:5e:d3:f3:86:77 comment="Josely/Luana - Monitoramento" mac-address=D8:5E:D3:F3:86:77 server=dhcp1
/ip dhcp-server lease add address=192.168.3.204 client-id=1:d8:5e:d3:f4:bc:b5 comment="Josely/Luana - Monitoramento" mac-address=D8:5E:D3:F4:BC:B5 server=dhcp1
/ip dhcp-server lease add address=192.168.3.208 client-id=1:d8:5e:d3:f4:bc:b9 mac-address=D8:5E:D3:F4:BC:B9 server=dhcp1
/ip dhcp-server lease add address=192.168.3.207 client-id=1:d8:5e:d3:f3:86:6e mac-address=D8:5E:D3:F3:86:6E server=dhcp1
/ip dhcp-server lease add address=192.168.10.5 client-id=1:0:d7:6d:b4:7:44 comment="Dell Antonio" dhcp-option=DNS_Google mac-address=00:D7:6D:B4:07:44 server=dhcp1
/ip dhcp-server lease add address=192.168.3.34 comment="Guarita MG3000" mac-address=00:04:A3:31:A9:26 server=dhcp1
/ip dhcp-server lease add address=192.168.3.35 client-id=1:bc:9b:5e:9:fe:c comment="Leitora Facial" mac-address=BC:9B:5E:09:FE:0C server=dhcp1
/ip dhcp-server lease add address=192.168.6.126 client-id=1:d8:5e:d3:f5:96:6f comment="PC - Alessandro (Financeiro)" mac-address=D8:5E:D3:F5:96:6F server=dhcp1
/ip dhcp-server lease add address=192.168.7.110 comment="Ramal - 2011" mac-address=C8:1F:EA:7A:BF:22 server=dhcp1
/ip dhcp-server lease add address=192.168.6.142 client-id=1:fc:aa:14:f5:43:17 comment="PC - Isabele (Recrutamento)" mac-address=FC:AA:14:F5:43:17 server=dhcp1
/ip dhcp-server lease add address=192.168.7.111 comment="Ramal - 2001" mac-address=C8:1F:EA:7A:BE:54 server=dhcp1
/ip dhcp-server lease add address=192.168.7.112 comment="Ramal - 2003" mac-address=C8:1F:EA:8B:DF:65 server=dhcp1
/ip dhcp-server lease add address=192.168.7.113 comment="Ramal - 2002" mac-address=C8:1F:EA:7A:B6:B2 server=dhcp1
/ip dhcp-server lease add address=192.168.7.114 comment="Ramal - 2004" mac-address=C8:1F:EA:8B:E2:DB server=dhcp1
/ip dhcp-server lease add address=192.168.7.115 comment="Ramal - 2000" mac-address=C8:1F:EA:8B:E6:3F server=dhcp1
/ip dhcp-server lease add address=192.168.3.23 client-id=1:18:d:2c:34:6e:5c comment="DVR Selecao" mac-address=18:0D:2C:34:6E:5C server=dhcp1
/ip dhcp-server lease add address=192.168.5.12 client-id=1:70:4f:57:76:db:23 comment="(Recrutamento) SSID: WifiAlb5\r\
    \nSenha: @lbatr0z12345\r\
    \n\r\
    \nuser: admin\r\
    \nsenha:4lb4tr0z\r\
    \n\r\
    \nAcesso remoto na porta 8080" dhcp-option=DNS_Google mac-address=70:4F:57:76:DB:23 server=dhcp1
/ip dhcp-server lease add address=192.168.7.116 comment="Ramal - 2005" mac-address=C8:1F:EA:8B:DF:53 server=dhcp1
/ip dhcp-server lease add address=192.168.3.24 client-id=1:d8:77:8b:fe:e:49 comment="DVR Almoxarifado" mac-address=D8:77:8B:FE:0E:49 server=dhcp1
/ip dhcp-server lease add address=192.168.3.36 client-id=1:bc:9b:5e:1e:69:d6 comment="Reconhecimento Facial - Almoxarifado" mac-address=BC:9B:5E:1E:69:D6 server=dhcp1
/ip dhcp-server lease add address=192.168.3.146 block-access=yes mac-address=D8:36:5F:5E:63:C0 server=dhcp1
/ip dhcp-server lease add address=192.168.1.2 client-id=ff:11:fa:4e:7b:0:1:0:1:2d:c2:94:68:bc:24:11:ad:bb:ea comment="Uatu - SNMP (Observium)" dhcp-option=DNS_Google mac-address=BC:24:11:FA:4E:7B server=dhcp1
/ip dhcp-server lease add address=192.168.10.51 client-id=1:74:56:3c:fb:68:4e comment="PC - Leandro (Diretoria)" dhcp-option=DNS_Google mac-address=74:56:3C:FB:68:4E server=dhcp1
/ip dhcp-server lease add address=192.168.3.150 client-id=1:74:56:3c:fb:64:44 comment="Srv Dguard  (Eletronica)" mac-address=74:56:3C:FB:64:44 server=dhcp1
/ip dhcp-server lease add address=192.168.10.16 client-id=1:50:eb:f6:37:a9:9a comment="PC - TI1 (Antonio)" dhcp-option=DNS_Google mac-address=50:EB:F6:37:A9:9A server=dhcp1
/ip dhcp-server lease add address=192.168.3.155 client-id=1:d8:5e:d3:f4:f7:66 comment="SRV Rack 5" mac-address=D8:5E:D3:F4:F7:66 server=dhcp1
/ip dhcp-server lease add address=192.168.3.156 client-id=1:d8:5e:d3:f4:f7:5a comment="SRV Rack 6" mac-address=D8:5E:D3:F4:F7:5A server=dhcp1
/ip dhcp-server lease add address=192.168.3.47 client-id=1:30:e1:f1:1b:99:80 comment="Ramal Intelbras (Portaria Remota)" mac-address=30:E1:F1:1B:99:80 server=dhcp1
/ip dhcp-server lease add address=192.168.7.108 comment="Ramal - 2156" mac-address=C8:1F:EA:8B:E4:9C server=dhcp1
/ip dhcp-server lease add address=192.168.1.4 client-id=1:0:a:f7:64:6:d1 comment="TeamNIC HK" dhcp-option=DNS_Google mac-address=00:0A:F7:64:06:D1 server=dhcp1
/ip dhcp-server lease add address=192.168.1.5 client-id=1:f8:bc:12:55:63:0 comment="HK Admin" dhcp-option=DNS_Google mac-address=F8:BC:12:55:63:00 server=dhcp1
/ip dhcp-server lease add address=192.168.1.10 client-id=1:f8:bc:12:55:63:2 comment=SUP mac-address=F8:BC:12:55:63:02 server=dhcp1
/ip dhcp-server lease add address=192.168.7.118 comment="Ramal - 2282" mac-address=C8:1F:EA:8B:E3:35 server=dhcp1
/ip dhcp-server lease add address=192.168.4.17 client-id=1:58:38:79:a6:4d:25 comment="Impressora TI" mac-address=58:38:79:A6:4D:25 server=dhcp1
/ip dhcp-server lease add address=192.168.3.147 block-access=yes mac-address=D8:36:5F:5E:63:DC server=dhcp1
/ip dhcp-server lease add address=192.168.6.161 client-id=1:3c:84:6a:cc:52:b1 comment="PC - Conferencia COPA" mac-address=3C:84:6A:CC:52:B1 server=dhcp1
/ip dhcp-server lease add address=192.168.7.119 comment="Sala de Reuniao Operacional" mac-address=C8:1F:EA:8D:7D:17 server=dhcp1
/ip dhcp-server lease add address=192.168.6.18 client-id=1:bc:5f:f4:dd:68:bf comment="PC - Maquina 10 (Operacional)" mac-address=BC:5F:F4:DD:68:BF server=dhcp1
/ip dhcp-server lease add address=192.168.4.10 client-id=1:58:38:79:a6:48:32 comment="Impressora ComPriv" mac-address=58:38:79:A6:48:32 server=dhcp1
/ip dhcp-server lease add address=192.168.4.23 client-id=1:58:38:79:b2:22:73 comment="Impressora Contratos" mac-address=58:38:79:B2:22:73 server=dhcp1
/ip dhcp-server lease add address=192.168.4.14 client-id=1:58:38:79:ab:bb:28 comment="Impressora Contabilidade" mac-address=58:38:79:AB:BB:28 server=dhcp1
/ip dhcp-server lease add address=192.168.4.29 client-id=1:58:38:79:b2:14:77 comment="Impressora ComPub" mac-address=58:38:79:B2:14:77 server=dhcp1
/ip dhcp-server lease add address=192.168.4.20 client-id=1:58:38:79:b2:22:84 comment="Impressora Secretaria Diretoria" mac-address=58:38:79:B2:22:84 server=dhcp1
/ip dhcp-server lease add address=192.168.4.21 client-id=1:58:38:79:ad:11:56 comment="Impressora Suprimentos" mac-address=58:38:79:AD:11:56 server=dhcp1
/ip dhcp-server lease add address=192.168.4.11 client-id=1:58:38:79:ac:de:74 comment="Impressora Arquivo" mac-address=58:38:79:AC:DE:74 server=dhcp1
/ip dhcp-server lease add address=192.168.4.19 client-id=1:58:38:79:a6:49:1a comment="Impressora Arcolimp" mac-address=58:38:79:A6:49:1A server=dhcp1
/ip dhcp-server lease add address=192.168.4.31 client-id=1:58:38:79:4a:da:d5 comment="Impressora Faturamento/Financeiro" mac-address=58:38:79:4A:DA:D5 server=dhcp1
/ip dhcp-server lease add address=192.168.4.30 client-id=1:58:38:79:a6:48:21 comment="Impressora JurTrab" mac-address=58:38:79:A6:48:21 server=dhcp1
/ip dhcp-server lease add address=192.168.4.16 client-id=1:58:38:79:b2:13:a3 comment="Impressora Plantao" mac-address=58:38:79:B2:13:A3 server=dhcp1
/ip dhcp-server lease add address=192.168.4.22 client-id=1:58:38:79:b2:4a:40 comment="Impressora Operacional" mac-address=58:38:79:B2:4A:40 server=dhcp1
/ip dhcp-server lease add address=192.168.4.32 client-id=1:58:38:79:ac:de:be comment="Impressora Gerencia Operacional" mac-address=58:38:79:AC:DE:BE server=dhcp1
/ip dhcp-server lease add address=192.168.0.11 client-id=ff:11:94:43:2:0:1:0:1:2f:ab:5d:d8:bc:24:11:94:43:2 comment=ZZTOOLS mac-address=BC:24:11:94:43:02 server=dhcp1
/ip dhcp-server lease add address=192.168.4.28 client-id=1:58:38:79:b2:4a:2 comment="Impressora Recrutamento" mac-address=58:38:79:B2:4A:02 server=dhcp1
/ip dhcp-server lease add address=192.168.4.13 client-id=1:58:38:79:ab:b0:3b comment="Impressora Apoio" mac-address=58:38:79:AB:B0:3B server=dhcp1
/ip dhcp-server lease add address=192.168.4.18 client-id=1:58:38:79:ab:bb:35 comment="Impressora Almoxarifado" mac-address=58:38:79:AB:BB:35 server=dhcp1
/ip dhcp-server lease add address=192.168.4.27 client-id=1:58:38:79:b2:2b:47 comment="Impressora Monitoramento" mac-address=58:38:79:B2:2B:47 server=dhcp1
/ip dhcp-server lease add address=192.168.4.25 client-id=1:58:38:79:ab:bb:2b comment="Impressora Armamento" mac-address=58:38:79:AB:BB:2B server=dhcp1
/ip dhcp-server lease add address=192.168.4.24 client-id=1:58:38:79:b2:2b:7b comment="Impressora Controladoria" mac-address=58:38:79:B2:2B:7B server=dhcp1
/ip dhcp-server lease add address=192.168.4.26 client-id=1:58:38:79:57:20:40 comment="Impressora DP IM8000" mac-address=58:38:79:57:20:40 server=dhcp1
/ip dhcp-server lease add address=192.168.4.33 client-id=1:58:38:79:66:a:92 comment="Impressora Gerencia Financeira" mac-address=58:38:79:66:0A:92 server=dhcp1
/ip dhcp-server lease add address=192.168.4.12 client-id=1:58:38:79:a6:4d:1e comment="Impressora DP IM460" mac-address=58:38:79:A6:4D:1E server=dhcp1
/ip dhcp-server lease add address=192.168.6.12 client-id=1:10:ff:e0:68:df:c7 comment="PC - Maquina 4 (Operacional)" mac-address=10:FF:E0:68:DF:C7 server=dhcp1
/ip dhcp-server lease add address=192.168.6.11 client-id=1:cc:28:aa:36:f8:33 comment="PC - Maquina 3 (Operacional)" mac-address=CC:28:AA:36:F8:33 server=dhcp1
/ip dhcp-server lease add address=192.168.6.7 client-id=1:10:ff:e0:68:de:cc comment="PC - Thalita (Disciplina)" mac-address=10:FF:E0:68:DE:CC server=dhcp1
/ip dhcp-server lease add address=192.168.6.2 client-id=1:10:ff:e0:68:df:fa comment="PC - Bruno (Coord. Priv.)" dhcp-option=DNS_Google mac-address=10:FF:E0:68:DF:FA server=dhcp1
/ip dhcp-server lease add address=192.168.6.10 client-id=1:10:ff:e0:69:5a:54 comment="PC - Maquina 2 (Operacional)" mac-address=10:FF:E0:69:5A:54 server=dhcp1
/ip dhcp-server lease add address=192.168.6.20 client-id=1:cc:28:aa:36:f7:b1 comment="PC - Maquina 12 (Operacional)" mac-address=CC:28:AA:36:F7:B1 server=dhcp1
/ip dhcp-server lease add address=192.168.6.13 client-id=1:10:ff:e0:69:5e:24 comment="PC - Maquina 5 (Operacional)" mac-address=10:FF:E0:69:5E:24 server=dhcp1
/ip dhcp-server lease add address=192.168.6.23 client-id=1:10:ff:e0:68:db:2b comment="PC - Plantao Operacional 1 (Ronaldo)" mac-address=10:FF:E0:68:DB:2B server=dhcp1
/ip dhcp-server lease add address=192.168.6.24 client-id=1:10:ff:e0:69:5e:28 comment="PC - Plantao Operacional 2 (Wellington)" mac-address=10:FF:E0:69:5E:28 server=dhcp1
/ip dhcp-server lease add address=192.168.6.148 client-id=1:d0:17:c2:8e:66:e6 comment="PC - JA (Recrutamento)" mac-address=D0:17:C2:8E:66:E6 server=dhcp1
/ip dhcp-server lease add address=192.168.7.19 comment="Ramal - 2183" mac-address=C8:1F:EA:8F:53:54 server=dhcp1
/ip dhcp-server lease add address=192.168.6.129 client-id=1:3c:84:6a:cc:53:53 comment="PC - WinXP (Financeiro)" mac-address=3C:84:6A:CC:53:53 server=dhcp1
/ip dhcp-server lease add address=192.168.6.32 client-id=1:bc:fc:e7:64:0:d6 comment="PC - Rafael (Controladoria)" mac-address=BC:FC:E7:64:00:D6 server=dhcp1
/ip dhcp-server lease add address=192.168.6.30 client-id=1:bc:fc:e7:64:0:f5 comment="PC - Robson (Controladoria)" mac-address=BC:FC:E7:64:00:F5 server=dhcp1
/ip dhcp-server lease add address=192.168.6.31 client-id=1:bc:fc:e7:65:69:2e comment="PC - Douglas (Controladoria)" mac-address=BC:FC:E7:65:69:2E server=dhcp1
/ip dhcp-server lease add address=192.168.6.22 client-id=1:bc:fc:e7:65:69:b1 comment="PC - Ponto Eletronico" mac-address=BC:FC:E7:65:69:B1 server=dhcp1
/ip dhcp-server lease add address=192.168.6.9 client-id=1:70:4d:7b:cf:9:fd comment="PC - Maquina 1 (Operacional)" mac-address=70:4D:7B:CF:09:FD server=dhcp1
/ip dhcp-server lease add address=192.168.1.12 client-id=ff:b6:22:f:eb:0:2:0:0:ab:11:17:e5:bb:94:63:76:da:c4 comment="Odin ALL SHARE" dhcp-option=DNS_Google mac-address=78:2B:CB:55:8C:4E server=dhcp1
/ip dhcp-server lease add address=192.168.0.99 client-id=ff:11:a1:5e:31:0:1:0:1:30:1c:c6:6e:bc:24:11:a1:5e:31 comment=PiHole dhcp-option=DNS_Google mac-address=BC:24:11:A1:5E:31 server=dhcp1
/ip dhcp-server lease add address=192.168.0.12 client-id=ff:cb:39:a:c7:0:2:0:0:ab:11:21:9:3c:9e:cd:93:3:66 comment="Mimir (NFS DR)" mac-address=44:87:FC:E4:A0:19 server=dhcp1
/ip dhcp-server lease add address=192.168.6.19 client-id=1:bc:fc:e7:64:0:e2 comment="PC - Maquina 11 (Operacional)" mac-address=BC:FC:E7:64:00:E2 server=dhcp1
/ip dhcp-server lease add address=192.168.6.104 client-id=1:10:ff:e0:f1:f2:89 comment="PC - Isabel (JurTrab)" mac-address=10:FF:E0:F1:F2:89 server=dhcp1
/ip dhcp-server lease add address=192.168.6.45 client-id=1:10:ff:e0:f1:f2:da comment="PC - Karina (Compras)" mac-address=10:FF:E0:F1:F2:DA server=dhcp1
/ip dhcp-server lease add address=192.168.6.46 client-id=1:10:ff:e0:f1:f2:87 comment="PC - Artur (Compras)" dhcp-option=DNS_Google mac-address=10:FF:E0:F1:F2:87 server=dhcp1
/ip dhcp-server lease add address=192.168.6.47 client-id=1:10:ff:e0:9a:6f:4 comment="PC - Felipy (Frota)" mac-address=10:FF:E0:9A:6F:04 server=dhcp1
/ip dhcp-server lease add address=192.168.6.48 client-id=1:10:ff:e0:f1:f2:86 comment="PC - Juliano (Frota)" mac-address=10:FF:E0:F1:F2:86 server=dhcp1
/ip dhcp-server lease add address=192.168.6.147 client-id=1:d8:5e:d3:f3:1f:18 comment="PC - Rhaisa (Recrutamento)" mac-address=D8:5E:D3:F3:1F:18 server=dhcp1
/ip dhcp-server lease add address=192.168.10.18 client-id=1:80:3f:5d:f5:63:e9 comment="Notebook - Antonio" dhcp-option=DNS_Google mac-address=80:3F:5D:F5:63:E9 server=dhcp1
/ip dhcp-server lease add address=192.168.6.136 client-id=1:10:ff:e0:9c:a:bb comment="PC - Erika Malagutti (Contratos)" mac-address=10:FF:E0:9C:0A:BB server=dhcp1
/ip dhcp-server lease add address=192.168.0.15 client-id=ff:f6:e9:f4:45:0:1:0:1:30:63:f3:b1:34:97:f6:e9:f4:45 comment="SIFU - (Samba pra emergencias)" mac-address=34:97:F6:E9:F4:45 server=dhcp1
/ip dhcp-server lease add address=192.168.10.1 client-id=ff:11:b6:9a:7b:0:1:0:1:30:64:45:3f:bc:24:11:b6:9a:7b comment="Bifrost (VPN Server)" mac-address=BC:24:11:B6:9A:7B server=dhcp1
/ip dhcp-server lease add address=192.168.0.8 client-id=ff:11:a9:46:3:0:1:0:1:30:2c:b6:9e:bc:24:11:a9:46:2 comment="NXavier - Samba ADMIN" mac-address=BC:24:11:A9:46:03 server=dhcp1
/ip dhcp-server lease add address=192.168.6.150 client-id=1:10:ff:e0:f1:f4:ab comment="Almox1 - Fabiana" mac-address=10:FF:E0:F1:F4:AB server=dhcp1
/ip dhcp-server lease add address=192.168.6.151 client-id=1:10:ff:e0:f1:f5:4 comment="Almox2 - Giovany" mac-address=10:FF:E0:F1:F5:04 server=dhcp1
/ip dhcp-server lease add address=192.168.9.200 client-id=1:d0:94:66:e6:38:22 comment="PC - Thays (Plena Saude)" mac-address=D0:94:66:E6:38:22 server=dhcp1
/ip dhcp-server lease add address=192.168.3.225 client-id=1:98:e5:5b:a7:8f:54 comment="NVD 1404 (Torre1)" mac-address=98:E5:5B:A7:8F:54 server=dhcp1
/ip dhcp-server lease add address=192.168.3.231 comment="Antena SmartSampa (Eduardo) - Externa" mac-address=98:E5:5B:A7:99:D9 server=dhcp1
/ip dhcp-server lease add address=192.168.3.229 client-id=1:98:2a:a:5b:c4:b2 comment="Camera 4 (Torre1)" mac-address=98:2A:0A:5B:C4:B2 server=dhcp1
/ip dhcp-server lease add address=192.168.3.227 client-id=1:98:2a:a:5b:c4:c comment="Camera 2 (Torre1)" mac-address=98:2A:0A:5B:C4:0C server=dhcp1
/ip dhcp-server lease add address=192.168.3.230 comment="Antena SmartSampa (Eduardo) - Interna" mac-address=98:E5:5B:A7:99:D2 server=dhcp1
/ip dhcp-server lease add address=192.168.3.228 client-id=1:98:2a:a:5b:c5:8a comment="Camera 3 (Torre 1)" mac-address=98:2A:0A:5B:C5:8A server=dhcp1
/ip dhcp-server lease add address=192.168.3.226 client-id=1:98:2a:a:5b:c4:49 comment="Camera 1 (Torre 1)" mac-address=98:2A:0A:5B:C4:49 server=dhcp1
/ip dhcp-server lease add address=192.168.3.241 comment="Antena SmartSampa (Tiradentes) -Externa" mac-address=98:E5:5B:A7:99:29 server=dhcp1
/ip dhcp-server lease add address=192.168.3.240 comment="Antena SmartSampa (Tiradentes) - Interna" mac-address=98:E5:5B:A7:99:30 server=dhcp1
/ip dhcp-server lease add address=192.168.3.235 client-id=1:98:e5:5b:a7:8f:55 comment="NVD 1404 (Torre 2)" mac-address=98:E5:5B:A7:8F:55 server=dhcp1
/ip dhcp-server lease add address=192.168.3.238 client-id=1:98:2a:a:5b:c4:bf comment="Camera 3 (Torre 2)" mac-address=98:2A:0A:5B:C4:BF server=dhcp1
/ip dhcp-server lease add address=192.168.3.236 client-id=1:98:2a:a:5b:c4:d2 comment="Camera 1 (Torre 2)" mac-address=98:2A:0A:5B:C4:D2 server=dhcp1
/ip dhcp-server lease add address=192.168.3.239 client-id=1:98:2a:a:5b:c5:b1 comment="Camera 4 (Torre 2)" mac-address=98:2A:0A:5B:C5:B1 server=dhcp1
/ip dhcp-server lease add address=192.168.3.237 client-id=1:98:2a:a:5b:c5:63 comment="Camera 2 (Torre 2)" mac-address=98:2A:0A:5B:C5:63 server=dhcp1
/ip dhcp-server lease add address=192.168.10.110 client-id=ff:11:a7:d:bc:0:1:0:1:30:79:5b:5a:bc:24:11:69:26:ef dhcp-option=DNS_Google mac-address=BC:24:11:A7:0D:BC server=dhcp1
/ip dhcp-server lease add address=192.168.3.81 comment="Camera Armamento 1" mac-address=00:1A:3F:60:00:1D server=dhcp1
/ip dhcp-server lease add address=192.168.3.82 client-id=1:44:19:b6:57:65:11 comment="Camera Auditorio Opera (DVR1)" mac-address=44:19:B6:57:65:11 server=dhcp1
/ip dhcp-server lease add address=192.168.3.14 client-id=1:24:fd:d:27:bd:e8 comment="DVR com as cameras mascaradas" mac-address=24:FD:0D:27:BD:E8 server=dhcp1
/ip dhcp-server lease add address=192.168.3.80 client-id=1:0:18:ae:5e:bc:66 comment="Camera Armamento 2" mac-address=00:18:AE:5E:BC:66 server=dhcp1
/ip dhcp-server lease add address=192.168.3.15 client-id=1:d8:77:8b:fe:12:9e comment="DVR1 24 cameras" mac-address=D8:77:8B:FE:12:9E server=dhcp1
/ip dhcp-server lease add address=192.168.3.83 client-id=1:0:18:ae:5f:c2:9b comment="Camera Armamento 3" mac-address=00:18:AE:5F:C2:9B server=dhcp1
/ip dhcp-server lease add address=192.168.3.92 client-id=1:0:18:ae:5e:bf:66 mac-address=00:18:AE:5E:BF:66 server=dhcp1
/ip dhcp-server lease add address=192.168.3.84 client-id=1:0:18:ae:5f:c2:3c mac-address=00:18:AE:5F:C2:3C server=dhcp1
/ip dhcp-server lease add address=192.168.3.85 client-id=1:44:19:b6:54:97:c9 comment="(DVR1)" mac-address=44:19:B6:54:97:C9 server=dhcp1
/ip dhcp-server lease add address=192.168.3.86 client-id=1:44:19:b6:57:64:c7 comment="(DVR1)" mac-address=44:19:B6:57:64:C7 server=dhcp1
/ip dhcp-server lease add address=192.168.3.87 client-id=1:44:19:b6:57:65:1f comment="(DVR1)" mac-address=44:19:B6:57:65:1F server=dhcp1
/ip dhcp-server lease add address=192.168.3.88 client-id=1:44:19:b6:57:65:71 comment="(DVR1)" mac-address=44:19:B6:57:65:71 server=dhcp1
/ip dhcp-server lease add address=192.168.3.89 client-id=1:44:19:b6:57:65:b5 comment="(DVR1)" mac-address=44:19:B6:57:65:B5 server=dhcp1
/ip dhcp-server lease add address=192.168.3.90 client-id=1:44:19:b6:57:63:f4 comment="(DVR1)" mac-address=44:19:B6:57:63:F4 server=dhcp1
/ip dhcp-server lease add address=192.168.3.91 client-id=1:44:19:b6:57:63:eb comment="(DVR1)" mac-address=44:19:B6:57:63:EB server=dhcp1
/ip dhcp-server lease add address=192.168.3.93 client-id=1:58:10:8c:7a:40:f3 comment="(DVR1)" mac-address=58:10:8C:7A:40:F3 server=dhcp1
/ip dhcp-server lease add address=192.168.3.94 client-id=1:44:19:b6:54:97:af comment="(DVR2)" mac-address=44:19:B6:54:97:AF server=dhcp1
/ip dhcp-server lease add address=192.168.3.234 client-id=1:a4:d5:c2:29:a1:1f comment="Interfone Tiradentes" mac-address=A4:D5:C2:29:A1:1F server=dhcp1
/ip dhcp-server lease add address=192.168.3.242 client-id=1:d8:36:5f:ba:5c:82 comment="telefone voip v5501" mac-address=D8:36:5F:BA:5C:82 server=dhcp1
/ip dhcp-server lease add address=192.168.3.9 comment="Placa 2 do DVR Alb2" mac-address=00:1A:3F:3C:63:06 server=dhcp1
/ip dhcp-server lease add address=192.168.3.95 client-id=1:58:10:8c:7a:40:f4 comment="(DVR2)" mac-address=58:10:8C:7A:40:F4 server=dhcp1
/ip dhcp-server lease add address=192.168.3.96 comment=" (DVR2)" mac-address=00:1A:3F:64:6F:1C server=dhcp1
/ip dhcp-server lease add address=192.168.3.97 comment=" (DVR2)" mac-address=00:1A:3F:64:6F:1E server=dhcp1
/ip dhcp-server lease add address=192.168.3.98 comment=" (DVR2)" mac-address=00:1A:3F:64:6F:16 server=dhcp1
/ip dhcp-server lease add address=192.168.3.99 client-id=1:44:19:b6:56:b6:1e comment=" (DVR2)" mac-address=44:19:B6:56:B6:1E server=dhcp1
/ip dhcp-server lease add address=192.168.3.100 client-id=1:44:19:b6:57:65:70 comment=" (DVR2)" mac-address=44:19:B6:57:65:70 server=dhcp1
/ip dhcp-server lease add address=192.168.3.101 client-id=1:44:19:b6:56:b6:31 mac-address=44:19:B6:56:B6:31 server=dhcp1
/ip dhcp-server lease add address=192.168.3.102 client-id=1:44:19:b6:57:64:16 mac-address=44:19:B6:57:64:16 server=dhcp1
/ip dhcp-server lease add address=192.168.3.232 client-id=1:a4:d5:c2:65:c3:53 comment="Interfone Eduardo Chaves" mac-address=A4:D5:C2:65:C3:53 server=dhcp1
/ip dhcp-server lease add address=192.168.3.71 client-id=1:98:2a:a:6e:af:db comment="Catraca Facial - Entrada" mac-address=98:2A:0A:6E:AF:DB server=dhcp1
/ip dhcp-server lease add address=192.168.3.70 client-id=1:98:2a:a:6e:b3:23 comment="Catraca Facial - Saida" mac-address=98:2A:0A:6E:B3:23 server=dhcp1
/ip dhcp-server lease add address=192.168.1.8 client-id=ff:11:15:57:67:0:1:0:1:30:2c:b6:9e:bc:24:11:a9:46:2 comment="NXavier - Samba Acesso" mac-address=BC:24:11:15:57:67 server=dhcp1
/ip dhcp-server lease add address=192.168.1.14 comment=Stirling mac-address=BC:24:11:8F:2C:9D server=dhcp1
/ip dhcp-server lease add address=192.168.3.103 block-access=yes client-id=1:8:97:98:c0:4:b2 comment="Teste Note Ediclei" dhcp-option=DNS_Google mac-address=08:97:98:C0:04:B2 server=dhcp1
/ip dhcp-server lease add address=192.168.1.15 comment="Guaca - Pepe" dhcp-option=DNS_Google mac-address=BC:24:11:24:39:BE server=dhcp1
/ip dhcp-server lease add address=192.168.1.16 client-id=ff:74:9:e9:13:0:2:0:0:ab:11:d5:94:3c:83:94:3b:78:f9 comment="Docker - Cloudflared Zerotrust" dhcp-option=DNS_Google mac-address=02:42:FB:E2:E1:C7 server=dhcp1
/ip dhcp-server lease add address=192.168.5.9 client-id=1:d8:d:17:c6:83:e9 comment="(Diretoria) SSID: WifiAlb2\
    \nSenha: @lbatr0z12345\
    \n\
    \nSSID WiFi Visitante\
    \nSenha A1l2b3a4\
    \n\
    \nuser: admin\
    \nsenha: 4lb4tr0z\
    \n\
    \nIPWAN: 192.168.5.9\
    \nIPLAN: 192.168.150.1\
    \nDHCP: 150.100 - 150.120\
    \n\
    \nAcesso remoto na porta 8080" dhcp-option=DNS_Google mac-address=D8:0D:17:C6:83:E9 server=dhcp1
/ip dhcp-server lease add address=192.168.5.11 client-id=1:c4:e9:a:e0:aa:c0 comment="(Financeiro)SSID: WifiAlb1\r\
    \nSenha: @lb4tr0z12345\r\
    \n\r\
    \nuser: admin\r\
    \nsenha:4lb4tr0z\r\
    \n\r\
    \nIPWAN: 192.168.5.11\r\
    \nIPLAN: 192.168.150.1\r\
    \nDHCP: 150.100 - 150.120\r\
    \n\r\
    \nAcesso remoto na porta 8080" dhcp-option=DNS_Google mac-address=C4:E9:0A:E0:AA:C0 server=dhcp1
/ip dhcp-server lease add address=192.168.0.5 client-id=ff:11:28:d5:e3:0:1:0:1:30:62:25:17:bc:24:11:da:fc:67 comment="Files DR" dhcp-option=DNS_Google mac-address=BC:24:11:28:D5:E3 server=dhcp1
/ip dhcp-server lease add address=192.168.10.2 client-id=1:b0:4a:b4:a8:a9:cd dhcp-option=DNS_Google mac-address=B0:4A:B4:A8:A9:CD server=dhcp1
/ip dhcp-server lease add address=192.168.6.93 client-id=1:30:56:f:19:7a:73 comment="PC - Roger (ComPub)" mac-address=30:56:0F:19:7A:73 server=dhcp1
/ip dhcp-server lease add address=192.168.6.59 client-id=1:30:56:f:19:7a:78 comment="PC - Bianca (Arcolimp)" mac-address=30:56:0F:19:7A:78 server=dhcp1
/ip dhcp-server lease add address=192.168.6.57 client-id=1:30:56:f:19:80:18 comment="PC - Daniel (Arcolimp)" dhcp-option=DNS_Google mac-address=30:56:0F:19:80:18 server=dhcp1
/ip dhcp-server lease add address=192.168.6.144 client-id=1:30:56:f:19:79:b3 comment="PC - Quiteria (Recrutamento)" mac-address=30:56:0F:19:79:B3 server=dhcp1
/ip dhcp-server lease add address=192.168.6.143 client-id=1:30:56:f:19:81:72 comment="PC - Liliane (Recrutamento)" mac-address=30:56:0F:19:81:72 server=dhcp1
/ip dhcp-server lease add address=192.168.6.34 client-id=1:30:56:f:19:7a:72 comment="PC - Roberta (Armamento)" mac-address=30:56:0F:19:7A:72 server=dhcp1
/ip dhcp-server lease add address=192.168.6.128 client-id=1:30:56:f:19:80:9c comment="PC - Osmar (Financeiro)" mac-address=30:56:0F:19:80:9C server=dhcp1
/ip dhcp-server lease add address=192.168.6.36 client-id=1:30:56:f:19:81:67 comment="PC - Gisele (Armamento)" mac-address=30:56:0F:19:81:67 server=dhcp1
/ip dhcp-server lease add address=192.168.6.21 client-id=1:9c:6b:0:50:bb:37 comment="Nova Catraca" mac-address=9C:6B:00:50:BB:37 server=dhcp1
/ip dhcp-server lease add address=192.168.6.146 client-id=1:30:56:f:19:81:dc comment="PC - Recepcao (Recrutamento)" mac-address=30:56:0F:19:81:DC server=dhcp1
/ip dhcp-server lease add address=192.168.10.8 client-id=1:a0:ad:9f:b7:4:53 comment="PC - Dra. Rosely (Novo)" dhcp-option=DNS_Google mac-address=A0:AD:9F:B7:04:53 server=dhcp1
/ip dhcp-server lease add address=192.168.6.79 client-id=1:fc:9d:5:25:77:56 comment="PC - Amanda (Contigenciamento)" mac-address=FC:9D:05:25:77:56 server=dhcp1
/ip dhcp-server lease add address=192.168.10.4 client-id=1:44:1c:7f:5a:9b:75 comment="Cel 2 antonio" dhcp-option=DNS_Google mac-address=44:1C:7F:5A:9B:75 server=dhcp1
/ip dhcp-server lease add address=192.168.10.123 client-id=1:48:da:35:6f:3b:4 comment=NanoKVM dhcp-option=DNS_Google mac-address=48:DA:35:6F:3B:04 server=dhcp1
/ip dhcp-server lease add address=192.168.10.3 client-id=1:94:46:96:8f:47:88 comment="Wifi Alb4" dhcp-option=DNS_Google mac-address=94:46:96:8F:47:88 server=dhcp1
/ip dhcp-server lease add address=192.168.10.114 comment="Skull Test" dhcp-option=DNS_Google mac-address=E0:D5:5E:F6:93:D2 server=dhcp1
/ip dhcp-server lease add address=192.168.10.109 client-id=ff:11:1b:c5:d2:0:1:0:1:30:76:89:2d:bc:24:11:42:53:2e dhcp-option=DNS_Google mac-address=BC:24:11:1B:C5:D2 server=dhcp1
/ip dhcp-server lease add address=192.168.3.154 client-id=1:30:56:f:68:68:35 comment="SRV Rack 2" dhcp-option=DNS_Google mac-address=30:56:0F:68:68:35 server=dhcp1
/ip dhcp-server lease add address=192.168.10.17 comment="Suporte (TI2)" dhcp-option=DNS_Google mac-address=10:FF:E0:F1:F5:52 server=dhcp1
/ip dhcp-server lease add address=192.168.10.102 client-id=1:bc:24:11:18:86:dc dhcp-option=DNS_Google mac-address=BC:24:11:18:86:DC server=dhcp1
/ip dhcp-server lease add address=192.168.10.101 dhcp-option=DNS_Google mac-address=BC:24:11:B2:4E:BB server=dhcp1
/ip dhcp-server lease add address=192.168.10.64 client-id=1:bc:24:11:db:c3:66 mac-address=BC:24:11:DB:C3:66 server=dhcp1
/ip dhcp-server lease add address=192.168.10.106 client-id=1:c8:7f:54:d1:9e:f dhcp-option=DNS_Google mac-address=C8:7F:54:D1:9E:0F server=dhcp1
/ip dhcp-server lease add address=192.168.10.111 comment=Marston dhcp-option=DNS_Google mac-address=E0:D5:5E:F6:90:C6 server=dhcp1
/ip dhcp-server lease add address=192.168.10.91 client-id=1:bc:24:11:e4:30:28 dhcp-option=DNS_Google mac-address=BC:24:11:E4:30:28 server=dhcp1
/ip dhcp-server network add address=192.168.0.0/20 comment=defconf dhcp-option=option-242 dns-server=192.168.0.99,192.168.0.99 gateway=192.168.1.1 netmask=20
/ip dns set servers=8.8.8.8,1.1.1.1,9.9.9.9
/ip dns static add address=192.168.1.1 comment=defconf name=router.lan type=A
/ip firewall address-list add address=192.168.11.0/24 list=bloqued
/ip firewall address-list add address=192.168.3.0/24 comment="Devices da eletronica" list=eletronica
/ip firewall address-list add address=192.168.1.64/26 comment="Quem recebe DHCP" list=DHCP
/ip firewall address-list add address=192.168.3.224/27 comment="Poibir postes de sair pra internet" list=Postes
/ip firewall filter add action=log chain=forward comment="Regra pra testar acesso a ips especificos externos.   Ver em log o resultado ao tentar conectar" disabled=yes dst-address=201.6.246.107 log-prefix=TESTE_DVR
/ip firewall filter add action=accept chain=input comment=HydraVPN dst-port=1105 in-interface=HydraVPN protocol=udp
/ip firewall filter add action=accept chain=input comment="Monitoramento VPN ORACLE" protocol=icmp src-address=137.131.153.213
/ip firewall filter add action=fasttrack-connection chain=forward comment="ativar se uso de cpu aumentar ou velocidade cair" connection-state=established,related disabled=yes
/ip firewall filter add action=drop chain=input comment="200.143.179.66 OLD DC DROP" src-address=200.143.179.66
/ip firewall filter add action=drop chain=input comment="179.190.40.61 OLD DC DROP (27/10)" src-address=179.190.40.61
/ip firewall filter add action=drop chain=input comment="177.185.15.202 OLD DC DROP (27/10)" src-address=177.185.15.202
/ip firewall filter add action=drop chain=input comment="Drop de SSH" dst-port=22 log=yes log-prefix="Tentativa de Invasao Telnet/SSH - " protocol=tcp src-address=!192.168.0.0/20
/ip firewall filter add action=drop chain=forward comment="FULL DROP - Postes" disabled=yes src-address-list=Postes
/ip firewall filter add action=drop chain=input comment="FULL DROP - Postes" disabled=yes src-address-list=Postes
/ip firewall filter add action=drop chain=output comment="FULL DROP - Postes" disabled=yes src-address-list=Postes
/ip firewall filter add action=drop chain=forward comment="FULL DROP - DHCP" src-address-list=DHCP
/ip firewall filter add action=drop chain=input comment="FULL DROP - DHCP" src-address-list=DHCP
/ip firewall filter add action=drop chain=output comment="FULL DROP - DHCP" src-address-list=DHCP
/ip firewall filter add action=drop chain=forward comment="FULL FUCKING WHOLE DROP !!!!" src-address-list=bloqued
/ip firewall filter add action=drop chain=input comment="FULL FUCKING WHOLE DROP !!!!" src-address-list=bloqued
/ip firewall filter add action=drop chain=output comment="FULL FUCKING WHOLE DROP !!!!" src-address-list=bloqued
/ip firewall filter add action=accept chain=input comment="defconf: accept ICMP" protocol=icmp src-address=10.0.59.0/24
/ip firewall filter add action=accept chain=input comment="defconf: accept ICMP" limit=50,5:packet protocol=icmp
/ip firewall filter add action=accept chain=input comment="ICMP to IPV6" disabled=yes protocol=icmp src-address=0.0.0.0/0
/ip firewall filter add action=drop chain=input comment="defconf: accept ICMP" connection-state=new log-prefix="Tentativa de PING na WAN - " protocol=icmp src-address=!192.168.0.0/16
/ip firewall filter add action=accept chain=input comment="Regra pra acesso de Winbox remoto" dst-port=8291 protocol=tcp src-address=192.168.0.0/16
/ip firewall filter add action=accept chain=input comment="Regra pra acesso de Winbox remoto" dst-port=8291 in-interface=HydraVPN protocol=tcp
/ip firewall filter add action=accept chain=input comment="FILIAIS > DC    ------ INPUT" dst-address=10.0.59.0/24
/ip firewall filter add action=accept chain=output comment="FILIAIS > DC    ------ OUTPUT" dst-address=10.0.59.0/24
/ip firewall filter add action=accept chain=forward comment="FILIAIS > DC    ------ FORWARD" dst-address=10.0.59.0/24
/ip firewall filter add action=accept chain=forward comment="DC > VPNs (Filial) ------ FORWARD" dst-address=192.168.0.0/16
/ip firewall filter add action=accept chain=output comment="DC > VPNs (Filial) ------ OUTPUT" dst-address=192.168.0.0/16
/ip firewall filter add action=accept chain=input comment="allow L2TP VPN (ipsec-esp)" in-interface-list=WAN protocol=ipsec-esp
/ip firewall filter add action=accept chain=input comment="allow L2TP VPN (500,4500,1701/udp)" dst-port=500,1701,4500 in-interface-list=WAN protocol=udp
/ip firewall filter add action=accept chain=input comment="defconf: accept established,related" connection-state=established,related
/ip firewall filter add action=accept chain=forward comment="defconf: accept established,related" connection-state=established,related
/ip firewall filter add action=accept chain=input comment="defconf: accept established,related,untracked" connection-state=established,related,untracked
/ip firewall filter add action=accept chain=input comment="defconf: accept to local loopback (for CAPsMAN)" dst-address=127.0.0.1
/ip firewall filter add action=accept chain=forward comment="defconf: accept in ipsec policy" ipsec-policy=in,ipsec
/ip firewall filter add action=accept chain=forward comment="defconf: accept out ipsec policy" ipsec-policy=out,ipsec
/ip firewall filter add action=accept chain=forward comment="defconf: accept established,related, untracked" connection-state=established,related,untracked
/ip firewall filter add action=drop chain=input comment="defconf: drop invalid" connection-state=invalid
/ip firewall filter add action=drop chain=forward comment="defconf: drop invalid" connection-state=invalid
/ip firewall filter add action=drop chain=input comment="defconf: drop all from WAN ---1" in-interface-list=WAN
/ip firewall filter add action=drop chain=input comment="defconf: drop all not coming from LAN ---1" in-interface-list=!LAN
/ip firewall filter add action=drop chain=forward comment="defconf:  drop all from WAN not DSTNATed ---1" connection-nat-state=!dstnat connection-state=new in-interface-list=WAN
/ip firewall nat add action=accept chain=srcnat comment="Regra de NAT Datacenter OLITEL" dst-address=10.0.59.0/24
/ip firewall nat add action=masquerade chain=srcnat out-interface-list=WAN
/ip firewall nat add action=masquerade chain=srcnat comment="defconf: masquerade" disabled=yes out-interface=ether1-LINK-SEC
/ip firewall nat add action=dst-nat chain=dstnat comment="TS HK - Filiais" dst-port=3389 protocol=tcp to-addresses=192.168.0.7 to-ports=3389
/ip firewall nat add action=dst-nat chain=dstnat comment=GPRS dst-port=9009 in-interface-list=WAN protocol=tcp to-addresses=192.168.3.50 to-ports=9009
/ip firewall nat add action=dst-nat chain=dstnat comment="NAT DVR Postes Edu Chaves   82.25.74.101" disabled=yes dst-port=1026 in-interface-list=WAN protocol=tcp to-addresses=192.168.3.225 to-ports=1026
/ip firewall nat add action=dst-nat chain=dstnat comment="NAT DVR Postes Edu Chaves" disabled=yes dst-port=8071 in-interface-list=WAN protocol=tcp to-addresses=192.168.3.225 to-ports=8071
/ip firewall nat add action=dst-nat chain=dstnat comment="NAT DVR Postes Edu Chaves" disabled=yes dst-port=555 in-interface-list=WAN protocol=tcp to-addresses=192.168.3.225 to-ports=555
/ip firewall nat add action=dst-nat chain=dstnat comment="NAT DVR Postes Tiradentes" disabled=yes dst-port=1027 in-interface-list=WAN protocol=tcp to-addresses=192.168.3.235 to-ports=1027
/ip firewall nat add action=dst-nat chain=dstnat comment="NAT DVR Postes Tiradentes" disabled=yes dst-port=8072 in-interface-list=WAN protocol=tcp to-addresses=192.168.3.235 to-ports=8072
/ip firewall nat add action=dst-nat chain=dstnat comment="NAT DVR Postes Tiradentes" disabled=yes dst-port=556 in-interface-list=WAN protocol=tcp to-addresses=192.168.3.235 to-ports=556
/ip firewall nat add action=dst-nat chain=dstnat comment=PIAZZA dst-port=9010 protocol=tcp to-addresses=192.168.3.50 to-ports=9010
/ip firewall nat add action=dst-nat chain=dstnat comment=PIAZZA dst-port=9010 protocol=udp to-addresses=192.168.3.50 to-ports=9010
/ip firewall nat add action=masquerade chain=srcnat comment=Hairpin dst-address=192.168.3.153 dst-port=8601 protocol=tcp to-addresses=192.168.3.153
/ip firewall nat add action=dst-nat chain=dstnat comment="altera\E7\E3o ediclei email de 2612" dst-address-type="" dst-port=8601 protocol=tcp to-addresses=192.168.3.153 to-ports=8601
/ip firewall nat add action=dst-nat chain=dstnat comment="SIGMA - alterado \"in interface list\" em 19012025  - desabilitado por servidor desligado" disabled=yes dst-port=8602 in-interface-list=WAN protocol=tcp to-addresses=192.168.3.154 to-ports=8601
/ip firewall nat add action=dst-nat chain=dstnat comment="SIGMA - alterado \"in interface list\" em 19012025  - alterado por servidor desligado" dst-port=8602 in-interface-list=WAN protocol=tcp to-addresses=192.168.3.150 to-ports=8601
/ip firewall nat add action=dst-nat chain=dstnat comment="altera\E7\E3o ediclei 2612" dst-port=8604 protocol=tcp to-addresses=192.168.3.153 to-ports=8600
/ip firewall nat add action=dst-nat chain=dstnat dst-port=8605 protocol=tcp to-addresses=192.168.3.155 to-ports=8600
/ip firewall nat add action=dst-nat chain=dstnat comment="teste 1" dst-port=8607 protocol=tcp to-addresses=192.168.3.155 to-ports=8601
/ip firewall nat add action=dst-nat chain=dstnat dst-port=8606 protocol=tcp to-addresses=192.168.3.156 to-ports=8600
/ip firewall nat add action=dst-nat chain=dstnat comment=test2 dst-port=8608 protocol=tcp to-addresses=192.168.3.156 to-ports=8601
/ip firewall nat add action=dst-nat chain=dstnat comment="Teste Digifort maquina Ediclei email 08012025" dst-port=8609 protocol=tcp to-addresses=192.168.3.200 to-ports=8601
/ip firewall nat add action=dst-nat chain=dstnat comment="Teste Digifort maquina Ediclei email 08012025" dst-port=8610 protocol=tcp to-addresses=192.168.3.200 to-ports=8600
/ip firewall nat add action=dst-nat chain=dstnat comment="FTP Themis" dst-port=21069 in-interface-list=WAN protocol=tcp to-addresses=192.168.0.4 to-ports=21
/ip firewall nat add action=dst-nat chain=dstnat comment="DVR1 - 37770" dst-port=37770 protocol=tcp to-addresses=192.168.3.11 to-ports=37770
/ip firewall nat add action=dst-nat chain=dstnat comment="DVR2 - 37771" dst-port=37771 protocol=tcp to-addresses=192.168.3.12 to-ports=37771
/ip firewall nat add action=dst-nat chain=dstnat comment="DVR3 - 37772" dst-port=37772 protocol=tcp to-addresses=192.168.3.13 to-ports=37711
/ip firewall nat add action=dst-nat chain=dstnat comment="DVR Espelho 1 - 37773" disabled=yes dst-port=37773 protocol=tcp to-addresses=192.168.3.14 to-ports=37773
/ip firewall nat add action=dst-nat chain=dstnat comment="DVR Espelho 2 - 37774" disabled=yes dst-port=37774 protocol=tcp to-addresses=192.168.3.15 to-ports=37774
/ip firewall nat add action=dst-nat chain=dstnat comment="DVR Estacionamento - 37775" dst-port=37775 protocol=tcp to-addresses=192.168.3.16 to-ports=37775
/ip firewall nat add action=dst-nat chain=dstnat comment="DVR Almoxarifado - 37776" dst-port=37776 protocol=tcp to-addresses=192.168.3.21 to-ports=37776
/ip firewall nat add action=dst-nat chain=dstnat comment=WGdash dst-port=31821 in-interface-list=WAN protocol=udp to-addresses=192.168.10.1 to-ports=31821
/ip firewall raw add action=drop chain=prerouting comment="Bloqueia Postes na RAW" disabled=yes src-address-list=Postes
/ip firewall raw add action=drop chain=prerouting comment="Bloqueia Postes na RAW" disabled=yes dst-address-list=Postes
/ip firewall raw add action=drop chain=output comment="Bloqueia Postes na RAW" disabled=yes dst-address-list=Postes
/ip ipsec identity add comment="Novo DC Prim\E1rio" disabled=yes peer=CeC1 secret=yht1GG7DhmYuSimbSbFZ
/ip ipsec identity add comment="Novo DC Secund\E1rio" disabled=yes peer=CeC2 secret=otsd4rNcOrKjH72oSLjN
/ip ipsec identity add comment="Novo DC (Implantado em 27122025)" peer=NovoDC secret=328d6M2OIZT1cJTt
/ip ipsec policy add comment="Novo DC - Prim\E1rio" disabled=yes dst-address=10.0.59.0/24 peer=CeC1 proposal=phase1 src-address=192.168.0.0/16 tunnel=yes
/ip ipsec policy add comment="Novo DC (Implantado em 27122025)" dst-address=10.0.59.0/24 peer=NovoDC proposal=phase12 src-address=192.168.0.0/16 tunnel=yes
/ip ipsec policy add comment="Novo DC - Secund\E1rio" disabled=yes dst-address=10.0.59.0/24 peer=CeC2 proposal=phase1 src-address=192.168.0.0/16 tunnel=yes
/ip route add comment="SAIDA LINK1" disabled=no distance=1 dst-address=0.0.0.0/0 gateway=200.170.180.102 pref-src="" routing-table=main scope=30 target-scope=10
/ip route add comment="Rota VPN - Recrutamento" disabled=yes distance=1 dst-address=192.168.20.0/24 gateway=10.0.0.2 routing-table=main scope=30 target-scope=10
/ip route add comment="Rota VPN - Ribeirao" distance=1 dst-address=192.168.30.0/24 gateway=10.0.0.10
/ip route add comment="Rota VPN - Campinas" distance=1 dst-address=192.168.40.0/24 gateway=10.0.0.4
/ip route add comment="Rota VPN - RJ" disabled=yes distance=1 dst-address=192.168.50.0/24 gateway=10.0.0.6 pref-src="" routing-table=main scope=30 target-scope=10
/ip route add comment="Rota VPN - Santos" disabled=yes distance=1 dst-address=192.168.60.0/24 gateway=10.0.0.8 pref-src="" routing-table=main scope=30 target-scope=10
/ip route add comment="Rota VPN - MG" distance=1 dst-address=192.168.70.0/24 gateway=10.0.0.12
/ip route add comment="Rota VPN - Reserva2" disabled=yes distance=1 dst-address=192.168.80.0/24 gateway=10.0.0.14
/ip route add comment="Rota VPN - Condominio" disabled=yes distance=1 dst-address=192.168.90.0/27 gateway=10.0.0.22 pref-src="" routing-table=main scope=30 target-scope=10
/ip route add comment="Rota VPN - Admin Remota" disabled=yes distance=1 dst-address=192.168.100.0/24 gateway=10.0.0.18 pref-src="" routing-table=main scope=30 target-scope=10
/ip route add comment="Rota VPN - Reserva5" disabled=yes distance=1 dst-address=192.168.110.0/24 gateway=10.0.0.20
/ip route add comment="Rota VPN - Reserva6" disabled=yes distance=1 dst-address=192.168.120.0/24 gateway=10.0.0.22
/ip route add comment="Rota de Comunicacao do tunel VPN" distance=1 dst-address=10.0.0.0/24 gateway=bridge
/ip route add comment="Rota de Comunicacao do tunel VPN" disabled=yes distance=1 dst-address=10.0.0.0/24 gateway=bridge routing-table=main scope=30 target-scope=10
/ip route add comment="Rota para o Datacenter OLITEL" distance=1 dst-address=10.0.59.0/24 gateway=bridge
/ip route add comment="Teste de Conectividade com DNS ROOT SERVER (202.12.27.33/32)" disabled=yes distance=1 dst-address=202.12.27.33/32 gateway=200.170.180.102 routing-table=main scope=30 target-scope=10
/ip route add comment="SAIDA LINK2" disabled=no distance=5 dst-address=0.0.0.0/0 gateway=189.112.167.46 routing-table=main scope=30 target-scope=10
/ip route add comment="LINK1 - Monitoramento 1" distance=1 dst-address=1.1.1.10/32 gateway=200.170.180.102
/ip route add comment="LINK1 - Monitoramento 2" distance=1 dst-address=198.41.0.4/32 gateway=200.170.180.102
/ip route add comment="LINK2 - Monitoramento 1" disabled=no distance=1 dst-address=1.1.1.11/32 gateway=189.112.167.46 routing-table=main scope=30 target-scope=10
/ip route add comment="LINK2 - Monitoramento 2" distance=1 dst-address=202.12.27.33/32 gateway=189.112.167.46
/ip service set ftp disabled=yes
/ip service set ssh address=192.168.10.0/24 disabled=yes
/ip service set telnet disabled=yes
/ip service set www address=192.168.10.0/24 disabled=yes
/ip service set api disabled=yes
/ip service set api-ssl disabled=yes
/ipv6 firewall address-list add address=::/128 comment="defconf: unspecified address" list=bad_ipv6
/ipv6 firewall address-list add address=::1/128 comment="defconf: lo" list=bad_ipv6
/ipv6 firewall address-list add address=fec0::/10 comment="defconf: site-local" list=bad_ipv6
/ipv6 firewall address-list add address=::ffff:0.0.0.0/96 comment="defconf: ipv4-mapped" list=bad_ipv6
/ipv6 firewall address-list add address=::/96 comment="defconf: ipv4 compat" list=bad_ipv6
/ipv6 firewall address-list add address=100::/64 comment="defconf: discard only " list=bad_ipv6
/ipv6 firewall address-list add address=2001:db8::/32 comment="defconf: documentation" list=bad_ipv6
/ipv6 firewall address-list add address=2001:10::/28 comment="defconf: ORCHID" list=bad_ipv6
/ipv6 firewall address-list add address=3ffe::/16 comment="defconf: 6bone" list=bad_ipv6
/ipv6 firewall filter add action=accept chain=input comment="defconf: accept established,related,untracked" connection-state=established,related,untracked
/ipv6 firewall filter add action=drop chain=input comment="defconf: drop invalid" connection-state=invalid
/ipv6 firewall filter add action=accept chain=input comment="defconf: accept ICMPv6" protocol=icmpv6
/ipv6 firewall filter add action=accept chain=input comment="defconf: accept UDP traceroute" port=33434-33534 protocol=udp
/ipv6 firewall filter add action=accept chain=input comment="defconf: accept DHCPv6-Client prefix delegation." dst-port=546 protocol=udp src-address=fe80::/10
/ipv6 firewall filter add action=accept chain=input comment="defconf: accept IKE" dst-port=500,4500 protocol=udp
/ipv6 firewall filter add action=accept chain=input comment="defconf: accept ipsec AH" protocol=ipsec-ah
/ipv6 firewall filter add action=accept chain=input comment="defconf: accept ipsec ESP" protocol=ipsec-esp
/ipv6 firewall filter add action=accept chain=input comment="defconf: accept all that matches ipsec policy" ipsec-policy=in,ipsec
/ipv6 firewall filter add action=drop chain=input comment="defconf: drop everything else not coming from LAN" in-interface-list=!LAN
/ipv6 firewall filter add action=accept chain=forward comment="defconf: accept established,related,untracked" connection-state=established,related,untracked
/ipv6 firewall filter add action=drop chain=forward comment="defconf: drop invalid" connection-state=invalid
/ipv6 firewall filter add action=drop chain=forward comment="defconf: drop packets with bad src ipv6" src-address-list=bad_ipv6
/ipv6 firewall filter add action=drop chain=forward comment="defconf: drop packets with bad dst ipv6" dst-address-list=bad_ipv6
/ipv6 firewall filter add action=drop chain=forward comment="defconf: rfc4890 drop hop-limit=1" hop-limit=equal:1 protocol=icmpv6
/ipv6 firewall filter add action=accept chain=forward comment="defconf: accept ICMPv6" protocol=icmpv6
/ipv6 firewall filter add action=accept chain=forward comment="defconf: accept HIP" protocol=139
/ipv6 firewall filter add action=accept chain=forward comment="defconf: accept IKE" dst-port=500,4500 protocol=udp
/ipv6 firewall filter add action=accept chain=forward comment="defconf: accept ipsec AH" protocol=ipsec-ah
/ipv6 firewall filter add action=accept chain=forward comment="defconf: accept ipsec ESP" protocol=ipsec-esp
/ipv6 firewall filter add action=accept chain=forward comment="defconf: accept all that matches ipsec policy" ipsec-policy=in,ipsec
/ipv6 firewall filter add action=drop chain=forward comment="defconf: drop everything else not coming from LAN" in-interface-list=!LAN
/ipv6 nd set [ find default=yes ] advertise-dns=yes
/ppp secret add comment="VPN Pedro Vicente" disabled=yes local-address=10.0.0.1 name=vpn-recrut password=4lb4tr0z profile=default-encryption remote-address=10.0.0.2 service=l2tp
/ppp secret add comment="VPN Campinas" local-address=10.0.0.3 name=vpn-campinas password=4lb4tr0z profile=default-encryption remote-address=10.0.0.4 service=l2tp
/ppp secret add comment="VPN RJ" disabled=yes local-address=10.0.0.5 name=vpn-rj password=4lb4tr0z profile=default-encryption remote-address=10.0.0.6 service=l2tp
/ppp secret add comment="VPN Santos" disabled=yes local-address=10.0.0.7 name=vpn-santos password=4lb4tr0z profile=default-encryption remote-address=10.0.0.8 service=l2tp
/ppp secret add comment="VPN Ribeirao" local-address=10.0.0.9 name=vpn-ribeirao password=4lb4tr0z profile=default-encryption remote-address=10.0.0.10 service=l2tp
/ppp secret add comment="VPN MG" local-address=10.0.0.11 name=vpn-mg password=4lb4tr0z profile=default-encryption remote-address=10.0.0.12 service=l2tp
/ppp secret add comment="VPN Reserva2" disabled=yes local-address=10.0.0.13 name=vpn-reserva2 password=4lb4tr0z profile=default-encryption remote-address=10.0.0.14 service=l2tp
/ppp secret add comment="VPN Reserva3" disabled=yes local-address=10.0.0.15 name=vpn-reserva3 password=4lb4tr0z profile=default-encryption remote-address=10.0.0.16 service=l2tp
/ppp secret add comment="VPN Admin TI" disabled=yes local-address=10.0.0.17 name=vpn-ti password=4lb4tr0z profile=default-encryption remote-address=10.0.0.18 service=l2tp
/ppp secret add comment="VPN Reserva5" disabled=yes local-address=10.0.0.19 name=vpn-tiroad password=4lb4tr0z profile=default-encryption remote-address=10.0.0.20 service=l2tp
/ppp secret add comment="VPN Piazza de Milano" disabled=yes local-address=10.0.0.21 name=vpn-cond1 password=4lb4tr0z profile=default-encryption remote-address=10.0.0.22 service=l2tp
/ppp secret add comment="VPN Condominio teste" disabled=yes local-address=10.0.0.210 name=vpn-cond11 password=4lb4tr0z profile=default-encryption remote-address=10.0.0.220 service=l2tp
/snmp set enabled=yes
/system clock set time-zone-name=America/Sao_Paulo
/system identity set name=MatrizMAIN
/system ntp client set enabled=yes
/system ntp client servers add address=0.pool.ntp.org
/system ntp client servers add address=1.pool.ntp.org
/system routerboard settings set auto-upgrade=yes
/system scheduler add disabled=yes interval=1h name="Restart VPN Olitel" on-event="/log error \"Reiniciando VPN Olitel\"\r\
    \n/log warning \"Desabilitando VPN Olitel\"  \r\
    \n/ip ipsec peer disable CeC1\r\
    \ndelay 5\r\
    \n/log warning \"Habilitando VPN Olitel\"  \r\
    \n/ip ipsec peer enable CeC1\r\
    \n" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-time=startup
/system scheduler add comment="Verifica VPN Olitel" disabled=yes interval=5m name="Verifica VPN Olitel" on-event="local HOST \"10.0.59.12\"\r\
    \nlocal NAME \"VPN PABX-Olitel\"\r\
    \nlocal PINGCOUNT \"15\"\r\
    \nlocal PINGMIN \"10\"\r\
    \nlocal PRI \"ether1\"\r\
    \nlocal srcip \"192.168.1.1\"\r\
    \nlocal PINGOK [/ping \$HOST interface=\$PRI interval=1 count=\$PINGCOUNT src-address=\$srcip]\r\
    \n\r\
    \nlocal sub1 ([/system identity get name])\r\
    \nlocal sub2 ([/system clock get time])\r\
    \nlocal sub3 ([/system clock get date])\r\
    \nlocal ADMINMAIL1 \"ti@grupoalbatroz.com.br\"\r\
    \n\r\
    \nif (\$PINGOK <= \$PINGMIN) do= {\r\
    \n/log warning \"Host \$NAME \$HOST fora do ar.\"\r\
    \n/tool e-mail send to=\$ADMINMAIL1 subject=\"\$sub1 - \$NAME -  IP (\$HOST), falhou... @ \$sub3 \$sub2\" body=\"Quem:\\r\\nFilial:\$sub1\\r\\nEquipamento:\$NAME\\r\\nIP: \$HOST\\r\\nInterface:\$PRI\\r\\n\\r\\nQuando:\\r\\nData:\$sub3\\r\\nHora:\$sub2\\r\\n\\r\\nParametros:\\r\\nIP:\$HOST\\r\\nTentativas:\$PINGCOUNT\\r\\nOK:\$PINGOK\"\r\
    \n/log error \"Reiniciando VPN Olitel\"\r\
    \n/log warning \"Desabilitando VPN Olitel\"  \r\
    \n/ip ipsec peer disable CeC1\r\
    \ndelay 10s\r\
    \n/log warning \"Habilitando VPN Olitel\"  \r\
    \n/ip ipsec peer enable CeC1\r\
    \n\r\
    \n} else {\r\
    \n/log info \"\$NAME - \$HOST UP \";\r\
    \n}\r\
    \n" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2021-09-19 start-time=01:00:00
/system scheduler add comment="Verifica Servidores DHCP ROGUE" disabled=yes interval=5m name=sDHCP_ROGUE on-event=DHCP_ROGUE policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2021-09-19 start-time=01:00:00
/system scheduler add comment="Verifica VPN Olitel" disabled=yes interval=15m name=sVPN_OLITEL on-event=VPN_OLITEL policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2021-09-19 start-time=01:00:00
/system scheduler add comment="Envia bkp das Configs " interval=12h name=sBKP on-event=BKP policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2021-09-21 start-time=12:00:00
/system scheduler add comment=DTM-convidado disabled=yes interval=1w name=DTM-convidado-on on-event="/ip dhcp-server lease set [/ip dhcp-server lease find where address=192.168.9.25] block-access=no\r\
    \n/ip dhcp-server lease set [/ip dhcp-server lease find where mac-address=08:97:98:67:08:4A] block-access=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2021-11-19 start-time=08:00:00
/system scheduler add comment=DTM-convidado disabled=yes interval=1w name=DTM-convidado-off on-event="/ip dhcp-server lease set [/ip dhcp-server lease find where address=192.168.9.25] block-access=yes\r\
    \n/ip dhcp-server lease set [/ip dhcp-server lease find where mac-address=08:97:98:67:08:4A] block-access=yes" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2021-11-19 start-time=16:55:00
/system scheduler add comment="Libera navegacao das maquinas de reuniao durante horario de trabalho" disabled=yes interval=1d name="Reuniao Free" on-event=ReuniaoOn policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2022-07-21 start-time=07:50:00
/system scheduler add comment="Bloqueia navegacao das maquinas de Reuniao apos horario de trabalho" disabled=yes interval=1d name="Reuniao Block" on-event=ReuniaoOff policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2022-07-20 start-time=18:10:00
/system scheduler add comment="Desabilita WIFI Free" interval=1d name=WIFIFREE_off on-event="/ip dhcp-server lease set [/ip dhcp-server lease find where address=192.168.0.2] block-access=yes\r\
    \n/ip dhcp-server lease set [/ip dhcp-server lease find where mac-address=D4:6E:0E:7C:17:8D] block-access=yes" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2021-11-19 start-time=17:50:00
/system scheduler add comment="script para listar dispositivos com ip \"6\" ligados" interval=1d name=ver_ligados on-event=":log info \"Script started\"\r\
    \n:local emailRecipient \"system@grupoalbatroz.com.br\"\r\
    \n:local emailSubject \"Dispositivos conectados no momento\"\r\
    \n:local emailMessage \"Lista de dispositivos conectados e ativos:\\n\"\r\
    \n\r\
    \n:foreach leaseId in=[/ip dhcp-server lease find address~\"192.168.6.\"] do={\r\
    \n    :local status [/ip dhcp-server lease get \$leaseId status]\r\
    \n    :local address [/ip dhcp-server lease get \$leaseId address]\r\
    \n    :local comment [/ip dhcp-server lease get \$leaseId comment]\r\
    \n\r\
    \n\r\
    \n    :if (\$status = \"bound\") do={\r\
    \n        :set emailMessage (\$emailMessage . \"Dispositivo com o IP \$address - Coment\E1rio: \$comment\\n\")\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n:if ([:len \$emailMessage] > 35) do={\r\
    \n    /tool e-mail send to=\$emailRecipient subject=\$emailSubject body=\$emailMessage\r\
    \n} else={\r\
    \n    :log info \"Sem dispositivos conectados no momento.\"\r\
    \n}\r\
    \n\r\
    \n:log info (\"Status: \$status, Address: \$address\")\r\
    \n\r\
    \n\r\
    \n\r\
    \n\r\
    \n" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2023-10-19 start-time=04:00:00
/system scheduler add comment=DuckDNS disabled=yes interval=1m name=DuckDNS on-event=DuckDNS policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2025-03-19 start-time=10:21:44
/system scheduler add comment="Alterna entre DNS local ou Remoto" interval=20s name=TST-DNS on-event=TST-DNS-HTTP policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2025-03-19 start-time=10:26:33
/system scheduler add comment=leandroesta interval=3m name=leandroesta on-event=leandroesta policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2025-04-11 start-time=07:12:42
/system scheduler add comment="Hosts Dinamicos encontrados na Rede" interval=5m name=guests on-event=guests policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2025-08-04 start-time=08:14:14
/system scheduler add comment="Script de full drop - Ativa queue e drops de input /output e accept no firewall" interval=1d name=FULL_DROP on-event=FULL_DROP policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2026-01-12 start-time=17:50:00
/system scheduler add disabled=yes name=schedule1 on-event=0_bl policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2026-04-06 start-time=09:44:56
/system scheduler add disabled=yes name=schedule2 on-event=0_un policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2026-04-06 start-time=09:57:10
/system script add comment="Faz BKP das Config do MK e envia por e-mail" dont-require-permissions=no name=BKP owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":log info \"Backup: iniciando...\"\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local hostname [/system identity get name]\r\
    \n:local emailDestino \"antonio.tedim@gmail.com\"\r\
    \n\r\
    \n# Criar nome do arquivo baseado no hostname + hora\r\
    \n:local rawTime [/system clock get time]\r\
    \n:local cleanTime \"\"\r\
    \n:for i from=0 to=([:len \$rawTime] - 1) do={\r\
    \n    :local char [:pick \$rawTime \$i]\r\
    \n    :if (\$char = \" \" || \$char = \":\") do={\r\
    \n        :set char \"_\"\r\
    \n    }\r\
    \n    :set cleanTime (\$cleanTime . \$char)\r\
    \n}\r\
    \n:local backupfile (\$hostname . \"_Backup_\" . \$cleanTime)\r\
    \n\r\
    \n# Gerar backup .rsc (export)\r\
    \n:log info \"Backup: gerando arquivo .rsc...\"\r\
    \n/export show-sensitive terse file=(\$backupfile . \".rsc\")\r\
    \n:delay 2s\r\
    \n\r\
    \n# Gerar backup bin\E1rio\r\
    \n:log info \"Backup: gerando arquivo .backup...\"\r\
    \n/system backup save name=(\$backupfile . \".backup\")\r\
    \n:delay 5s\r\
    \n\r\
    \n# Enviar export (.rsc)\r\
    \n:if ([:len [/file find where name=(\$backupfile . \".rsc\")]] > 0) do={\r\
    \n    :log info \"Backup: enviando .rsc por e-mail...\"\r\
    \n    /tool e-mail send to=\$emailDestino subject=(\"Backup MikroTik - \" . \$hostname . \" - EXPORT\") from=\"\" file=(\$backupfile . \".rsc\")\r\
    \n} else={\r\
    \n    :log error \"Backup: arquivo .rsc n\E3o encontrado!\"\r\
    \n}\r\
    \n\r\
    \n# Enviar bin\E1rio (.backup)\r\
    \n:if ([:len [/file find where name=(\$backupfile . \".backup\")]] > 0) do={\r\
    \n    :log info \"Backup: enviando .backup por e-mail...\"\r\
    \n    /tool e-mail send to=\$emailDestino subject=(\"Backup MikroTik - \" . \$hostname . \" - Binary\") from=\"\" file=(\$backupfile . \".backup\")\r\
    \n} else={\r\
    \n    :log error \"Backup: arquivo .backup n\E3o encontrado!\"\r\
    \n}\r\
    \n\r\
    \n:log info \"Backup: processo finalizado!\"\r\
    \n"
/system script add comment="Detectar existencia de outros servers de DHCP na rede" dont-require-permissions=no name=DHCP_ROGUE owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="local HOST \"192.168.1.1\"\r\
    \nlocal NAME \"DHCP - Matriz\"\r\
    \n\r\
    \nlocal sub1 ([/system identity get name])\r\
    \nlocal sub2 ([/system clock get time])\r\
    \nlocal sub3 ([/system clock get date])\r\
    \nlocal ADMINMAIL1 \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# Declara onde adquirir o MAC e o IP #\r\
    \nlocal dhcpmac [/ip dhcp-server alert get [find interface=bridge] unknown-server]\r\
    \nlocal dhcpip [/ip arp get [find mac-address=\$dhcpmac] address]\r\
    \n# Declara onde adquirir o MAC e o IP #\r\
    \n\r\
    \n\r\
    \nif (\$dhcpip != 0) do= {\r\
    \n/log error \"Host \$NAME \$HOST detectado DHCP Rogue! - MAC: \$dhcpmac - IP: \$dhcpip\"\r\
    \n/tool e-mail send to=\$ADMINMAIL1 subject=\"\$sub1 - \$NAME -  IP (\$HOST), detectado DHCP Rogue! @ \$sub3 \$sub2\" body=\"Quem:\\r\\nLocal: \$sub1\\r\\nEquipamento: \$NAME\\r\\nIP: \$HOST\\r\\n\\r\\nQuando:\\r\\nData: \$sub3\\r\\nHora: \$sub2\\r\\n\\r\\nParametros:\\r\\nMAC do Invasor: \$dhcpmac\\r\\nIP do Invasor: \$dhcpip\"\r\
    \n} else {\r\
    \n/log info \"\$NAME - \$HOST - DHCP OK\";\r\
    \n}\r\
    \n\r\
    \n"
/system script add comment="Verificar se Conex\E3o VPN Matriz<->DC Olitel esta UP" dont-require-permissions=no name=VPN_OLITEL owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="local HOST \"10.0.59.12\"\r\
    \nlocal NAME \"VPN PABX-Olitel\"\r\
    \nlocal PINGCOUNT \"15\"\r\
    \nlocal PINGMIN \"10\"\r\
    \nlocal PRI \"ether1\"\r\
    \nlocal srcip \"192.168.1.1\"\r\
    \nlocal PINGOK [/ping \$HOST interface=\$PRI interval=1 count=\$PINGCOUNT src-address=\$srcip]\r\
    \n\r\
    \nlocal sub1 ([/system identity get name])\r\
    \nlocal sub2 ([/system clock get time])\r\
    \nlocal sub3 ([/system clock get date])\r\
    \nlocal ADMINMAIL1 \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \nif (\$PINGOK <= \$PINGMIN) do= {\r\
    \n/log warning \"Host \$NAME \$HOST fora do ar.\"\r\
    \n/tool e-mail send to=\$ADMINMAIL1 subject=\"\$sub1 - \$NAME -  IP (\$HOST), falhou... @ \$sub3 \$sub2\" body=\"Quem:\\r\\nFilial:\$sub1\\r\\nEquipamento:\$NAME\\r\\nIP: \$HOST\\r\\nInterface:\$PRI\\r\\n\\r\\nQuando:\\r\\nData:\$sub3\\r\\nHora:\$sub2\\r\\n\\r\\nParametros:\\r\\nIP:\$HOST\\r\\nTentativas:\$PINGCOUNT\\r\\nOK:\$PINGOK\"\r\
    \n/log error \"Reiniciando VPN Olitel\"\r\
    \n/log warning \"Desabilitando VPN Olitel\"  \r\
    \n/ip ipsec peer disable CeC1\r\
    \ndelay 10s\r\
    \n/log warning \"Habilitando VPN Olitel\"  \r\
    \n/ip ipsec peer enable CeC1\r\
    \n\r\
    \n} else {\r\
    \n/log info \"\$NAME - \$HOST UP \";\r\
    \n}\r\
    \n"
/system script add comment="PiHole esta acessivel" dont-require-permissions=yes name=PIHOLE_ON owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="ip dhcp-server network set 0 dns-server=192.168.0.99,192.168.0.99"
/system script add comment="PiHole nao esta acessivel" dont-require-permissions=yes name=PIHOLE_OFF owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="ip dhcp-server network set 0 dns-server=8.8.8.8,1.1.1.1,9.9.9.9"
/system script add comment=TST-ThemisBKP dont-require-permissions=no name=TST-ThemisBKP owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"192.168.0.4\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"Themis Backup\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 1\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-Carbonita dont-require-permissions=no name=TST-Carbonita owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"192.168.0.5\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"Carbonita\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 1\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-Vault dont-require-permissions=no name=TST-Vault owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"192.168.0.6\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"Vault\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 1\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-TSHK dont-require-permissions=no name=TST-TSHK owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"192.168.0.7\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"TsHK\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 1\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-SMB8adm dont-require-permissions=no name=TST-SMB8adm owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"192.168.0.8\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"ADM SMB 8\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 1\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-SMB9adm dont-require-permissions=no name=TST-SMB9adm owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"192.168.0.9\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"ADM SMB 9\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 1\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-PABXMatriz dont-require-permissions=no name=TST-PABXMatriz owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"192.168.0.10\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"PABX Matriz\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 1\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-PiHole dont-require-permissions=no name=TST-PiHole owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"192.168.0.99\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"PiHole\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 1\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-HK dont-require-permissions=no name=TST-HK owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"192.168.1.4\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"HK\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 1\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-HKadm dont-require-permissions=no name=TST-HKadm owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"192.168.1.5\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"ADM HK\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 1\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-SMB8 dont-require-permissions=no name=TST-SMB8 owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"192.168.1.8\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"SMB 8\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 1\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-SMB9 dont-require-permissions=no name=TST-SMB9 owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"192.168.1.9\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"SMB 9\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 1\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-SUP dont-require-permissions=no name=TST-SUP owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"192.168.1.10\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"SUP\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 1\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-VPNOlitel dont-require-permissions=no name=TST-VPNOlitel owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"10.0.59.12\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"VPN Olitel\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 1\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 5\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-VPNRibeirao dont-require-permissions=no name=TST-VPNRibeirao owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"192.168.30.1\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"VPN Ribeir\E3o\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 1\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-VPNCampinas dont-require-permissions=no name=TST-VPNCampinas owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"192.168.40.1\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"VPN Campinas\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 1\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-VPNBH dont-require-permissions=no name=TST-VPNBH owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"192.168.70.1\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"VPN Belo Horizonte\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 1\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-WANRibeirao dont-require-permissions=no name=TST-WANRibeirao owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"30.tialbatroz.com.br\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"WAN Ribeir\E3o\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 0\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-WANCampinas dont-require-permissions=no name=TST-WANCampinas owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"40.tialbatroz.com.br\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"WAN Campinas\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 0\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-WANBH dont-require-permissions=no name=TST-WANBH owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"70.tialbatroz.com.br\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"WAN Belo Horizonte\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 0\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-DDNSMatriz dont-require-permissions=no name=TST-DDNSMatriz owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"ativo.tialbatroz.com.br\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"DDNS Matriz\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 0\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-GoogleIP dont-require-permissions=no name=TST-GoogleIP owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"8.8.8.8\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"IP Google\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 0\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-GoogleHost dont-require-permissions=no name=TST-GoogleHost owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"google.com\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"DNS Google\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 0\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-WANMatriz2 dont-require-permissions=no name=TST-WANMatriz2 owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"sec_algar.tialbatroz.com.br\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"WAN 2 - Matriz\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 0\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=TST-HydraVPN dont-require-permissions=no name=TST-HydraVPN owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="####inicio do script####\r\
    \n# Defina o host a ser testado (IP ou dom\EDnio)\r\
    \n:local host \"hydravpn.tialbatroz.com.br\"\r\
    \n\r\
    \n# Nome amig\E1vel para o host (deixe vazio para usar o IP)\r\
    \n:local friendlyName \"HydraVPN\"\r\
    \n\r\
    \n# Define se o host est\E1 na rede local (1 = local/LAN, 0 = externo/WAN)\r\
    \n:local isLocalHost 0\r\
    \n\r\
    \n# E-mail para notifica\E7\E3o\r\
    \n:local email \"system@grupoalbatroz.com.br\"\r\
    \n\r\
    \n# N\FAmero de tentativas\r\
    \n:local retries 10\r\
    \n\r\
    \n# Tempo de espera entre tentativas (segundos)\r\
    \n:local waitTime 5\r\
    \n\r\
    \n# ====== GERENCIAMENTO DE VARI\C1VEIS POR HOST ======\r\
    \n# Usar o pr\F3prio IP/hostname como identificador \FAnico para arquivo de status\r\
    \n:local hostId \$host\r\
    \n:local statusFile (\"status_\" . [:pick \$hostId 0 15] . \".txt\")\r\
    \n\r\
    \n# Obter o status anterior deste host espec\EDfico\r\
    \n:local previousStatus \"unknown\"\r\
    \n\r\
    \n# Verificar se o arquivo de status existe\r\
    \n:do {\r\
    \n    :set previousStatus [/file get [find name=\$statusFile] contents]\r\
    \n    /log info (\"Status anterior do host \".\$friendlyName.\" lido do arquivo: \".\$previousStatus)\r\
    \n} on-error={\r\
    \n    # O arquivo n\E3o existe ou ocorreu erro, criar com status unknown\r\
    \n    /log info (\"Criando arquivo de status para o host \".\$friendlyName)\r\
    \n    /file print file=\$statusFile\r\
    \n    /delay 1s\r\
    \n    /file set \$statusFile contents=\"unknown\"\r\
    \n    :set previousStatus \"unknown\"\r\
    \n}\r\
    \n\r\
    \n# ====== L\D3GICA PRINCIPAL DO SCRIPT ======\r\
    \n# Se o nome amig\E1vel estiver vazio, usa o IP/host como nome\r\
    \n:if (\$friendlyName = \"\") do={\r\
    \n    :set friendlyName \$host\r\
    \n}\r\
    \n\r\
    \n# Assunto do e-mail com nome amig\E1vel\r\
    \n:local subject (\"Alerta: \".\$friendlyName.\" Inacess\EDvel\")\r\
    \n\r\
    \n# Obter informa\E7\F5es do roteador\r\
    \n:local routerName [/system identity get name]\r\
    \n\r\
    \n# Obter IP WAN via consulta externa (apenas se necess\E1rio para hosts externos)\r\
    \n:local routerWanIP \"N\E3o aplic\E1vel para host local\"\r\
    \n:if (\$isLocalHost = 0) do={\r\
    \n    :set routerWanIP \"N\E3o dispon\EDvel\"\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://api.ipify.org/\" dst-path=wan_ip.txt\r\
    \n        :delay 1\r\
    \n        :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n        /file remove wan_ip.txt\r\
    \n    } on-error={\r\
    \n        :do {\r\
    \n            # Tente uma API alternativa se a primeira falhar\r\
    \n            /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=wan_ip.txt\r\
    \n            :delay 1\r\
    \n            :set routerWanIP [/file get wan_ip.txt contents]\r\
    \n            # Remover poss\EDveis caracteres de quebra de linha\r\
    \n            :set routerWanIP [:pick \$routerWanIP 0 [:find \$routerWanIP \"\\r\\n\"]]\r\
    \n            /file remove wan_ip.txt\r\
    \n        } on-error={\r\
    \n            :set routerWanIP \"N\E3o foi poss\EDvel determinar o IP WAN\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Obter hora de in\EDcio do teste\r\
    \n:local startTime [/system clock get time]\r\
    \n:local startDate [/system clock get date]\r\
    \n\r\
    \n# Vari\E1veis locais\r\
    \n:local i 0\r\
    \n:local success false\r\
    \n:local resolvedIP \$host\r\
    \n:local failedAttempt 0\r\
    \n\r\
    \n# Para hosts locais, pulamos a etapa de resolu\E7\E3o de DNS\r\
    \n:if (\$isLocalHost = 1) do={\r\
    \n    :set resolvedIP \$host\r\
    \n} else {\r\
    \n    # Verifica se o host \E9 um IP ou precisa ser resolvido\r\
    \n    :if ([find \$host \".\"] != nil && [:len [find \$host \"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\"]] = 0) do={\r\
    \n        :set resolvedIP \$host\r\
    \n    } else={\r\
    \n        :do {\r\
    \n            :set resolvedIP [:resolve \$host]\r\
    \n        } on-error={\r\
    \n            /log error (\"Erro ao resolver o host: \".\$friendlyName.\" (\".\$host.\")\")\r\
    \n            :local errorMsg (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o p\F4de ser resolvido. Verifique se est\E1 correto.\\n\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"Detalhes do teste:\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Data e hora do teste: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- Roteador: \".\$routerName.\"\\n\")\r\
    \n            :set errorMsg (\$errorMsg.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n            \r\
    \n            # S\F3 envia e-mail se o status anterior n\E3o era \"down\"\r\
    \n            :if (\$previousStatus != \"down\") do={\r\
    \n                /tool e-mail send to=\$email subject=(\"Erro: N\E3o foi poss\EDvel resolver \".\$friendlyName) body=\$errorMsg\r\
    \n                \r\
    \n                # Atualiza o status para \"down\"\r\
    \n                /file set \$statusFile contents=\"down\"\r\
    \n                /log info (\"Status do host \".\$friendlyName.\" atualizado para: down\")\r\
    \n            }\r\
    \n            :exit\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Loop para testar a conectividade do host\r\
    \n:while (\$i < \$retries && !\$success) do={\r\
    \n    :do {\r\
    \n        :if ([/ping address=\$resolvedIP count=1] > 0) do={\r\
    \n            /log info (\"Host \".\$friendlyName.\" (\".\$host.\") est\E1 ativo.\")\r\
    \n            :set success true\r\
    \n        }\r\
    \n    } on-error={\r\
    \n        /log error (\"Falha ao executar ping no host: \".\$friendlyName.\" (\".\$resolvedIP.\")\")\r\
    \n        :set success false\r\
    \n    }\r\
    \n    \r\
    \n    :if (!\$success) do={\r\
    \n        :set failedAttempt (\$i + 1)\r\
    \n        /log warning (\"Tentativa \".(\$i+1).\" - Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel. Retestando em \".\$waitTime.\"s...\")\r\
    \n        :delay \$waitTime\r\
    \n    }\r\
    \n    :set i (\$i + 1)\r\
    \n}\r\
    \n\r\
    \n# Obter a hora atual (final do teste)\r\
    \n:local endTime [/system clock get time]\r\
    \n\r\
    \n# Determine o status atual\r\
    \n:local currentStatus\r\
    \n:if (\$success) do={\r\
    \n    :set currentStatus \"up\"\r\
    \n} else={\r\
    \n    :set currentStatus \"down\"\r\
    \n}\r\
    \n\r\
    \n# Registrar o status atual para debug\r\
    \n/log info (\"Status atual do host \".\$friendlyName.\": \".\$currentStatus)\r\
    \n/log info (\"Status anterior do host \".\$friendlyName.\": \".\$previousStatus)\r\
    \n\r\
    \n# Se o status mudou, enviar e-mail\r\
    \n:if (\$currentStatus != \$previousStatus) do={\r\
    \n    /log info (\"Status mudou de \".\$previousStatus.\" para \".\$currentStatus.\". Enviando e-mail.\")\r\
    \n    \r\
    \n    # Se o host est\E1 down\r\
    \n    :if (\$currentStatus = \"down\") do={\r\
    \n        # Constru\EDmos a mensagem detalhada aqui\r\
    \n        :local message (\"O host \".\$friendlyName.\" (\".\$host.\") n\E3o respondeu ap\F3s \".\$retries.\" tentativas.\\n\\n\")\r\
    \n        :set message (\$message.\"Detalhes do teste:\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set message (\$message.\"- Quantidade de tentativas realizadas: \".\$retries.\"\\n\")\r\
    \n        :set message (\$message.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set message (\$message.\"- Falhou em todas as tentativas\\n\")\r\
    \n        :set message (\$message.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set message (\$message.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log error (\"Host \".\$friendlyName.\" (\".\$host.\") inacess\EDvel ap\F3s \".\$retries.\" tentativas. Enviando alerta por e-mail.\")\r\
    \n        /tool e-mail send to=\$email subject=\$subject body=\$message\r\
    \n    } else {\r\
    \n        # Se o host voltou a ficar up\r\
    \n        :local successMessage (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo.\\n\\n\")\r\
    \n        :set successMessage (\$successMessage.\"Detalhes do teste:\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de in\EDcio: \".\$startDate.\" \".\$startTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Data e hora de t\E9rmino: \".\$startDate.\" \".\$endTime.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Quantidade de tentativas realizadas at\E9 sucesso: \".\$i.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Endere\E7o testado: \".\$resolvedIP.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- Teste executado por: \".\$routerName.\"\\n\")\r\
    \n        :set successMessage (\$successMessage.\"- IP WAN do roteador: \".\$routerWanIP)\r\
    \n        \r\
    \n        /log info (\"Host \".\$friendlyName.\" (\".\$host.\") voltou a ficar ativo. Enviando notifica\E7\E3o.\")\r\
    \n        /tool e-mail send to=\$email subject=(\"Recupera\E7\E3o: \".\$friendlyName.\" Ativo\") body=\$successMessage\r\
    \n    }\r\
    \n} else {\r\
    \n    # O status n\E3o mudou\r\
    \n    /log info (\"Status do host \".\$friendlyName.\" n\E3o mudou. Permanece como \".\$currentStatus.\". Nenhum e-mail enviado.\")\r\
    \n}\r\
    \n\r\
    \n# Atualizar o status no arquivo\r\
    \n/file set \$statusFile contents=\$currentStatus\r\
    \n/log info (\"Status do host \".\$friendlyName.\" atualizado para: \".\$currentStatus)\r\
    \n\r\
    \n####fim do script####"
/system script add comment=DuckDNS dont-require-permissions=no name=DuckDNS owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="# Script para atualiza\E7\E3o de um DDNS (DuckDNS) usando consulta externa para obter o IP p\FAblico\r\
    \n\r\
    \n:global actualIP\r\
    \n:global wanInterface \"sfp-sfpplus1\"\r\
    \n:global tempIPFile \"duckwan_ip.txt\"\r\
    \n:global domainName \"albamatriz\"\r\
    \n:global duckDNSToken \"bf52ad64-74d1-44fd-9718-a398a4ffeafa\"\r\
    \n\r\
    \n# Tentativa de obter o IP p\FAblico via servi\E7os externos primeiro\r\
    \n:do {\r\
    \n    /tool fetch url=\"https://api.ipify.org/\" dst-path=\$tempIPFile\r\
    \n    :delay 1\r\
    \n    :set actualIP [/file get \$tempIPFile contents]\r\
    \n    /file remove \$tempIPFile\r\
    \n} on-error={\r\
    \n    :do {\r\
    \n        /tool fetch url=\"https://checkip.amazonaws.com/\" dst-path=\$tempIPFile\r\
    \n        :delay 1\r\
    \n        :set actualIP [/file get \$tempIPFile contents]\r\
    \n        :set actualIP [:pick \$actualIP 0 [:find \$actualIP \"\\r\\n\"]]\r\
    \n        /file remove \$tempIPFile\r\
    \n    } on-error={\r\
    \n        :log warning message=\"Servi\E7os externos falharam, tentando obter IP da interface local\"\r\
    \n\r\
    \n        :local ipItem [/ip address find where interface=\$wanInterface]\r\
    \n        :if ([:len \$ipItem] > 0) do={\r\
    \n            :local firstItem [:pick \$ipItem 0]\r\
    \n            :set actualIP [/ip address get \$firstItem value-name=address]\r\
    \n            :set actualIP [:pick \$actualIP 0 [:find \$actualIP \"/\" -1]]\r\
    \n        } else={\r\
    \n            :log error message=(\"Nenhum IP encontrado na interface \" . \$wanInterface)\r\
    \n            :set actualIP \"0.0.0.0\"\r\
    \n        }\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Verifica ou cria arquivo com IP anterior\r\
    \n:if ([:len [/file find where name=\"ipstore.txt\"]] < 1) do={\r\
    \n    /file print file=ipstore.txt\r\
    \n    :delay 2\r\
    \n    /file set ipstore.txt contents=\"0.0.0.0\"\r\
    \n}\r\
    \n\r\
    \n:global previousIP [/file get [/file find name=\"ipstore.txt\"] value-name=contents]\r\
    \n\r\
    \n# Se o IP atual for diferente do anterior, faz a atualiza\E7\E3o\r\
    \n:if (\$previousIP != \$actualIP) do={\r\
    \n    :log info message=(\"Tentando atualizar DuckDNS com IP atual \".\$actualIP.\" - IP anterior era \".\$previousIP)\r\
    \n    /tool fetch mode=https keep-result=yes dst-path=duckdns-result.txt address=[:resolve www.duckdns.org] port=443 host=www.duckdns.org src-path=(\"/update\?domains=\".\$domainName.\"&token=\".\$duckDNSToken.\"&ip=\".\$actualIP)\r\
    \n    :delay 5\r\
    \n    :global lastChange [/file get [/file find name=\"duckdns-result.txt\"] value-name=contents]\r\
    \n    /file set ipstore.txt contents=\$actualIP\r\
    \n\r\
    \n    :if (\$lastChange = \"OK\") do={\r\
    \n        :log warning message=(\"DuckDNS atualizado com sucesso para IP \".\$actualIP)\r\
    \n    } else={\r\
    \n        :log error message=(\"Falha ao atualizar DuckDNS. Resposta: \".\$lastChange)\r\
    \n    }\r\
    \n}\r\
    \n"
/system script add comment=leandroesta dont-require-permissions=yes name=leandroesta owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":do {\r\
    \n\r\
    \n    # === CONFIGURA\C7\D5ES ===\r\
    \n    :local macMonitor \"74:56:3C:FB:68:4E\"\r\
    \n    :local stateFileName \"leandro_status.txt\"\r\
    \n    :local emailTo \"system@grupoalbatroz.com.br\"\r\
    \n    :local hostName \"Desconhecido\"\r\
    \n    :local currentState \"offline\"\r\
    \n    :local previousState \"unknown\"\r\
    \n\r\
    \n    # === PROCURA LEASE CORRESPONDENTE AO MAC ===\r\
    \n    :foreach lease in=[/ip dhcp-server lease find] do={\r\
    \n        :if ([/ip dhcp-server lease get \$lease mac-address] = \$macMonitor) do={\r\
    \n\r\
    \n            # Obt\E9m o coment\E1rio, mesmo se n\E3o estiver bound\r\
    \n            :set hostName [/ip dhcp-server lease get \$lease comment]\r\
    \n\r\
    \n            # Verifica se est\E1 online (bound)\r\
    \n            :if ([/ip dhcp-server lease get \$lease status] = \"bound\") do={\r\
    \n                :set currentState \"online\"\r\
    \n            }\r\
    \n\r\
    \n        }\r\
    \n    }\r\
    \n\r\
    \n    # === VERIFICA OU CRIA ARQUIVO DE ESTADO ===\r\
    \n    :if ([:len [/file find name=\$stateFileName]] = 0) do={\r\
    \n        /file print file=\$stateFileName\r\
    \n        :delay 1s\r\
    \n        /file set [/file find name=\$stateFileName] contents=\$previousState\r\
    \n    }\r\
    \n\r\
    \n    # === L\CA ESTADO ANTERIOR DO ARQUIVO ===\r\
    \n    :set previousState [/file get [/file find name=\$stateFileName] contents]\r\
    \n\r\
    \n    # === COMPARA E DISPARA NOTIFICA\C7\D5ES ===\r\
    \n    :if (\$currentState != \$previousState) do={\r\
    \n\r\
    \n        :local message (\"O host \" . \$hostName . \" com MAC \" . \$macMonitor . \" est\E1 AGORA \" . \$currentState . \".\")\r\
    \n\r\
    \n        :local statusLabel \"\"\r\
    \n        :if (\$currentState = \"online\") do={\r\
    \n            :set statusLabel \"Host Conectado\"\r\
    \n        } else={\r\
    \n            :set statusLabel \"Host Desconectado\"\r\
    \n        }\r\
    \n\r\
    \n        :local subject (\$hostName . \" - \" . \$statusLabel)\r\
    \n\r\
    \n        /tool e-mail send to=\$emailTo subject=\$subject body=\$message\r\
    \n        :log info \$message\r\
    \n\r\
    \n        # Atualiza o arquivo de estado\r\
    \n        /file set [/file find name=\$stateFileName] contents=\$currentState\r\
    \n    }\r\
    \n\r\
    \n} on-error={\r\
    \n    :log error \"Erro geral no script de monitoramento de host DHCP.\"\r\
    \n}\r\
    \n"
/system script add comment="Alterna entre DNS local ou Remoto- teste de http " dont-require-permissions=no name=TST-DNS-HTTP owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="# URL da p\E1gina a testar via HTTP\r\
    \n:local urlTest \"http://192.168.0.99/admin/login\"\r\
    \n\r\
    \n# DNS preferido (local)\r\
    \n:local preferredDNS \"192.168.0.99,192.168.0.99\"\r\
    \n\r\
    \n# DNS alternativos\r\
    \n:local alternativeDNS \"8.8.8.8,1.1.1.1,9.9.9.9\"\r\
    \n\r\
    \n# N\FAmero de tentativas HTTP\r\
    \n:local testCount 5\r\
    \n:local delayBetweenTests 3\r\
    \n\r\
    \n# Vari\E1vel global para rastrear DNS atual\r\
    \n:global currentDNS\r\
    \n:if ([:len \$currentDNS] = 0) do={\r\
    \n    :set currentDNS \"\"\r\
    \n}\r\
    \n\r\
    \n# Obter DNS atual\r\
    \n:local configuredDNS [/ip dhcp-server network get 0 dns-server]\r\
    \n\r\
    \n# Armazena o DNS atual, se ainda n\E3o armazenado\r\
    \n:if ([:len \$currentDNS] = 0) do={\r\
    \n    :set currentDNS \$configuredDNS\r\
    \n    /log info \"Primeira execu\E7\E3o: DNS atual armazenado como: \$currentDNS\"\r\
    \n}\r\
    \n\r\
    \n# Verifica se DNS atual \E9 o preferido\r\
    \n:if (\$currentDNS = \$preferredDNS) do={\r\
    \n\r\
    \n    /log info \"Verificando HTTP em \$urlTest (DNS preferido em uso)\"\r\
    \n    :local failCount 0\r\
    \n    :for i from=1 to=\$testCount do={\r\
    \n        :do {\r\
    \n            /tool fetch url=\$urlTest mode=http keep-result=no\r\
    \n        } on-error={\r\
    \n            :set failCount (\$failCount + 1)\r\
    \n        }\r\
    \n        :delay \$delayBetweenTests\r\
    \n    }\r\
    \n\r\
    \n    :if (\$failCount = \$testCount) do={\r\
    \n        /ip dhcp-server network set 0 dns-server=\$alternativeDNS\r\
    \n        :set currentDNS \$alternativeDNS\r\
    \n        /ip dns cache flush\r\
    \n        /log error \"DNS alterado para \$alternativeDNS - HTTP \$urlTest falhou em todos os testes.\"\r\
    \n    } else={\r\
    \n        /log info \"HTTP \$urlTest est\E1 acess\EDvel. Mantendo DNS preferido.\"\r\
    \n    }\r\
    \n\r\
    \n} else={\r\
    \n\r\
    \n    /log info \"Verificando HTTP em \$urlTest (DNS alternativo em uso)\"\r\
    \n    :local failCount 0\r\
    \n    :for i from=1 to=\$testCount do={\r\
    \n        :do {\r\
    \n            /tool fetch url=\$urlTest mode=http keep-result=no\r\
    \n        } on-error={\r\
    \n            :set failCount (\$failCount + 1)\r\
    \n        }\r\
    \n        :delay \$delayBetweenTests\r\
    \n    }\r\
    \n\r\
    \n    :if (\$failCount = \$testCount) do={\r\
    \n        /ip dhcp-server network set 0 dns-server=\$alternativeDNS\r\
    \n        :set currentDNS \$alternativeDNS\r\
    \n        /ip dns cache flush\r\
    \n        /log error \"HTTP \$urlTest ainda inacess\EDvel. Mantendo DNS alternativo.\"\r\
    \n    } else={\r\
    \n        /ip dhcp-server network set 0 dns-server=\$preferredDNS\r\
    \n        :set currentDNS \$preferredDNS\r\
    \n        /ip dns cache flush\r\
    \n        /log info \"HTTP \$urlTest voltou a responder. DNS preferido reativado.\"\r\
    \n    }\r\
    \n}\r\
    \n"
/system script add comment="Hosts Dinamicos encontrados na Rede" dont-require-permissions=no name=guests owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="# Script para monitorar hosts DHCP din\E2micos e enviar notifica\E7\E3o por email\r\
    \n# Email j\E1 configurado no RouterOS\r\
    \n\r\
    \n:local emailTo \"system@grupoalbatroz.com.br\"\r\
    \n:local emailSubject \"Hosts Dinamicos encontrados na Rede\"\r\
    \n\r\
    \n# Fun\E7\E3o para obter hosts DHCP din\E2micos\r\
    \n:local dynamicHosts \"\"\r\
    \n:local hostCount 0\r\
    \n\r\
    \n# Buscar leases DHCP din\E2micos\r\
    \n:foreach lease in=[/ip dhcp-server lease find dynamic=yes] do={\r\
    \n    :local hostIP [/ip dhcp-server lease get \$lease address]\r\
    \n    :local hostMAC [/ip dhcp-server lease get \$lease mac-address]\r\
    \n    :local hostName \"\"\r\
    \n    \r\
    \n    # Tentar obter hostname se dispon\EDvel\r\
    \n    :do {\r\
    \n        :set hostName [/ip dhcp-server lease get \$lease host-name]\r\
    \n    } on-error={\r\
    \n        :set hostName \"Desconhecido\"\r\
    \n    }\r\
    \n    \r\
    \n    # Obter status ativo\r\
    \n    :local status [/ip dhcp-server lease get \$lease status]\r\
    \n    \r\
    \n    # Se estiver ativo (bound), adicionar \E0 lista com formato colunar\r\
    \n    :if (\$status = \"bound\") do={\r\
    \n        :set hostCount (\$hostCount + 1)\r\
    \n        \r\
    \n        # Formatar MAC address (pad para 17 caracteres)\r\
    \n        :local macFormatted \$hostMAC\r\
    \n        :while ([:len \$macFormatted] < 17) do={ :set macFormatted (\$macFormatted . \" \") }\r\
    \n        \r\
    \n        # Formatar IP (pad para 13 caracteres)\r\
    \n        :local ipFormatted \$hostIP\r\
    \n        :while ([:len \$ipFormatted] < 13) do={ :set ipFormatted (\$ipFormatted . \" \") }\r\
    \n        \r\
    \n        # Formatar hostname (truncar se muito longo)\r\
    \n        :local hostFormatted \$hostName\r\
    \n        :if ([:len \$hostFormatted] > 18) do={\r\
    \n            :set hostFormatted ([:pick \$hostFormatted 0 15] . \"...\")\r\
    \n        }\r\
    \n        \r\
    \n        # Adicionar linha formatada\r\
    \n        :set dynamicHosts (\$dynamicHosts . \$macFormatted . \" | \" . \$ipFormatted . \" | \" . \$hostFormatted . \"\\n\")\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Verificar se h\E1 hosts din\E2micos ativos\r\
    \n:if (\$hostCount > 0) do={\r\
    \n    # Obter data e hora atual\r\
    \n    :local currentDate [/system clock get date]\r\
    \n    :local currentTime [/system clock get time]\r\
    \n    \r\
    \n    # Montar cabe\E7alho da mensagem com formato colunar\r\
    \n    :local emailBody (\"Data/Hora: \" . \$currentDate . \" \" . \$currentTime . \"\\n\\n\")\r\
    \n    :set emailBody (\$emailBody . \"Hosts DHCP Dinamicos Detectados:\\n\\n\")\r\
    \n    :set emailBody (\$emailBody . \"MAC Address       | IP Address    | Hostname\\n\")\r\
    \n    :set emailBody (\$emailBody . \"------------------|---------------|------------------\\n\")\r\
    \n    :set emailBody (\$emailBody . \$dynamicHosts)\r\
    \n    \r\
    \n    # Enviar email\r\
    \n    :do {\r\
    \n        /tool e-mail send to=\$emailTo subject=\$emailSubject body=\$emailBody\r\
    \n        :log info (\"Email enviado: \" . \$hostCount . \" hosts dinamicos detectados\")\r\
    \n    } on-error={\r\
    \n        :log error \"Erro ao enviar email de notificacao\"\r\
    \n    }\r\
    \n} else={\r\
    \n    :log info \"Nenhum host DHCP dinamico ativo encontrado\"\r\
    \n}\r\
    \n\r\
    \n# Para agendar este script, use:\r\
    \n# /system scheduler add name=\"monitor-dhcp\" interval=5m on-event=\"/system script run monitor-dhcp-dinamico\""
/system script add comment=apagar dont-require-permissions=no name=apagar owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="# ==========================================================================\r\
    \n# \r\
    \n# Script Instalador FailOver\r\
    \n\r\
    \n# -------- VARI\C1VEIS --------\r\
    \n\r\
    \n:local ipWAN1 \"200.170.180.100/29\"\r\
    \n:local gwWAN1 \"200.170.180.102\"\r\
    \n:local netWAN1 \"200.170.180.96\"\r\
    \n:local nameOPER1 \"ALGAR 2G\"\r\
    \n\r\
    \n:local ipWAN2 \"189.112.167.45/30\"\r\
    \n:local gwWAN2 \"189.112.167.46\"\r\
    \n:local netWAN2 \"189.112.167.44\"\r\
    \n:local nameOPER2 \"ALGAR 1G\"\r\
    \n\r\
    \n:local dnsTest1WAN1 \"1.1.1.10\"\r\
    \n:local dnsTest2WAN1 \"198.41.0.4\"\r\
    \n:local dnsTest1WAN2 \"1.1.1.11\"\r\
    \n:local dnsTest2WAN2 \"202.12.27.33\"\r\
    \n\r\
    \n# -------- EXECU\C7\C3O --------\r\
    \n\r\
    \n\r\
    \n# -------- NETWATCH --------\r\
    \n# Teste 1 WAN1\r\
    \n/tool netwatch add comment=\"Teste 1 do Link 1\" disabled=no \\\r\
    \n    host=\$dnsTest1WAN1 interval=2s name=\"LINK1 - Monitoramento 1\" start-delay=5s startup-delay=5s \\\r\
    \n    down-script=\"/log error \\\"LINK1 - Monitoramento 1\\\"\\r\\\r\
    \n    \\n/ip route set [find comment~\\\"SAIDA LINK1\\\"] disable=yes\\r\\\r\
    \n    \\n\\r\\\r\
    \n    \\n:local emailDest \\\"system@grupoalbatroz.com.br\\\"\\r\\\r\
    \n    \\n:local data [/system clock get date]\\r\\\r\
    \n    \\n:local hora [/system clock get time]\\r\\\r\
    \n    \\n:local nome [/system identity get name]\\r\\\r\
    \n    \\n:local operadora \\\"LINK_PRI\\\"\\r\\\r\
    \n    \\n:local status \\\"DOWN\\\"\\r\\\r\
    \n    \\n:local dnsTeste \\\"Teste 1 esta DOWN\\\"\\r\\\r\
    \n    \\n\\r\\\r\
    \n    \\n/tool e-mail send to=\\\$emailDest \\\\\\r\\\r\
    \n    \\n    subject=\\\"[\\\$nome] Link \\\$operadora \\\$status - \\\$dnsTeste\\\" \\\\\\r\\\r\
    \n    \\n    body=\\\"Link \\\$operadora \\\$status - \\\$dnsTeste - \\\$data - \\\$hora\\\\r\\\\nTeste 1 Down - Aten\\E7\\E3o Necess\\E1ria !\\\"\" \\\r\
    \n    up-script=\"/log warning \\\"LINK_PRI UP- Monitoramento 1\\\"\\r\\\r\
    \n    \\n/ip route set [find comment~\\\"SAIDA LINK1\\\"] disable=no\\r\\\r\
    \n    \\n/ppp active remove [find]\\r\\\r\
    \n    \\n\\r\\\r\
    \n    \\n:delay 5s;\\r\\\r\
    \n    \\n\\r\\\r\
    \n\\n:local emailDest \\\"system@grupoalbatroz.com.br\\\"\\r\\\r\
    \n    \\n:local data [/system clock get date]\\r\\\r\
    \n    \\n:local hora [/system clock get time]\\r\\\r\
    \n    \\n:local nome [/system identity get name]\\r\\\r\
    \n    \\n:local operadora \\\"LINK_PRI\\\"\\r\\\r\
    \n    \\n:local status \\\"UP\\\"\\r\\\r\
    \n    \\n:local dnsTeste \\\"Teste 1 esta UP\\\"\\r\\\r\
    \n    \\n\\r\\\r\
    \n    \\n/tool e-mail send to=\\\$emailDest \\\\\\r\\\r\
    \n    \\n    subject=\\\"[\\\$nome] Link \\\$operadora \\\$status - \\\$dnsTeste\\\" \\\\\\r\\\r\
    \n    \\n    body=\\\"Link \\\$operadora \\\$status - \\\$dnsTeste - \\\$data - \\\$hora\\\\r\\\\nSistema Normalizado \\\$operadora OK !\\\"\"\r\
    \n\r\
    \n# Teste 2 WAN1\r\
    \n/tool netwatch add comment=\"Teste 2 do Link 1\" disabled=yes \\\r\
    \n    host=\$dnsTest2WAN1 interval=2s name=\"LINK1 - Monitoramento 2\" start-delay=5s startup-delay=5s \\\r\
    \n    down-script=\"/log error \\\"LINK1 - Monitoramento 2\\\"\\r\\\r\
    \n    \\n/ip route set [find comment~\\\"SAIDA LINK1\\\"] disable=yes\\r\\\r\
    \n    \\n\\r\\\r\
    \n\\n:local emailDest \\\"system@grupoalbatroz.com.br\\\"\\r\\\r\
    \n    \\n:delay 5s;\\r\\\r\
    \n    \\n:local data [/system clock get date]\\r\\\r\
    \n    \\n:local hora [/system clock get time]\\r\\\r\
    \n    \\n:local nome [/system identity get name]\\r\\\r\
    \n    \\n:local operadora \\\"LINK_PRI\\\"\\r\\\r\
    \n    \\n:local status \\\"DOWN\\\"\\r\\\r\
    \n    \\n\\r\\\r\
    \n    \\n/tool e-mail send to=\\\$emailDest \\\\\\r\\\r\
    \n    \\n    subject=\\\"[\\\$nome] Link \\\$operadora \\\$status - \\\$dnsTeste\\\" \\\\\\r\\\r\
    \n    \\n    body=\\\"Link \\\$operadora \\\$status - \\\$dnsTeste - \\\$data - \\\$hora\\\\r\\\\nLink 1 Down - Verificar Operadora do Link 1 !\\\"\" \\\r\
    \n    up-script=\"/log warning \\\"LINK1 - Monitoramento 2\\\"\\r\\\r\
    \n    \\n/ip route set [find comment~\\\"SAIDA LINK1\\\"] disable=no\\r\\\r\
    \n    \\n\\r\\\r\
    \n\\n:local emailDest \\\"system@grupoalbatroz.com.br\\\"\\r\\\r\
    \n    \\n:delay 5s;\\r\\\r\
    \n    \\n\\r\\\r\
    \n    \\n:local data [/system clock get date]\\r\\\r\
    \n    \\n:local hora [/system clock get time]\\r\\\r\
    \n    \\n:local nome [/system identity get name]\\r\\\r\
    \n    \\n:local operadora \\\"LINK_PRI\\\"\\r\\\r\
    \n    \\n:local status \\\"UP\\\"\\r\\\r\
    \n    \\n:local dnsTeste \\\"Teste 2 esta UP\\\"\\r\\\r\
    \n    \\n\\r\\\r\
    \n    \\n/tool e-mail send to=\\\$emailDest \\\\\\r\\\r\
    \n    \\n    subject=\\\"[\\\$nome] Link \\\$operadora \\\$status - \\\$dnsTeste\\\" \\\\\\r\\\r\
    \n    \\n    body=\\\"Link \\\$operadora \\\$status - \\\$dnsTeste - \\\$data - \\\$hora\\\\r\\\\nTeste 1 Down - Aten\\E7\\E3o Necess\\E1ria !\\\"\"\r\
    \n\r\
    \n# Teste 1 WAN2\r\
    \n/tool netwatch add comment=\"Teste 1 do Link 2\" disabled=no \\\r\
    \n    host=\$dnsTest1WAN2 interval=2s name=\"LINK2 - Monitoramento 1\" start-delay=5s startup-delay=5s \\\r\
    \n    down-script=\"/log error \\\"LINK2 - Monitoramento 1\\\"\\r\\\r\
    \n    \\n/tool netwatch set [find name=\\\"LINK2 - Monitoramento 2\\\"] disable=no\\r\\\r\
    \n    \\n\\r\\\r\
    \n\\n:local emailDest \\\"system@grupoalbatroz.com.br\\\"\\r\\\r\
    \n    \\n:local data [/system clock get date]\\r\\\r\
    \n    \\n:local hora [/system clock get time]\\r\\\r\
    \n    \\n:local nome [/system identity get name]\\r\\\r\
    \n    \\n:local operadora \\\"LINK_SEC\\\"\\r\\\r\
    \n    \\n:local status \\\"DOWN\\\"\\r\\\r\
    \n    \\n:local dnsTeste \\\"Teste 1 esta DOWN\\\"\\r\\\r\
    \n    \\n\\r\\\r\
    \n    \\n/tool e-mail send to=\\\$emailDest \\\\\\r\\\r\
    \n    \\n    subject=\\\"[\\\$nome] Link \\\$operadora \\\$status - \\\$dnsTeste\\\" \\\\\\r\\\r\
    \n    \\n    body=\\\"Link \\\$operadora \\\$status - \\\$dnsTeste - \\\$data - \\\$hora\\\\r\\\\nTeste 1 Down - Aten\\E7\\E3o Necess\\E1ria !\\\"\" \\\r\
    \n    up-script=\"/log warning \\\"LINK2 - Monitoramento 1\\\"\\r\\\r\
    \n    \\n/tool netwatch set [find name=\\\"LINK2 - Monitoramento 2\\\"] disable=yes\\r\\\r\
    \n    \\n/ip route set [find comment~\\\"SAIDA LINK2\\\"] disable=no\\r\\\r\
    \n    \\n/ppp active remove [find]\\r\\\r\
    \n    \\n\\r\\\r\
    \n\\n:local emailDest \\\"system@grupoalbatroz.com.br\\\"\\r\\\r\
    \n    \\n:local data [/system clock get date]\\r\\\r\
    \n    \\n:local hora [/system clock get time]\\r\\\r\
    \n    \\n:local nome [/system identity get name]\\r\\\r\
    \n    \\n:local operadora \\\"LINK_SEC\\\"\\r\\\r\
    \n    \\n:local status \\\"UP\\\"\\r\\\r\
    \n    \\n:local dnsTeste \\\"Teste 1 esta UP\\\"\\r\\\r\
    \n    \\n\\r\\\r\
    \n    \\n/tool e-mail send to=\\\$emailDest \\\\\\r\\\r\
    \n    \\n    subject=\\\"[\\\$nome] Link \\\$operadora \\\$status - \\\$dnsTeste\\\" \\\\\\r\\\r\
    \n    \\n    body=\\\"Link \\\$operadora \\\$status - \\\$dnsTeste - \\\$data - \\\$hora\\\\r\\\\nSistema Normalizado Link 2 OK !\\\"\"\r\
    \n\r\
    \n# Teste 2 WAN2\r\
    \n/tool netwatch add comment=\"Teste 2 do Link 2\" disabled=yes \\\r\
    \n    host=\$dnsTest2WAN2 interval=2s name=\"LINK2 - Monitoramento 2\" start-delay=5s startup-delay=5s \\\r\
    \n    down-script=\"/log error \\\"LINK2 - Monitoramento 2\\\"\\r\\\r\
    \n    \\n/ip route set [find comment~\\\"SAIDA LINK2\\\"] disable=yes\\r\\\r\
    \n    \\n\\r\\\r\
    \n\\n:local emailDest \\\"system@grupoalbatroz.com.br\\\"\\r\\\r\
    \n    \\n:delay 5s;\\r\\\r\
    \n    \\n:local data [/system clock get date]\\r\\\r\
    \n    \\n:local hora [/system clock get time]\\r\\\r\
    \n    \\n:local nome [/system identity get name]\\r\\\r\
    \n    \\n:local operadora \\\"LINK_SEC\\\"\\r\\\r\
    \n    \\n:local status \\\"DOWN\\\"\\r\\\r\
    \n    \\n\\r\\\r\
    \n    \\n/tool e-mail send to=\\\$emailDest \\\\\\r\\\r\
    \n    \\n    subject=\\\"[\\\$nome] Link \\\$operadora \\\$status - \\\$dnsTeste\\\" \\\\\\r\\\r\
    \n    \\n    body=\\\"Link \\\$operadora \\\$status - \\\$dnsTeste - \\\$data - \\\$hora\\\\r\\\\nTeste 2 Down - Verificar Operadora do Link 2 !\\\"\" \\\r\
    \n    up-script=\"/log warning \\\"LINK2 - Monitoramento 2\\\"\\r\\\r\
    \n    \\n/ip route set [find comment~\\\"SAIDA LINK2\\\"] disable=no\\r\\\r\
    \n    \\n\\r\\\r\
    \n    \\n:delay 5s;\\r\\\r\
    \n    \\n\\r\\\r\
    \n\\n:local emailDest \\\"system@grupoalbatroz.com.br\\\"\\r\\\r\
    \n    \\n:local data [/system clock get date]\\r\\\r\
    \n    \\n:local hora [/system clock get time]\\r\\\r\
    \n    \\n:local nome [/system identity get name]\\r\\\r\
    \n    \\n:local operadora \\\"LINK_SEC\\\"\\r\\\r\
    \n    \\n:local status \\\"UP\\\"\\r\\\r\
    \n    \\n:local dnsTeste \\\"DNS de teste 2 est\\E1 UP\\\"\\r\\\r\
    \n    \\n\\r\\\r\
    \n    \\n/tool e-mail send to=\\\$emailDest \\\\\\r\\\r\
    \n    \\n    subject=\\\"[\\\$nome] Link \\\$operadora \\\$status - \\\$dnsTeste\\\" \\\\\\r\\\r\
    \n    \\n    body=\\\"Link \\\$operadora \\\$status - \\\$dnsTeste - \\\$data - \\\$hora\\\\r\\\\nTeste 1 Down - Aten\\E7\\E3o Necess\\E1ria !\\\"\"\r\
    \n\r\
    \n\r\
    \n:log warning \"Instalador conclu\EDdo\"\r\
    \n"
/system script add comment="Script de full drop - Ativa queue e drops de input /output e accept no firewall" dont-require-permissions=no name=FULL_DROP owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#############################################\r\
    \n# ATIVAR SIMPLE QUEUES COM NOME \"IGOR 3k\"\r\
    \n#############################################\r\
    \n\r\
    \n:foreach q in=[/queue simple find where name=\"IGOR 3k\"] do={\r\
    \n    /queue simple enable \$q\r\
    \n    :log info (\"Simple Queue ativada: \" . [/queue simple get \$q name])\r\
    \n}\r\
    \n\r\
    \n#############################################\r\
    \n# ATIVAR FIREWALL FILTER - FULL DROP DHCP\r\
    \n#############################################\r\
    \n\r\
    \n:foreach f in=[/ip firewall filter find where comment~\"FULL DROP - DHCP\"] do={\r\
    \n    /ip firewall filter enable \$f\r\
    \n    :log warning (\"Firewall Filter ativada: \" . [/ip firewall filter get \$f comment])\r\
    \n}\r\
    \n\r\
    \n#############################################\r\
    \n# ATIVAR FIREWALL FILTER - FULL FUCKING WHOLE DROP\r\
    \n#############################################\r\
    \n\r\
    \n:foreach f in=[/ip firewall filter find where comment~\"FULL FUCKING WHOLE DROP\"] do={\r\
    \n    /ip firewall filter enable \$f\r\
    \n    :log warning (\"Firewall Filter ativada: \" . [/ip firewall filter get \$f comment])\r\
    \n}\r\
    \n\r\
    \n#############################################\r\
    \n# DESATIVAR SCHEDULER \"guests\"\r\
    \n#############################################\r\
    \n\r\
    \n:foreach s in=[/system scheduler find where name=\"guests\"] do={\r\
    \n    /system scheduler enable \$s\r\
    \n    :log warning (\"Scheduler ativado: \" . [/system scheduler get \$s name])\r\
    \n}\r\
    \n\r\
    \n"
/system script add comment="Script de full access- Desativa queue e drops de input /output e accept no firewall" dont-require-permissions=no name=FULL_OPEN owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#############################################\r\
    \n# DESATIVAR SIMPLE QUEUES COM NOME \"IGOR 3k\"\r\
    \n#############################################\r\
    \n\r\
    \n:foreach q in=[/queue simple find where name=\"IGOR 3k\"] do={\r\
    \n    /queue simple disable \$q\r\
    \n    :log info (\"Simple Queue desativada: \" . [/queue simple get \$q name])\r\
    \n}\r\
    \n\r\
    \n#############################################\r\
    \n# DESATIVAR FIREWALL FILTER - FULL DROP DHCP\r\
    \n#############################################\r\
    \n\r\
    \n:foreach f in=[/ip firewall filter find where comment~\"FULL DROP - DHCP\"] do={\r\
    \n    /ip firewall filter disable \$f\r\
    \n    :log warning (\"Firewall Filter desativada: \" . [/ip firewall filter get \$f comment])\r\
    \n}\r\
    \n\r\
    \n#############################################\r\
    \n# DESATIVAR FIREWALL FILTER - FULL FUCKING WHOLE DROP\r\
    \n#############################################\r\
    \n\r\
    \n:foreach f in=[/ip firewall filter find where comment~\"FULL FUCKING WHOLE DROP\"] do={\r\
    \n    /ip firewall filter disable \$f\r\
    \n    :log warning (\"Firewall Filter desativada: \" . [/ip firewall filter get \$f comment])\r\
    \n}\r\
    \n\r\
    \n#############################################\r\
    \n# DESATIVAR SCHEDULER \"guests\"\r\
    \n#############################################\r\
    \n\r\
    \n:foreach s in=[/system scheduler find where name=\"guests\"] do={\r\
    \n    /system scheduler disable \$s\r\
    \n    :log warning (\"Scheduler desativado: \" . [/system scheduler get \$s name])\r\
    \n}\r\
    \n\r\
    \n\r\
    \n"
/system script add comment="mataRDP - VERIFICAR" dont-require-permissions=no name=mataRDP owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/ip firewall nat\r\
    \n:foreach r in=[find where comment=\"TS HK - Filiais\"] do={\r\
    \n    disable \$r\r\
    \n}\r\
    \n\r\
    \n#/ip firewall filter\r\
    \n#add chain=input protocol=tcp dst-port=3389 action=drop comment=\"DROP RDP entrada 3389\"\r\
    \n\r\
    \n#/ip firewall filter\r\
    \n#add chain=forward protocol=tcp dst-port=3389 action=drop comment=\"DROP RDP TCP 3389\"\r\
    \n#add chain=forward protocol=udp dst-port=3389 action=drop comment=\"DROP RDP UDP 3389\"\r\
    \n"
/system script add dont-require-permissions=no name=0_un owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/queue simple disable [find name=\"rede_toda\"]\r\
    \n/queue simple disable [find name=\"rede_dir\"]\r\
    \n\r\
    \n/ip dhcp-server lease set [/ip dhcp-server lease find where address=192.168.1.4] block-access=no\r\
    \n/ip dhcp-server lease set [/ip dhcp-server lease find where mac-address=00:0A:F7:64:06:D1] block-access=no\r\
    \n\r\
    \n/ip dhcp-server lease set [/ip dhcp-server lease find where address=192.168.1.5] block-access=no\r\
    \n/ip dhcp-server lease set [/ip dhcp-server lease find where mac-address=F8:BC:12:55:63:00] block-access=no"
/system script add dont-require-permissions=no name=0_bl owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/queue simple enable [find name=\"rede_toda\"]\r\
    \n/queue simple enable [find name=\"rede_dir\"]\r\
    \n/ip dhcp-server lease set [/ip dhcp-server lease find where address=192.168.1.4] block-access=yes\r\
    \n/ip dhcp-server lease set [/ip dhcp-server lease find where mac-address=00:0A:F7:64:06:D1] block-access=yes\r\
    \n\r\
    \n/ip dhcp-server lease set [/ip dhcp-server lease find where address=192.168.1.5] block-access=yes\r\
    \n/ip dhcp-server lease set [/ip dhcp-server lease find where mac-address=F8:BC:12:55:63:00] block-access=yes"
/tool bandwidth-server set authenticate=no enabled=no
/tool e-mail set certificate-verification=no from=tigrupoalbatroz@gmail.com password=mrjcvgnnppszotwi port=465 server=smtp.gmail.com tls=yes user=tigrupoalbatroz
/tool graphing resource add
/tool mac-server set allowed-interface-list=LAN
/tool mac-server mac-winbox set allowed-interface-list=LAN
/tool netwatch add comment="Teste 1 do Link 1" disabled=no down-script="/log error \"LINK1 - Monitoramento 1\"\r\
    \n/ip route set [find comment~\"SAIDA LINK1\"] disable=yes\r\
    \n\r\
    \n:local emailDest \"system@grupoalbatroz.com.br\"\r\
    \n:local data [/system clock get date]\r\
    \n:local hora [/system clock get time]\r\
    \n:local nome [/system identity get name]\r\
    \n:local operadora \"LINK_PRI\"\r\
    \n:local status \"DOWN\"\r\
    \n:local dnsTeste \"Teste 1 esta DOWN\"\r\
    \n\r\
    \n/tool e-mail send to=\$emailDest \\\r\
    \n    subject=\"[\$nome] Link \$operadora \$status - \$dnsTeste\" \\\r\
    \n    body=\"Link \$operadora \$status - \$dnsTeste - \$data - \$hora\\r\\nTeste 1 Down - Aten\E7\E3o Necess\E1ria !\"" host=1.1.1.10 http-codes="" interval=2s name="LINK1 - Monitoramento 1" start-delay=5s startup-delay=5s test-script="" type=icmp up-script="/log warning \"LINK_PRI UP- Monitoramento 1\"\r\
    \n/ip route set [find comment~\"SAIDA LINK1\"] disable=no\r\
    \n/ppp active remove [find]\r\
    \n\r\
    \n:delay 5s;\r\
    \n\r\
    \n:local emailDest \"system@grupoalbatroz.com.br\"\r\
    \n:local data [/system clock get date]\r\
    \n:local hora [/system clock get time]\r\
    \n:local nome [/system identity get name]\r\
    \n:local operadora \"LINK_PRI\"\r\
    \n:local status \"UP\"\r\
    \n:local dnsTeste \"Teste 1 esta UP\"\r\
    \n\r\
    \n/tool e-mail send to=\$emailDest \\\r\
    \n    subject=\"[\$nome] Link \$operadora \$status - \$dnsTeste\" \\\r\
    \n    body=\"Link \$operadora \$status - \$dnsTeste - \$data - \$hora\\r\\nSistema Normalizado \$operadora OK !\""
/tool netwatch add comment="Teste 2 do Link 1" disabled=no down-script="/log error \"LINK1 - Monitoramento 2\"\r\
    \n/ip route set [find comment~\"SAIDA LINK1\"] disable=yes\r\
    \n\r\
    \n:local emailDest \"system@grupoalbatroz.com.br\"\r\
    \n:delay 5s;\r\
    \n:local data [/system clock get date]\r\
    \n:local hora [/system clock get time]\r\
    \n:local nome [/system identity get name]\r\
    \n:local operadora \"LINK_PRI\"\r\
    \n:local status \"DOWN\"\r\
    \n\r\
    \n/tool e-mail send to=\$emailDest \\\r\
    \n    subject=\"[\$nome] Link \$operadora \$status - \$dnsTeste\" \\\r\
    \n    body=\"Link \$operadora \$status - \$dnsTeste - \$data - \$hora\\r\\nLink 1 Down - Verificar Operadora do Link 1 !\"" host=198.41.0.4 http-codes="" interval=2s name="LINK1 - Monitoramento 2" start-delay=5s startup-delay=5s test-script="" type=icmp up-script="/log warning \"LINK1 - Monitoramento 2\"\r\
    \n/ip route set [find comment~\"SAIDA LINK1\"] disable=no\r\
    \n\r\
    \n:local emailDest \"system@grupoalbatroz.com.br\"\r\
    \n:delay 5s;\r\
    \n\r\
    \n:local data [/system clock get date]\r\
    \n:local hora [/system clock get time]\r\
    \n:local nome [/system identity get name]\r\
    \n:local operadora \"LINK_PRI\"\r\
    \n:local status \"UP\"\r\
    \n:local dnsTeste \"Teste 2 esta UP\"\r\
    \n\r\
    \n/tool e-mail send to=\$emailDest \\\r\
    \n    subject=\"[\$nome] Link \$operadora \$status - \$dnsTeste\" \\\r\
    \n    body=\"Link \$operadora \$status - \$dnsTeste - \$data - \$hora\\r\\nTeste 1 Down - Aten\E7\E3o Necess\E1ria !\""
/tool netwatch add comment="Teste 1 do Link 2" disabled=no down-script="/log error \"LINK2 - Monitoramento 1\"\r\
    \n/tool netwatch set [find name=\"LINK2 - Monitoramento 2\"] disable=no\r\
    \n\r\
    \n:local emailDest \"system@grupoalbatroz.com.br\"\r\
    \n:local data [/system clock get date]\r\
    \n:local hora [/system clock get time]\r\
    \n:local nome [/system identity get name]\r\
    \n:local operadora \"LINK_SEC\"\r\
    \n:local status \"DOWN\"\r\
    \n:local dnsTeste \"Teste 1 esta DOWN\"\r\
    \n\r\
    \n/tool e-mail send to=\$emailDest \\\r\
    \n    subject=\"[\$nome] Link \$operadora \$status - \$dnsTeste\" \\\r\
    \n    body=\"Link \$operadora \$status - \$dnsTeste - \$data - \$hora\\r\\nTeste 1 Down - Aten\E7\E3o Necess\E1ria !\"" host=1.1.1.11 http-codes="" interval=2s name="LINK2 - Monitoramento 1" start-delay=5s startup-delay=5s test-script="" type=icmp up-script="/log warning \"LINK2 - Monitoramento 1\"\r\
    \n/tool netwatch set [find name=\"LINK2 - Monitoramento 2\"] disable=yes\r\
    \n/ip route set [find comment~\"SAIDA LINK2\"] disable=no\r\
    \n/ppp active remove [find]\r\
    \n\r\
    \n:local emailDest \"system@grupoalbatroz.com.br\"\r\
    \n:local data [/system clock get date]\r\
    \n:local hora [/system clock get time]\r\
    \n:local nome [/system identity get name]\r\
    \n:local operadora \"LINK_SEC\"\r\
    \n:local status \"UP\"\r\
    \n:local dnsTeste \"Teste 1 esta UP\"\r\
    \n\r\
    \n/tool e-mail send to=\$emailDest \\\r\
    \n    subject=\"[\$nome] Link \$operadora \$status - \$dnsTeste\" \\\r\
    \n    body=\"Link \$operadora \$status - \$dnsTeste - \$data - \$hora\\r\\nSistema Normalizado Link 2 OK !\""
/tool netwatch add comment="Teste 2 do Link 2" disabled=yes down-script="/log error \"LINK2 - Monitoramento 2\"\r\
    \n/ip route set [find comment~\"SAIDA LINK2\"] disable=yes\r\
    \n\r\
    \n:local emailDest \"system@grupoalbatroz.com.br\"\r\
    \n:delay 5s;\r\
    \n:local data [/system clock get date]\r\
    \n:local hora [/system clock get time]\r\
    \n:local nome [/system identity get name]\r\
    \n:local operadora \"LINK_SEC\"\r\
    \n:local status \"DOWN\"\r\
    \n\r\
    \n/tool e-mail send to=\$emailDest \\\r\
    \n    subject=\"[\$nome] Link \$operadora \$status - \$dnsTeste\" \\\r\
    \n    body=\"Link \$operadora \$status - \$dnsTeste - \$data - \$hora\\r\\nTeste 2 Down - Verificar Operadora do Link 2 !\"" host=202.12.27.33 http-codes="" interval=2s name="LINK2 - Monitoramento 2" start-delay=5s startup-delay=5s test-script="" type=icmp up-script="/log warning \"LINK2 - Monitoramento 2\"\r\
    \n/ip route set [find comment~\"SAIDA LINK2\"] disable=no\r\
    \n\r\
    \n:delay 5s;\r\
    \n\r\
    \n:local emailDest \"system@grupoalbatroz.com.br\"\r\
    \n:local data [/system clock get date]\r\
    \n:local hora [/system clock get time]\r\
    \n:local nome [/system identity get name]\r\
    \n:local operadora \"LINK_SEC\"\r\
    \n:local status \"UP\"\r\
    \n:local dnsTeste \"DNS de teste 2 est\E1 UP\"\r\
    \n\r\
    \n/tool e-mail send to=\$emailDest \\\r\
    \n    subject=\"[\$nome] Link \$operadora \$status - \$dnsTeste\" \\\r\
    \n    body=\"Link \$operadora \$status - \$dnsTeste - \$data - \$hora\\r\\nTeste 1 Down - Aten\E7\E3o Necess\E1ria !\""
/tool romon set enabled=yes
/tool sniffer set file-name=wire.cap
