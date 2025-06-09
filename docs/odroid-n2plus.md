# EWAOL on ODroid N2+ Documentation

## Status

The baremetal image is working as far as it has been tested to date.

## Building

```bash
./build.sh odroid-n2plus baremetal
```

## Installing

Assuming your SD card is at ```/dev/mmcblk0```.

```bash
sudo dd if=build/odroid-n2plus/tmp_baremetal/deploy/images/hardkernel-odroidn2plus/ewaol-baremetal-image-hardkernel-odroidn2plus.wic of=/dev/mmcblk0
sync
```

## Serial Console

```bash
#TODO: Not tested yet.  Don't have ODROID UART cable
# HDMI + USB working, used that instead for now
```
## Known issues

- virtualization image not tested