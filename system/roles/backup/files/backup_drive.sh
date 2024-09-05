#!/bin/bash                                                                                                        

mkdir -p /tmp/store 
mount /dev/disk/by-label/STORE /tmp/store  
/tmp/store/bin/backup.sh
umount /tmp/store                                                                                                  
rmdir /tmp/store          
