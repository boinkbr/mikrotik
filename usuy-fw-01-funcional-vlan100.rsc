# nov/14/2017 18:11:03 by RouterOS 6.40.5
# software id = AA4R-0WHW
#
# model = 1100AHx2
# serial number = 807F078AB0FE
/interface bridge
add name=BR-TRUNK
add name=BR-TRUNK-BOND protocol-mode=none
/interface ethernet
set [ find default-name=ether1 ] name=ether1-vivo
set [ find default-name=ether2 ] name=ether2-informac
set [ find default-name=ether3 ] name=ether3-bonding1
set [ find default-name=ether4 ] mac-address=64:D1:54:4A:E3:02 name=\
    ether4-bonding1
set [ find default-name=ether5 ] name=ether5-bonding2
set [ find default-name=ether6 ] mac-address=64:D1:54:4A:E3:04 name=\
    ether6-bonding2
set [ find default-name=ether7 ] name=ether7-bonding3
set [ find default-name=ether8 ] mac-address=64:D1:54:4A:E3:06 name=\
    ether8-bonding3
set [ find default-name=ether9 ] name=ether9-sisclinica
set [ find default-name=ether10 ] name=ether10-pdc
/interface vlan
add interface=BR-TRUNK-BOND name=vlan100.3 vlan-id=100
add interface=BR-TRUNK-BOND name=vlan101.3 vlan-id=101
add interface=BR-TRUNK-BOND name=vlan102.3 vlan-id=102
/interface bonding
add name=bonding1 slaves=ether3-bonding1,ether4-bonding1
add name=bonding2 slaves=ether5-bonding2,ether6-bonding2
add name=bonding3 slaves=ether7-bonding3,ether8-bonding3
/interface vlan
add disabled=yes interface=bonding1 name=vlan100 vlan-id=100
add disabled=yes interface=bonding2 name=vlan100.1 vlan-id=100
add disabled=yes interface=bonding3 name=vlan100.2 vlan-id=100
add disabled=yes interface=bonding1 name=vlan101 vlan-id=101
add disabled=yes interface=bonding2 name=vlan101.1 vlan-id=101
add disabled=yes interface=bonding3 name=vlan101.2 vlan-id=101
add disabled=yes interface=bonding1 name=vlan102 vlan-id=102
add disabled=yes interface=bonding2 name=vlan102.1 vlan-id=102
add disabled=yes interface=bonding3 name=vlan102.2 vlan-id=102
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool0 ranges=172.16.16.2-172.16.16.254
add name=dhcp_pool1 ranges=172.16.16.2-172.16.16.254
add name=dhcp_pool2 ranges=172.17.16.2-172.17.16.254
add name=dhcp_pool3 ranges=172.18.16.2-172.18.16.254
/ip dhcp-server
add address-pool=dhcp_pool1 disabled=no interface=vlan100.3 name=dhcp1
add address-pool=dhcp_pool2 disabled=no interface=vlan101.3 name=dhcp2
add address-pool=dhcp_pool3 disabled=no interface=vlan102.3 name=dhcp3
/interface bridge filter
add action=accept chain=forward in-bridge=BR-TRUNK-BOND mac-protocol=vlan \
    out-bridge=BR-TRUNK-BOND vlan-id=100
add action=accept chain=forward in-bridge=BR-TRUNK-BOND mac-protocol=vlan \
    out-bridge=BR-TRUNK-BOND vlan-id=101
add action=accept chain=forward in-bridge=BR-TRUNK-BOND mac-protocol=vlan \
    out-bridge=BR-TRUNK-BOND vlan-id=102
/interface bridge port
add bridge=BR-TRUNK-BOND interface=bonding1
add bridge=BR-TRUNK-BOND interface=bonding2
add bridge=BR-TRUNK-BOND interface=bonding3
/ip address
add address=172.16.16.1/24 interface=vlan100.3 network=172.16.16.0
add address=172.17.16.1/24 interface=vlan101.3 network=172.17.16.0
add address=172.18.16.1/24 interface=vlan102.3 network=172.18.16.0
/ip dhcp-client
add dhcp-options=hostname,clientid disabled=no interface=ether1-vivo
add dhcp-options=hostname,clientid interface=ether2-informac
/ip dhcp-server network
add address=172.16.16.0/24 dns-server=172.16.16.1 domain=usuy.local gateway=\
    172.16.16.1
add address=172.17.16.0/24 dns-server=172.17.16.1 domain=usuy.local gateway=\
    172.17.16.1
add address=172.18.16.0/24 dns-server=172.18.16.1 domain=usuy.local gateway=\
    172.18.16.1
/ip dns
set allow-remote-requests=yes servers=8.8.8.8,4.2.2.2
/ip firewall address-list
add address=172.16.16.0/24 list=LAN
add address=172.17.16.0/24 list=LAN
add address=172.18.16.0/24 list=LAN
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1-vivo
add action=masquerade chain=srcnat out-interface=ether2-informac
/system clock
set time-zone-name=America/Sao_Paulo
/system identity
set name=usuy-fw-001
