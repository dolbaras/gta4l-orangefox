LOCAL_PATH := $(call my-dir)

# keystore2 registers a VINTF-stable service, which servicemanager accepts only when it
# is declared. libvintf reads the system manifest fragments (keystore2's among them)
# only when /system/etc/vintf/manifest.xml exists, so without it keystore2 aborts in a
# loop and decryption never finishes. Install the framework manifest assembled by the
# build into the recovery ramdisk.
include $(CLEAR_VARS)
LOCAL_MODULE := recovery_system_manifest.xml
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_STEM := manifest.xml
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/system/etc/vintf
LOCAL_PREBUILT_MODULE_FILE := $(TARGET_OUT)/etc/vintf/manifest.xml
include $(BUILD_PREBUILT)

# Task profiles for libprocessgroup, used by init for the services' task_profiles.
include $(CLEAR_VARS)
LOCAL_MODULE := recovery_task_profiles.json
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_STEM := task_profiles.json
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/system/etc
LOCAL_PREBUILT_MODULE_FILE := system/core/libprocessgroup/profiles/task_profiles.json
include $(BUILD_PREBUILT)
