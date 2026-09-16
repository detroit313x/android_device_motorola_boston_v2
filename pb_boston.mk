$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
$(call inherit-product, device/motorola/boston/device.mk)

PRODUCT_NAME := pb_boston
PRODUCT_DEVICE := boston
PRODUCT_BRAND := Motorola
PRODUCT_MODEL := Motorola Boston 5G (2024)
PRODUCT_MANUFACTURER := Motorola

PB_BUILD_TYPE := Official
TW_DEVICE_VERSION := 4.0