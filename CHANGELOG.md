# Changelog

**[Русский](#русский) · [English](#english)**

---

## Русский

### 2026-10-07 — OrangeFox R12.0
Первый выпуск. База: OrangeFox `fox_12.1` (R12.0), ядро и DTB от прошивки A12, заголовок образа как у R11.3 (os_version 99.87.36, patch level 2099-12).
- Рекавери больше не переразмечает каталоги пользователя в `/data` по правилам Android 12: в Android 11 после захода в рекавери продолжают работать Bluetooth и профили ART.
- `adb reboot` загружает систему: adbd перезагружает через init с пустой причиной, а не через `/system/bin/reboot` с причиной `shell`, после которой загрузчик Samsung снова запускает рекавери.
- Убрана задержка 5 с на каждое касание: виброотклик ждал сервис вибромотора, которого нет.
- Расшифровка: в рамдиск добавлены VINTF-манифест системы (без него keystore2 не регистрируется и падает) и библиотеки, нужные вендорным модулям (QSEECom, display config, libnetutils).
- Удалены модули HAL батареи Samsung: они требуют вендорную `libutils` и в рекавери не загружались. Заряд показывается через стандартную реализацию.
- Добавлены lptools и lpdump.

---

## English

### 2026-10-07 — OrangeFox R12.0
First release. Base: OrangeFox `fox_12.1` (R12.0), kernel and DTB from the A12 firmware, image header as in R11.3 (os_version 99.87.36, patch level 2099-12).
- The recovery no longer relabels the user directories on `/data` by the Android 12 rules: Bluetooth and ART profiles keep working on Android 11 after a recovery visit.
- `adb reboot` boots the system: adbd reboots through init with an empty reason instead of `/system/bin/reboot` with the reason `shell`, after which the Samsung bootloader starts recovery again.
- No more 5 s delay on every touch: haptics waited for a vibrator service that does not exist.
- Decryption: the system VINTF manifest is in the ramdisk (without it keystore2 is not registered and aborts), together with the libraries the vendor modules need (QSEECom, display config, libnetutils).
- Samsung health HAL modules removed: they need the vendor `libutils` and never loaded in recovery. Battery status comes from the default implementation.
- lptools and lpdump included.
