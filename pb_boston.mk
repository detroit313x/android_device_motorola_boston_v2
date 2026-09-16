#
# Copyright (C) 2026 PitchBlack Recovery Project
#

# Inherit from common AOSP / PBRP configs
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# Inherit device configuration
$(call inherit-product, device/motorola/boston/device.mk)

# PBRP Specific Configurations
PRODUCT_NAME := pb_boston
PRODUCT_DEVICE := boston
PRODUCT_BRAND := Motorola
PRODUCT_MODEL := Motorola Boston 5G (2024)
PRODUCT_MANUFACTURER := Motorola

# PBRP Flags & Branding
PB_BUILD_TYPE := Official
TW_DEVICE_VERSION := 4.0