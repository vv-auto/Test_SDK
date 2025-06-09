# EWAOL on RockPi4B Documentation

## Status

The ledge-secure-qemuarm64 baremetal image is working on RockPi4B.

## Building

```bash
./build.sh ledge-secure-qemuarm64 baremetal
```

The image depends on the Trusted Substrate firmware, which can be built as
follows:

```bash
git clone https://gitlab.com/Linaro/trustedsubstrate/meta-ts.git
cd meta-ts
kas build ci/rockpi4b.yml
```

## Installing

Write the firmware to a microSD card and the root FS to a USB stick.

Assuming your USB stick is at ```/dev/sda```:

```bash
sudo dd if=build/ledge-secure-qemuarm64/tmp_baremetal/deploy/images/ledge-secure-qemuarm64/ewaol-baremetal-image-ledge-secure-qemuarm64.wic of=/dev/sda bs=1M status=progress
sync

```

Assuming your SD card for Trusted Substrate firmware is at ```/dev/mmcblk0```:

```bash
cd /path/to/meta-ts
sudo dd if=build/tmp/deploy/images/rockpi4b/ts-firmware-rockpi4b.wic of=/dev/mmcblk0

```

## Serial Console

Configuration 1500000 8N1, no flow control.

Details for attaching a USB UART cable can be found
[here](https://wiki.radxa.com/Rockpi4/dev/serial-console).

## First boot

Put the SD card and the USB stick into the RockPi4B board.

Ensure you have a USB-C PD power supply (otherwise random failures will occur
under load). Connect the serial console as mentioned above (note the unusual
baud rate of 1500000).

On first boot you will need to break into U-Boot prompt (press ```<Return>```
repeatedly during boot) and set the EFI boot option:

```
efidebug boot add -b 1 BootLedge usb 0:1 efi/boot/bootaa64.efi -i usb 0:1 ledge-initramfs.rootfs.cpio.gz -s 'console=ttyS2,1500000 console=tty0 root=UUID=6091b3a4-ce08-3020-93a6-f755a22ef03b rootwait panic=60'
efidebug boot order 1
```

Reboot the board, now you should boot into EWAOL. Username: ```ewaol``` with
no password. Note: the first boot will take quite some time.

## OP-TEE tests

The OP-TEE regression test suite may either be run as root or with a user
member of the ```teeclnt``` group.

```bash
sudo xtest
```

or

```bash
sudo usermod -a -G teeclnt ewaol
# Log out and back in again as 'ewaol'
xtest
```

## Parsec tests

### OP-TEE PKCS#11 provider

To use Parsec with the OP-TEE PKCS#11 Trusted Application, append the following
to ```/etc/parsec/config.toml```. OP-TEE and the PKCS#11 TA are part of the
Trusted Substrate firmware.

```
[[provider]]
name = "pkcs11-optee"
provider_type = "Pkcs11"
key_info_manager = "sqlite-manager"
library_path = "/usr/lib/libckteec.so.0"
```

Add the ```parsec``` user to the ```teeclnt`` group and restart the Parsec
service.

```bash
sudo usermod -a -G teeclnt parsec
sudo systemctl restart parsec.service
```


### Microsoft fTPM provider

To use Parsec with the Microsoft Firmware TPM (fTPM), append the following to 
```/etc/parsec/config.toml```. fTPM is an OP-TEE Trusted Application and is
part of the Trusted Substrate firmware. It registers as a standard TPM with the
Linux kernel.

```
[[provider]]
name = "tpm-provider"
provider_type = "Tpm"
key_info_manager = "sqlite-manager"
tcti = "device"
owner_hierarchy_auth = ""
```

Restart the Parsec service:

```bash
sudo systemctl restart parsec.service
```

### Running the tests

Making sure the PKCS#11 and TPM providers are registered properly:

```bash
parsec-tool list-providers
```

Running the Parsec tests:

```bash
parsec-cli-tests.sh
```

## Known issues

None.
