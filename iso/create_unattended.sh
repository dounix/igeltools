#!/bin/bash
# Simple unattended ISO creation for IGEL OS creator iso images.
# no root access, simple
#injects args into grub.conf to create unattended install
#could easily change the ini to control compoents that are installed by default (on 11)

if [[ $# -eq 0 ]] ;then
	echo "usage: $0 [igel iso file from OSC zip]"
	exit 1
fi

for dep in sed xxorriso ; do
	which $dep > /dev/null 2>&1 || (echo missing dependancy $dep; exit 1)
done

bootconf=/tmp/igel.conf
uabootconf=/tmp/uaigel.conf


for file in $* ; do
        rm $bootconf $uabootconf 2> /dev/null
	echo Working on file $file
	#version=$(echo $file | grep -E  [0-9.] )
        xorriso -osirrox on -indev  $file -extract /boot/grub/igel.conf $bootconf
        cat $bootconf | sed "s/timeout=30/timeout=10/;s/default=0/default=1/;s/Verbose Installation + Recovery/Installation (Unattended)/;s/igel_syslog=verbose/quiet osc_unattended=true igel_syslog=quiet/"  > $uabootconf
	newname=$(basename $file|sed s/\.iso/_unattended\.iso/g)
	echo newname is $newname
        xorriso -indev $file -outdev $newname -boot_image any replay -map  $uabootconf /boot/grub/igel.conf -commit
        #rm $bootconf $uabootconf 2> /dev/null
done
