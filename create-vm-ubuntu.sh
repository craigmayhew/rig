#cd to default directory of virtualbox
cd C:\Program Files\Oracle\VirtualBox

#if at any time you want info on your create vm
#vboxmanage showvminfo rig

#list os types, useful if you don't want to use ubuntu as we do in this script
#vboxmanage list ostypes

#create a virtualbox vm and register the vm
vboxmanage createvm -name rig -register

#specifiy network adapter and set boot order
vboxmanage modifyvm "rig" –memory 4096 –vram 64 –acpi on –boot1 dvd –nic1 bridged –bridgeadapter1 eth0

#set correct operating system type
vboxmanage modifyvm "rig" –ostype "Ubuntu_64"

#create 13 2TB disks
vboxmanage createvdi –filename "/vms/rig-root.vdi" –size 2097152 –remember
vboxmanage createvdi –filename "/vms/rig-zfs1.vdi" –size 2097152 –remember
vboxmanage createvdi –filename "/vms/rig-zfs2.vdi" –size 2097152 –remember
vboxmanage createvdi –filename "/vms/rig-zfs3.vdi" –size 2097152 –remember
vboxmanage createvdi –filename "/vms/rig-zfs4.vdi" –size 2097152 –remember
vboxmanage createvdi –filename "/vms/rig-zfs5.vdi" –size 2097152 –remember
vboxmanage createvdi –filename "/vms/rig-zfs6.vdi" –size 2097152 –remember
vboxmanage createvdi –filename "/vms/rig-zfs7.vdi" –size 2097152 –remember
vboxmanage createvdi –filename "/vms/rig-zfs8.vdi" –size 2097152 –remember
vboxmanage createvdi –filename "/vms/rig-zfs9.vdi" –size 2097152 –remember
vboxmanage createvdi –filename "/vms/rig-zfs10.vdi" –size 2097152 –remember
vboxmanage createvdi –filename "/vms/rig-zfs11.vdi" –size 2097152 –remember
vboxmanage createvdi –filename "/vms/rig-zfs12.vdi" –size 2097152 –remember

#add an SATA controller
vboxmanage storagectl "rig" –name "SATA Controller" –add sata
#set disk boot order
vboxmanage modifyvm "rig" –boot1 dvd –hda "/vms/rig-root.vdi" –sata on

#attach root 2TB disks:
vboxmanage storageattach "rig" –storagectl "SATA Controller" –port 0 –device 0 –type hdd –medium "/vms/rig-root.vdi"
#attach 12 2TB disks
vboxmanage storageattach "rig" –storagectl "SATA Controller" –port 1 –device 0 –type hdd –medium "/vms/rig-zfs1.vdi"
vboxmanage storageattach "rig" –storagectl "SATA Controller" –port 2 –device 0 –type hdd –medium "/vms/rig-zfs2.vdi"
vboxmanage storageattach "rig" –storagectl "SATA Controller" –port 3 –device 0 –type hdd –medium "/vms/rig-zfs3.vdi"
vboxmanage storageattach "rig" –storagectl "SATA Controller" –port 4 –device 0 –type hdd –medium "/vms/rig-zfs4.vdi"
vboxmanage storageattach "rig" –storagectl "SATA Controller" –port 5 –device 0 –type hdd –medium "/vms/rig-zfs5.vdi"
vboxmanage storageattach "rig" –storagectl "SATA Controller" –port 6 –device 0 –type hdd –medium "/vms/rig-zfs6.vdi"
vboxmanage storageattach "rig" –storagectl "SATA Controller" –port 7 –device 0 –type hdd –medium "/vms/rig-zfs7.vdi"
vboxmanage storageattach "rig" –storagectl "SATA Controller" –port 8 –device 0 –type hdd –medium "/vms/rig-zfs8.vdi"
vboxmanage storageattach "rig" –storagectl "SATA Controller" –port 9 –device 0 –type hdd –medium "/vms/rig-zfs9.vdi"
vboxmanage storageattach "rig" –storagectl "SATA Controller" –port 10 –device 0 –type hdd –medium "/vms/rig-zfs10.vdi"
vboxmanage storageattach "rig" –storagectl "SATA Controller" –port 11 –device 0 –type hdd –medium "/vms/rig-zfs11.vdi"
vboxmanage storageattach "rig" –storagectl "SATA Controller" –port 12 –device 0 –type hdd –medium "/vms/rig-zfs12.vdi"

#attach the ISO at the 14th port at device 0:
vboxmanage storageattach "rig" –storagectl "SATA Controller" –port 14 –device 0 –type dvddrive –medium "/vms/ubuntu.iso"

vboxmanage modifyvm "rig" –dvd "/vms/ubuntu.iso"

#boot the new vm
vboxmanage startvm "rig"
