#
# Copyright (C) 2026 PitchBlack Recovery Project
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
$(call inherit-product, device/motorola/boston/device.mk)

PRODUCT_NAME := pb_boston
PRODUCT_DEVICE := boston
PRODUCT_BRAND := Motorola
PRODUCT_MODEL := Motorola Boston
PRODUCT_MANUFACTURER := Motorola

PB_BUILD_TYPE := Official
TW_DEVICE_VERSION := 1.0