# EWAOL on Renesas R-Car S4 Starter Kit Documentation

## Status

The baremetal image is working and passing all runtime integration tests.
The virtualization image is under development.

Builds have been performed using Ubuntu 20.04 as host OS.

Artifacts have been tested on R-Car S4 Starter Kit  boards.

## Device
This is the enablement for EWAOL for [Renesas R-Car Starter Kit](https://www.renesas.com/us/en/products/automotive-products/automotive-system-chips-socs/y-ask-rcar-s4-1000base-t-r-car-s4-starter-kit). 

## Build for image
## A. Baremetal
```bash
./build.sh rcar-s4sk baremetal
```
## Installing

Assuming your micro SD card is at ```/dev/mmcblk0```.
```bash
cd build/rcar-s4sk/tmp_baremetal/deploy/images/s4sk
sudo bmaptool copy --bmap ewaol-baremetal-image-s4sk.wic.bmap ewaol-baremetal-image-s4sk.wic /dev/mmcblk0
```

## Serial Console

Configuration 921600  8N1, no flow control.

## Known issues

- virtualization image is under development
