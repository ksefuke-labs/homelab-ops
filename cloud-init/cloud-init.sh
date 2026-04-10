#!/bin/bash

#Create template
#args:
# vm_id
# vm_name
# file name in the current directory
function create_template() {
    #Print all of the configuration
    echo "Creating template $2 ($1)"

    #Create new VM
    #Feel free to change any of these to your liking
    qm create $1 --name $2 --ostype l26
    #Set networking to default bridge
    qm set $1 --net0 virtio,bridge=vmbr0,mtu=1
    #Set memory, cpu, type defaults
    #If you are in a cluster, you might need to change cpu type
    qm set $1 --memory 2048 --balloon 1 --cores 2 --cpu host --bios seabios --machine q35
    #Set boot device to new file
    qm set $1 --scsi0 ${storage}:0,import-from="$(pwd)/$3",discard=on
    #Set scsi hardware as default boot disk using virtio scsi single
    qm set $1 --boot order=scsi0 --scsihw virtio-scsi-single
    #Enable Qemu guest agent in case the guest has it available
    qm set $1 --agent enabled=1,fstrim_cloned_disks=1
    #Add cloud-init device
    qm set $1 --ide2 ${storage}:cloudinit
    #add efi disk
    #qm set $1 --efidisk0 ${storage}:0,pre-enrolled-keys=0
    #Set CI ip config
    #IP6 = auto means SLAAC (a reliable default with no bad effects on non-IPv6 networks)
    #IP = DHCP means what it says, so leave that out entirely on non-IPv4 networks to avoid DHCP delays
    qm set $1 --ipconfig0 "ip6=auto,ip=dhcp"
    #Import the ssh keyfile
    qm set $1 --sshkeys ${ssh_keyfile}
    #If you want to do password-based auth instaed
    #Then use this option and comment out the line above
    #qm set $1 --cipassword password
    #Add the user
    qm set $1 --ciuser ${username}
    # Add custom cloud init file
    #qm set $1 --cicustom "vendor=local:snippets/general.yaml"
    #Resize the disk to 8G, a reasonable minimum. You can expand it more later.
    #If the disk is already bigger than 8G, this will fail, and that is okay.
    qm disk resize $1 scsi0 10G
    #Set tags
    qm set $1 --tags 'cloud-init'
    #Make it a template
    qm template $1
}


#Path to your ssh authorized_keys file
#Alternatively, use /etc/pve/priv/authorized_keys if you are already authorized
#on the Proxmox system
export ssh_keyfile=/etc/pve/priv/authorized_keys
#Username to create on VM template
export username=template

#Name of your storage
export storage=pve01-p1lp

## AlmaLinux
# AlmaLinux 10
create_template 900 "almalinux-10" "AlmaLinux-10.x86_64_v2.qcow2"

## Debian
# Trixie (13)
create_template 901 "debian-13" "Debian-13.qcow2"

## Fedora Server
# Fedora Server 43
create_template 902 "fedora-server-43" "Fedora-Server-43-1.6.x86_64.qcow2"

## OpenSUSE
# OpenSUSE Leap 16.0
create_template 903 "opensuse-leap-16" "OpenSUSE-Leap-16.0-Minimal-VM.x86_64-kvm-and-xen.qcow2"
# OpenSUSE Tumbleweed
create_template 904 "opensuse-tumbleweed" "openSUSE-Tumbleweed-Minimal-VM.x86_64-Cloud.qcow2"

## RHEL
# RHEL 10
create_template 905 "rhel-10" "Rhel-10-x86_64.qcow2"

## Rocky Linux
# Rocky Linux 10
create_template 906 "rocky-10" "Rocky-10-GenericCloud-Base.latest.x86_64.qcow2"

## Talos Linux
# Talos Linux 1.12.6
create_template 907 "talos-linux-core" "Talos_1_12_6-core.raw"
create_template 908 "talos-linux-extras" "Talos_1_12_6-extras.raw"

## Ubuntu
# Ubuntu 24.04 (Noble Numbat) LTS
create_template 909 "ubuntu-24-04" "Ubuntu-noble.img"