#!/bin/bash
#author:phx
#date: 2016-12-2
#ver: V1.01

get_char()
{
SAVEDSTTY=`stty -g`
stty -echo
stty cbreak
dd if=/dev/tty bs=1 count=1 2> /dev/null
stty -raw
stty echo
stty $SAVEDSTTY
} 

PRJ_DIR=$(cd `dirname $0`; pwd)
rootfs="none"
cd $PRJ_DIR
#SSH_IP="192.168.1.10"

echo "==========================================================="
echo "1 - build liux "
echo "2 - apps or module build"
echo "3 - download ,sd rooft      ****please plugin sd first!****"
echo "4 - download ,initram rooft ****please plugin sd first!****"
echo "5 - apps or module download"
echo "6 - build and download device tree"
echo "0 - do nothing. exit"
echo "==========================================================="
echo -e "please select:\c"
char=`get_char`
echo $char
if [ $char = "0" ]; then
   rootfs="none"
fi
if [ $char = "1" ]; then
	rootfs="sd"
        cd $PRJ_DIR	
	petalinux-build
	cd images/linux
        rm -rf build/linux/rootfs/targetroot/init
	petalinux-package --boot --fsbl zynq_fsbl.elf --fpga Main_P_wrapper.bit --u-boot --force
	petalinux-package --image -c rootfs --format initramfs
fi 

if [ $char = "2" ]; then
        rootfs="none"
	if [ $# -lt 1 ]; then
	    echo "error.. please add app or module's name as an arg"
	    char=99
        else
            if [ -x components/modules/$1 ] || [ -x components/apps/$1 ]; then
	         petalinux-build -c rootfs/$1  
             else
	    	 echo "error.. can't find $1"
	    	 char=99 
            fi                   
	fi;
fi

if [ $char = "3" ]; then
    rootfs="sd"
fi
if [ $char = "4" ]; then
    rootfs="initram"
fi
if [ $char = "5" ]; then
    rootfs="module"
fi
if [ $char = "6" ]; then
    petalinux-build -c device-tree
    pscp -pw root images/linux/system.dtb  root@$SSH_IP:/media
    echo "*****has been downloaded to $SSH_IP:/media*****"
    rootfs="none"
fi
#=====================================================================================================

if [ $char = "1" ]; then  
   echo "======   please plugin sd first!  =============="
   echo "1 - download linux rootfs(initram mode)"
   echo "2 - download linux rootfs(SD mode)"
   echo "0 - do nothing,exit"
   echo "================================================" 
   echo -e "please select:\c"
   char2=`get_char`  
   echo $char2   
   if [ $char2 = "0" ]; then
	rootfs="none"  
   fi  
   if [ $char2 = "1" ]; then
	rootfs="initram"  
   fi	
   if [ $char2 = "2" ]; then
	rootfs="sd"  
   fi	
fi

if [ $char = "2" ]; then  
	echo "======   please plugin sd first!  =============="
	echo "1 - download"
	echo "0 - do nothing,exit"
	echo "================================================" 
	echo -e "please select:\c"
	char=`get_char`  
	echo $char   
	if [ $char = "1" ]; then
	rootfs="module" 
	else
	rootfs="none" 
	fi  
fi

if [ "$rootfs" = "initram" ] || [ "$rootfs" = "sd" ]; then
        echo "download......"
	cd $PRJ_DIR
	rm -rf /media/BOOT/*
	cp -f images/linux/BOOT.BIN /media/root/BOOT/
	cp -f images/linux/image.ub /media/root/BOOT/
	cp -f images/linux/system.dtb /media/root/BOOT/
	if [ "$rootfs" = "sd" ]; then

		rm -rf /media/root/rootfs/*
		cp -f images/linux/rootfs.cpio /media/root/rootfs/
		cd /media/root/rootfs
		sudo pax -rvf rootfs.cpio
		mkdir /media/root/rootfs/SDCard-config/
		cp -rf /mnt/linux-config/SDCard-config/* /media/root/rootfs/SDCard-config/
		sleep 2s
		umount /media/root/rootfs
	fi
	if [ $char = "initram" ]; then		
	        sleep 2s
	fi	
	umount /media/root/BOOT
	sleep 2s
	eject /dev/sdb
fi

if [ "$rootfs" = "module" ]; then
	 if [ -x components/modules/$1 ]; then
		pscp -pw root build/linux/rootfs/modules/$1/$1.ko root@$SSH_IP:/mnt
		echo "*****has been downloaded to $SSH_IP:/mnt*****"
         elif [ -x components/apps/$1 ]; then
		pscp -pw root build/linux/rootfs/apps/$1/$1 root@$SSH_IP:/bin
		echo "*****has been downloaded to $SSH_IP:/bin*****"
         fi   
fi
cd $PRJ_DIR

echo "========= END ============="

