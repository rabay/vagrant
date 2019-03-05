#!/bin/sh

echo "[vagrant]"
VBoxManage.exe list runningvms | cut -d "{" -f1 | sed "s/\"//g" | while read VBOXNAME; do
    IP=$(VBoxManage.exe guestproperty get "$VBOXNAME" /VirtualBox/GuestInfo/Net/1/V4/IP | cut -d":" -f2 | awk '{$1=$1};1' )
    echo "$VBOXNAME ansible_port=22 ansible_host=$IP"
done
echo "[vagrant:vars]"
echo "ansible_connection=ssh"
echo "ansible_user=vagrant"
echo "ansible_ssh_pass=vagrant"
