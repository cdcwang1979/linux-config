#T450 Ubuntu
if [ -d"/opt/petatlinux" ]; then
	source '/opt/petalinux/settings.sh'
	echo $PETALINUX
	mount -t vboxsf D_DRIVE /mnt/bdshare/
	mount -t vboxsf software /mnt/software
	#
	cd /mnt/car/carOS/ 
fi

#X230 Ubuntu


