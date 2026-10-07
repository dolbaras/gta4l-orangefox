#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 The TWRP Open Source Project
#

LOCAL_PATH := device/samsung/gta4l

# Inherit from common AOSP config
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Partitions
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Product characteristics
PRODUCT_CHARACTERISTICS := tablet

# Rootdir
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# qcom decryption
PRODUCT_PACKAGES_ENG += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Dependencies of the vendor blobs in recovery/root/vendor: the QSEECom HAL
# (keymaster/gatekeeper) needs the HIDL memory libraries, libsecureui needs
# display config and libdsutils needs libnetutils.
RECOVERY_SYSTEM_LIBS := \
    android.hidl.allocator@1.0 \
    android.hidl.memory@1.0 \
    android.hidl.memory.token@1.0 \
    libdmabufheap \
    libhidlmemory \
    libion \
    libnetutils

RECOVERY_SYSTEM_EXT_LIBS := \
    vendor.display.config@1.0 \
    vendor.display.config@2.0

TARGET_RECOVERY_DEVICE_MODULES += \
    $(RECOVERY_SYSTEM_LIBS) \
    $(RECOVERY_SYSTEM_EXT_LIBS) \
    recovery_system_manifest.xml \
    recovery_task_profiles.json

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(foreach lib,$(RECOVERY_SYSTEM_LIBS),$(TARGET_OUT_SHARED_LIBRARIES)/$(lib).so) \
    $(foreach lib,$(RECOVERY_SYSTEM_EXT_LIBS),$(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/$(lib).so)
