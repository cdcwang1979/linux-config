#ENTR_DIR=pwd
#PRJ_DIR=$(cd `dirname $0`; pwd)
mkdir -p /lib/firmware
mkdir -p /lib/firmware/rtlwifi/
cp -f  /SDCard-config/wireless/file/rtl8192cufw_TMSC.bin 			/lib/firmware/rtlwifi/rtl8192cufw_TMSC.bin
cp -f  /SDCard-config/wireless/file/interfaces  						/etc/network/interfaces
cp -f  /SDCard-config/wireless/file/iwconfig/ifrename  				/sbin/ifrename
cp -f  /SDCard-config/wireless/file/iwconfig/iwconfig  				/sbin/iwconfig
cp -f  /SDCard-config/wireless/file/iwconfig/iwlist  				/sbin/iwlist
cp -f  /SDCard-config/wireless/file/iwconfig/iwpriv  				/sbin/iwpriv
cp -f  /SDCard-config/wireless/file/iwconfig/libiw.so.29             /lib/libiw.so.29

cp -f  /SDCard-config/wireless/file/wpa_supplicant/wpa_cli   		/sbin/wpa_cli
cp -f  /SDCard-config/wireless/file/wpa_supplicant/wpa_passphrase   	/sbin/wpa_passphrase
cp -f  /SDCard-config/wireless/file/wpa_supplicant/wpa_supplicant   	/sbin/wpa_supplicant
cp -f  /SDCard-config/wireless/file/wpa_supplicant.conf   			/etc/wpa_supplicant.conf

cp -f  /SDCard-config/wireless/file/wpa_startup.sh 					/etc/init.d/wpa_startup.sh
chmod 0755 /etc/init.d/wpa_startup.sh
ln -sf /etc/init.d/wpa_startup.sh /etc/rc5.d/S98wpa_startup

#cd $ENTR_DIR
echo "wifi config finished"