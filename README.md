# OrangeFox R12.0 for Galaxy Tab A7 10.4 LTE (SM-T505, gta4l)

Device tree and source patches for an OrangeFox build that works with Android 11 ROMs
(LineageOS 18.1, PixelExperience 11) on the Android 12 (A12, anti-rollback) firmware.

## Changes against OrangeFox R11.3 for gta4l

- **/data labels after a recovery visit** (the reason for this build). The recovery's
  vold prepared the per-user directories with Android 12 labels (per-user MLS categories on `/data/user_de/<id>`,
  `user_profile_root_file` on `/data/misc/profiles/cur/<id>`). An Android 11 ROM then
  lost access to them: Bluetooth stopped working and ART profiles broke. The recovery now
  only installs the keys and leaves the storage to the installed system
  (`patches/system_vold.patch`).

Fixes in this tree, needed for the newer OrangeFox source and to keep the device tree
consistent with the hardware:

- **`adb reboot` returned to recovery.** On a debuggable recovery adbd ran
  `/system/bin/reboot`, which reports the reason `shell`; the Samsung bootloader keeps
  booting recovery after a reboot from recovery with a reason it does not know. adbd now
  reboots through init with the requested target (`patches/packages_modules_adb.patch`).
- **5 s delay on every touch.** Haptics waited for an AIDL vibrator service that does not
  exist in recovery; the tablet has no vibration motor (`TW_NO_HAPTICS`).
- **Decryption.** The framework VINTF manifest is installed into the ramdisk: without it
  libvintf ignores the manifest fragments, keystore2 is not declared and aborts. The
  libraries the vendor blobs need are included (HIDL memory for the QSEECom HAL, display
  config, libnetutils).
- Samsung health HAL blobs removed: they need the vendor VNDK `libutils` and never loaded;
  battery status comes from the default implementation.
- Boot image header (os_version 99.87.36, patch level 2099-12) matches R11.3, so keymaster
  accepts the same keys. lptools and lpdump are included.

## Build

OrangeFox `fox_12.1` manifest (bootable/recovery cbcc4f71, vendor/recovery cea00ca).

```
cp -r device_samsung_gta4l <fox>/device/samsung/gta4l
git -C <fox>/system/vold apply patches/system_vold.patch
git -C <fox>/packages/modules/adb apply patches/packages_modules_adb.patch
cd <fox> && source build/envsetup.sh && lunch twrp_gta4l-eng && mka recoveryimage
```

## Install

- From a working recovery: flash `OrangeFox-*.zip`, or flash the image to the Recovery
  partition.
- From Download mode: `OrangeFox-*.img.tar` in the AP slot of Odin, or
  `heimdall flash --RECOVERY recovery.img` (heimdall 2.x).

---

# OrangeFox R12.0 для Galaxy Tab A7 10.4 LTE (SM-T505, gta4l)

Сборка OrangeFox для ROM на Android 11 (LineageOS 18.1, PixelExperience 11) на прошивке
Android 12 (A12, anti-rollback).

Главное отличие от R11.3: заход в рекавери больше не портит метки `/data`, из-за которых
в Android 11 ломались Bluetooth и профили ART.

Исправления в дереве для новой версии OrangeFox:
- `adb reboot` из рекавери загружает систему, а не снова рекавери.
- Нет задержки на касания: виброотклик выключен, вибромотора у планшета нет.
- Расшифровка: добавлен VINTF-манифест (иначе keystore2 падает) и зависимости вендорных
  библиотек.
- Удалены нерабочие blob'ы HAL батареи Samsung.
