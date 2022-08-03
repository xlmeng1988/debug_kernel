#!/bin/bash
set -ex
vendor_id=9005
device_id=$(lspci -d ${vendor_id}: -n | cut -d' ' -f3 | cut -d: -f2)
slot=$(lspci -d ${vendor_id}: -n | cut -d' ' -f1)

# register new pci device
echo "register new pci device for vfio-pci"
echo ${vendor_id} ${device_id} > /sys/bus/pci/drivers/vfio-pci/new_id

ls /dev/vfio

echo "Remove aacriad driver..."
rmmod aacraid

reset_method=/sys/bus/pci/devices/0000:${slot}/reset_method
echo "Current reset_method: $(cat ${reset_method})"
echo "Remove FLR reset_method"
echo "bus" > ${reset_method}
cat ${reset_method}
