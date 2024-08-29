Ansipull
========

A simple system bootstrapper and maintainance tool.

* Prerequisites

These scripts require that ansible and any dependencies are installed on the host machine.

* Virtual machine

While these scripts are intende for the maintainance of working machines, support for bootstrapping a virtual machine is included to allow for testing and development.

To partition a new virtual machine using VirtualBox:
 - Create a new virtual machine with an arch LiveCD 
 - Set the networking to use bridge networking. This allows standard remote ssh access to the machine.
 - Enable EFI for the virtual machine. These scripts assume a target with EFI.
 - Attach a clean empty HDD to the first controllers (/dev/sda). The partition playbook makes some basic assumptions about the storage device.

To partition the Virtual Machine:
 - Boot to the LiveCD
 - In the VM set a root password to allow ssh access:
    '''
    passwd
    ''' 
 - Collect the VM ip address with:
    '''
    ip address 
    '''
 - Connect to the VM from the host and add the VM to the list of known hosts.
    '''
    ssh root@<vm-ip-address>
    ansible-playbook bootstrap/partition.yml --user root -i <vm-ip-address>, -k
    '''
 - After partitioning the disk, the script will then go on to run the 'main' bootstrap playbook below

* Bootstapping 

Before running the main bootstrap playbook:
    - Set the remote root password for ssh access
    - Collect the system ip address
    - Set environment variables in 'bootstrap/vars.yml'


To run the bootstrap:
    '''
    ansible-playbook bootstrap/main.yml --user root -i <system-ip-address>, -k
    ''' 

* System Installation



