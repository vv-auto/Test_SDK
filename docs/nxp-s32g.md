# EWAOL on NXP-S32G Documentation

## Status

The baremetal image is working and passing all runtime integration tests.

The virtualization image is partially passing the runtime integration tests.

Builds have been performed using Ubuntu 20.04 / 22.04 as host OS.

Artifacts have been tested on s32g399ardb3 boards.

## Building

```bash
./build.sh nxp-s32g baremetal
# or similarly for the virtualization image
./build.sh nxp-s32g virtualization
```

## Installing

Assuming your SD card is at ```/dev/mmcblk0```.

```bash
# for s32g399ardb3 board
sudo dd if=build/nxp-s32g/tmp_baremetal/deploy/images/s32g399ardb3/ewaol-baremetal-image-s32g399ardb3.sdcard of=/dev/mmcblk0 bs=4M status=progress oflag=sync
# or similarly for the virtualization image
sudo dd if=build/nxp-s32g/tmp_virtualization/deploy/images/s32g399ardb3/ewaol-virtualization-image-s32g399ardb3.sdcard of=/dev/mmcblk0 bs=4M status=progress oflag=sync
```

## Serial Console

Configuration 115200 8N1, no flow control.

## Known issues

- on the virtualization image, some of the runtime integration tests fail with either timeout or out-of-memory errors
