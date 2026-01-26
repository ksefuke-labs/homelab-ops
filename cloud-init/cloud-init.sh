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
    qm set $1 --memory 2048 --balloon 1 --cores 2 --cpu host --bios ovmf --machine q35
    #Set boot device to new file
    qm set $1 --scsi0 ${storage}:0,import-from="$(pwd)/$3",discard=on
    #Set scsi hardware as default boot disk using virtio scsi single
    qm set $1 --boot order=scsi0 --scsihw virtio-scsi-single
    #Enable Qemu guest agent in case the guest has it available
    qm set $1 --agent enabled=1,fstrim_cloned_disks=1
    #Add cloud-init device
    qm set $1 --ide2 ${storage}:cloudinit
    #add efi disk
    qm set $1 --efidisk0 ${storage}:0,pre-enrolled-keys=0
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
export username=echo

#Name of your storage
export storage=pve01-p1lp

## Almalinux
#Almalinux 10
#create_template 300 "alma10-sata" "AlmaLinux-10-x86_64_v2.qcow2"
#create_template 301 "alma10-nvme" "AlmaLinux-10-x86_64_v2.qcow2"

## Arch Linux
create_template 304 "arch-linux-sata" "Arch-Linux-x86_64-cloudimg.qcow2"
#create_template 305 "arch-linux-nvme" "Arch-Linux-x86_64-cloudimg.qcow2"

## Debian
#Bookworm (12) (stable)
#create_template 306 "debian12-sata" "Debian-12-nocloud-amd64.qcow2"
#create_template 307 "debian12-nvme" "Debian-12-nocloud-amd64.qcow2"

#Trixie (13) (stable)
#create_template 308 "debian-13-sata" "Debian-13-nocloud-amd64.qcow2"
#create_template 309 "debian-13-nvme" "Debian-13-nocloud-amd64.qcow2"

## Fedora Cloud
#Fedora 42 
#create_template 312 "fedora-42-sata" "Fedora-Cloud-Base-Generic-42-1.1.x86_64.qcow2"
#create_template 313 "fedora-42-nvme" "Fedora-Cloud-Base-Generic-42-1.1.x86_64.qcow2"

## Red Hat Linux
#Red Hat Linux 10
#create_template 316 "rhel-10-sata" "RHEL-10.0-x86_64-kvm.qcow2"
#create_template 317 "rhel-10-nvme" "RHEL-10.0-x86_64-kvm.qcow2"

## Rocky Linux
#create_template 320 "rocky-linux-10-sata" "Rocky-10-GenericCloud-Base.latest.x86_64.qcow2"
#create_template 321 "rocky-linux-10-nvme" "Rocky-10-GenericCloud-Base.latest.x86_64.qcow2"

## Ubuntu
#Ubuntu 24.04 (Noble Numbat) LTS
#create_template 324 "ubuntu-24-04-sata" "Ubuntu-24.04-server-cloudimg-amd64.img"
#create_template 325 "ubuntu-24-04-nvme" "Ubuntu-24.04-server-cloudimg-amd64.img"
