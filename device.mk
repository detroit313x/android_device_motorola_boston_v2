LOCAL_PATH := device/motorola/boston

PRODUCT_PACKAGES += android.hardware.fastboot@1.0-impl fastbootd qcom_decrypt
PRODUCT_COPY_FILES += $(LOCAL_PATH)/recovery/root/init.recovery.qcom.rc:recovery/root/init.recovery.qcom.rc