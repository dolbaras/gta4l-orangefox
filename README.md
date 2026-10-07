# OrangeFox Recovery — Galaxy Tab A7 10.4 (SM-T505)

**[Русский](#русский) · [English](#english)** · Прошивки / ROMs: [gta4l-gta4lwifi-roms](https://github.com/dolbaras/gta4l-gta4lwifi-roms)

---

## Русский

OrangeFox R12.0 для Galaxy Tab A7 10.4 LTE (**SM-T505, gta4l**) на прошивке Android 12 (A12, anti-rollback). Рассчитан на установку и обслуживание прошивок на Android 11: [LineageOS 18.1 и PixelExperience Plus](https://github.com/dolbaras/gta4l-gta4lwifi-roms).

### Скачать
Вкладка **[Releases](../../releases)**: образ, архив для Odin, zip для установки из рекавери, md5. История изменений — [CHANGELOG.md](CHANGELOG.md).

### Чем отличается от OrangeFox R11.3
- **Не ломает Android 11 после захода в рекавери.** R11.3 переразмечала каталоги пользователя в `/data` по правилам Android 12, после чего в Android 11 переставали работать Bluetooth и профили ART. Теперь рекавери только подключает ключи шифрования, а каталоги оставляет установленной системе.
- `adb reboot` из рекавери загружает систему, а не снова рекавери.
- Нет задержки на касания: виброотклик выключен, вибромотора у планшета нет.
- Расшифровка `/data` работает с ключами прошивки A12.

### Установка
- **Из рекавери:** установить `OrangeFox-*.zip` или записать образ в раздел Recovery.
- **Из режима Download:** `OrangeFox-*.img.tar` в слот AP программы Odin или `heimdall flash --RECOVERY recovery.img` (heimdall 2.x).

Перезагрузка в систему: меню **Перезагрузка → Система** или `adb reboot`.

### Известные проблемы
- `adb shell reboot` (команда внутри оболочки) возвращает в рекавери: так загрузчик Samsung реагирует на причину перезагрузки `shell`. Используйте меню или `adb reboot`.
- USB и adb появляются примерно через 25 секунд после старта: столько занимают расшифровка и стартовые скрипты OrangeFox.
- SM-T500 (gta4lwifi) не проверялся.

### Сборка
Манифест OrangeFox `fox_12.1` (bootable/recovery `cbcc4f71`, vendor/recovery `cea00ca`):
```bash
cp -r device_samsung_gta4l <fox>/device/samsung/gta4l
git -C <fox>/system/vold apply patches/system_vold.patch
git -C <fox>/packages/modules/adb apply patches/packages_modules_adb.patch
cd <fox> && source build/envsetup.sh && lunch twrp_gta4l-eng && mka recoveryimage
```

### Отзывы
[Issues](../../issues): модель, версия стоковой прошивки, что не работает, лог из `/sdcard/Fox/logs`.

### Дисклеймер
Неофициальная сборка, устанавливаете на свой риск.

---

## English

OrangeFox R12.0 for the Galaxy Tab A7 10.4 LTE (**SM-T505, gta4l**) on the Android 12 firmware (A12, anti-rollback). Made for installing and servicing the Android 11 ROMs: [LineageOS 18.1 and PixelExperience Plus](https://github.com/dolbaras/gta4l-gta4lwifi-roms).

### Download
The **[Releases](../../releases)** tab: image, Odin archive, recovery-flashable zip, md5. History of changes: [CHANGELOG.md](CHANGELOG.md).

### Changes against OrangeFox R11.3
- **Android 11 keeps working after a recovery visit.** R11.3 relabelled the user directories on `/data` by the Android 12 rules, after which Bluetooth and ART profiles broke on Android 11. The recovery now only installs the encryption keys and leaves the directories to the installed system.
- `adb reboot` from recovery boots the system instead of recovery again.
- No touch delay: haptics are off, the tablet has no vibration motor.
- `/data` decryption works with the A12 firmware keys.

### Install
- **From recovery:** install `OrangeFox-*.zip`, or flash the image to the Recovery partition.
- **From Download mode:** `OrangeFox-*.img.tar` in the AP slot of Odin, or `heimdall flash --RECOVERY recovery.img` (heimdall 2.x).

Reboot to the system: **Reboot → System** in the menu, or `adb reboot`.

### Known issues
- `adb shell reboot` (the command inside a shell) returns to recovery: this is how the Samsung bootloader treats the reboot reason `shell`. Use the menu or `adb reboot`.
- USB and adb come up about 25 seconds after start, the time decryption and the OrangeFox startup scripts take.
- SM-T500 (gta4lwifi) has not been tested.

### Build
OrangeFox `fox_12.1` manifest (bootable/recovery `cbcc4f71`, vendor/recovery `cea00ca`):
```bash
cp -r device_samsung_gta4l <fox>/device/samsung/gta4l
git -C <fox>/system/vold apply patches/system_vold.patch
git -C <fox>/packages/modules/adb apply patches/packages_modules_adb.patch
cd <fox> && source build/envsetup.sh && lunch twrp_gta4l-eng && mka recoveryimage
```

### Feedback
[Issues](../../issues): model, stock firmware version, what fails, the log from `/sdcard/Fox/logs`.

### Disclaimer
Unofficial build, use at your own risk.
