
SSH_IP="192.168.1.10"

pscp -pw root rtl8192cufw_TMSC.bin root@$SSH_IP:/lib/firmware/rtlwifi
pscp -pw root  interfaces  root@$SSH_IP:/etc/network/interfaces
pscp -pw root  iwconfig/ifrename  root@$SSH_IP:/sbin/ifrename
pscp -pw root  iwconfig/iwconfig  root@$SSH_IP:/sbin/iwconfig
pscp -pw root  iwconfig/iwlist  root@$SSH_IP:/sbin/iwlist
pscp -pw root  iwconfig/iwpriv  root@$SSH_IP:/sbin/iwpriv

pscp -pw root  wpa_supplicant/wpa_cli   root@$SSH_IP:/sbin/wpa_cli
pscp -pw root  wpa_supplicant/wpa_passphrase   root@$SSH_IP:/sbin/wpa_passphrase
pscp -pw root  wpa_supplicant/wpa_supplicant   root@$SSH_IP:/sbin/wpa_supplicant
pscp -pw root  wpa_supplicant.conf   root@$SSH_IP:/etc/wpa_supplicant.conf

