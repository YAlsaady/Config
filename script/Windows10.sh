#!/bin/sh


/usr/bin/virsh start Windows10
/usr/bin/virt-manager --connect=qemu:///session --show-domain-console Windows10
