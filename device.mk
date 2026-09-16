#
# Copyright (C) 2026 PitchBlack Recovery Project
#

LOCAL_PATH := device/motorola/boston

# Enable Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl \
    fastbootd

# Dynamic Partitions & Decryption Storage Tools (Android 12+)
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fsg \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service

# Include Ramdisk Recovery Init Configuration
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/init.recovery.qcom.rc:recovery/root/init.recovery.qcom.rc