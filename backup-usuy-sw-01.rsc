# nov/14/2017 11:27:18 by RouterOS 6.40.5
# software id = 1HBQ-RLXS
#
# model = CRS125-24G-1S
# serial number = 7875068BC0A9
/interface bridge
add name=BR-TRUNK
add name=BR-VID100 protocol-mode=none
add name=BR-VID101 protocol-mode=none
add name=BR-VID102 protocol-mode=none
/interface ethernet
set [ find default-name=ether1 ] name=ether1-bonding1
set [ find default-name=ether2 ] mac-address=6C:3B:6B:D8:B5:CB name=\
    ether2-bonding1
/interface vlan
add disabled=yes interface=BR-TRUNK name=vlan100 vlan-id=100
add interface=BR-VID100 name=vlan100.1 vlan-id=100
add disabled=yes interface=BR-TRUNK name=vlan101 vlan-id=101
add interface=BR-VID101 name=vlan101.1 vlan-id=101
add disabled=yes interface=BR-TRUNK name=vlan102 vlan-id=102
add interface=BR-VID102 name=vlan102.1 vlan-id=102
/interface bonding
add mode=balance-xor name=bonding-2Gbps-LAN slaves=\
    ether1-bonding1,ether2-bonding1
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool0 ranges=172.16.16.40-172.16.16.254
add name=dhcp_pool1 ranges=172.17.16.2-172.17.16.254
add name=dhcp_pool2 ranges=172.18.16.2-172.18.16.254
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=BR-VID100 name=dhcp1
add address-pool=dhcp_pool1 disabled=no interface=BR-VID101 name=dhcp2
add address-pool=dhcp_pool2 disabled=no interface=BR-VID102 name=dhcp3
/interface bridge port
add bridge=BR-VID100 interface=ether10
add bridge=BR-VID100 interface=ether9
add bridge=BR-VID100 interface=ether11
add bridge=BR-VID100 interface=ether12
add bridge=BR-VID101 interface=ether13
add bridge=BR-VID101 interface=ether14
add bridge=BR-VID101 interface=ether15
add bridge=BR-VID101 interface=ether16
add bridge=BR-VID101 interface=ether17
add bridge=BR-VID101 interface=ether18
add bridge=BR-VID102 interface=ether19
add bridge=BR-VID102 interface=ether20
add bridge=BR-VID102 interface=ether21
add bridge=BR-VID102 interface=ether22
add bridge=BR-VID102 interface=ether23
add bridge=BR-VID102 interface=ether24
add bridge=BR-VID100 interface=vlan100.1
add bridge=BR-VID101 interface=vlan101.1
add bridge=BR-VID102 interface=vlan102.1
add bridge=BR-VID100 interface=ether3
add bridge=BR-VID100 interface=ether4
add bridge=BR-VID100 interface=ether5
add bridge=BR-VID100 interface=ether6
add bridge=BR-VID100 interface=ether7
add bridge=BR-VID100 interface=ether8
add bridge=BR-VID101 interface=bonding-2Gbps-LAN
/ip address
add address=172.16.16.2/24 interface=BR-VID100 network=172.16.16.0
add address=172.17.16.2/24 interface=BR-VID101 network=172.17.16.0
add address=172.18.16.2/24 interface=BR-VID102 network=172.18.16.0
/ip dhcp-server network
add address=172.16.16.0/24 dns-server=172.16.16.1 domain=usuy.local gateway=\
    172.16.16.1
add address=172.17.16.0/24 dns-server=172.16.16.1 domain=usuy.local gateway=\
    172.17.16.1
add address=172.18.16.0/24 dns-server=172.16.16.1 domain=usuy.local gateway=\
    172.18.16.1
/ip firewall address-list
add address=172.16.16.0/24 list=vlan100
add address=172.17.16.0/24 list=vlan101
add address=172.18.16.0/24 list=vlan102
/ip firewall filter
add action=drop chain=forward disabled=yes dst-address-list=vlan101 \
    src-address-list=vlan100
add action=drop chain=forward disabled=yes dst-address-list=vlan102 \
    src-address-list=vlan100
add action=drop chain=forward disabled=yes dst-address-list=vlan100 \
    src-address-list=vlan101
add action=drop chain=forward disabled=yes dst-address-list=vlan102 \
    src-address-list=vlan101
add action=drop chain=forward disabled=yes dst-address-list=vlan100 \
    src-address-list=vlan102
add action=drop chain=forward disabled=yes dst-address-list=vlan101 \
    src-address-list=vlan102
/lcd
set default-screen=stats-all
/lcd pin
set pin-number=1979
/system clock
set time-zone-name=America/Sao_Paulo
/system identity
set name=usuy-switch-01
