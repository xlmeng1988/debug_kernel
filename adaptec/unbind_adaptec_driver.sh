#!/bin/bash
set -ex
vendor_id=9005
device_id=$(lspci -d ${vendor_id}: -n | cut -d' ' -f3 | cut -d: -f2)
slot=$(lspci -d ${vendor_id}: -n | cut -d' ' -f1)

echo "Current SCSI devices: "
lsscsi

# unbind driver and device
echo "unbind current device: 0000:${slot} with driver"
echo 0000:${slot} > /sys/bus/pci/devices/0000:${slot}/driver/unbind

echo "Now, Current SCSI devices: "
lsscsi
