Ansipull
========

A simple system bootstrapper and maintenance tool.

## Prerequisites

These scripts require that Ansible and any dependencies be installed on the host machine.

## Virtual machine

While these scripts are intended for the maintenance of working machines, support for bootstrapping a virtual machine is included to allow testing and development.

Prerequisites to partition a new virtual hard drive using VirtualBox:
 - Create a new virtual machine with an arch LiveCD 
 - Set the networking to use bridge networking. This allows standard remote SSH access to the machine from the host on the same subnet if running a DHCP server.
 - Enable EFI for the virtual machine. These scripts assume a target with EFI.
 - Attach an empty HDD to the first controllers (/dev/sda). The *partition.yml* playbook makes some basic assumptions about the storage device for testing.
 - Clone the repo and configure any settings in *bootstrap/vars.yml*

To partition the Virtual Machine:
 - Boot to the LiveCD
 - In the VM set a root password to allow SSH access:
```
    passwd
```
 - Collect the VM ip address with:
```
    ip address 
```
 - Connect to the VM from the host and add the VM to the list of known hosts.
```
    ssh root@<vm-ip-address>
```
 - Run the partition playbook on the VM
```
    ansible-playbook bootstrap/partition.yml --user root -i <vm-ip-address>, -k
```
 - After partitioning the disk, the script will then go on to run the *main.yml* bootstrap playbook below

## Bootstapping 

Before running the main bootstrap playbook:
 - On the target machine, boot to an arch LiveCD 
 - Mount your root file system on */mnt* and any other partitons such as */boot*.
 - Clone the repo and configure any settings in *bootstrap/vars.yml*

To run the bootstrap execute:
 - In the live CD target, set a root password to allow SSH access:
```
    passwd
```
 - Collect the VM ip address with:
```
    ip address
```
 - Connect to the VM from the host and add the VM to the list of known hosts.
```
    ssh root@<target-ip-address>
```
 - Run the main playbook on the target
```
    ansible-playbook bootstrap/main.yml --user root -i <target-ip-address>, -k
```   
 - Once completed reboot the target machine.
 
## System Installation

 - Once rebooted login to the bootstrapped target. 
 - You can change the user password with:
```
    passwd
```
 - Next you can either review and update any `system/roles/\<role\>/vars/main.yml` files on the host machine, and then copy the repo to the target machine. This is probably the easiest option:
```
rsync -r <user>@<host>:/path/to/ansipull .
```
 - Or you can clone the repo directly to the target machine and update any `system/roles/\<role\>/vars/main.yml` files:
```
git clone https://github.com/neiltheblue/ansipull
```
- If you pulled the repo using either method onto the target then the install can be run using the following command or you can change `main.yml` to one of the more specific targets:
```
ansible-playbook ansipull/system/main.yml -K
```
- Or to run it with one command:
```
ansible-pull -U https://github.com/neiltheblue/ansipull -K system/main.yml
```
