#!/usr/bin/env bash
set -e

DEVICE="boston"
OUT_DIR="out/target/product/${DEVICE}"
VENDOR_BOOT_IMG="${OUT_DIR}/vendor_boot.img"

echo "==> Starting PBRP Vendor Boot Build Process for ${DEVICE} (Android 12.0)..."

if [ -z "$ANDROID_BUILD_TOP" ]; then
    echo "[-] Error: ANDROID_BUILD_TOP is not set. Please run 'source build/envsetup.sh' first."
    exit 1
fi

cd "$ANDROID_BUILD_TOP"

echo "==> Cleaning old target output images..."
rm -f "$VENDOR_BOOT_IMG"
rm -rf "${OUT_DIR}/vendor_ramdisk"

echo "==> Invoking AOSP build system for vendorbootimage target..."
source build/envsetup.sh
lunch "pb_${DEVICE}-userdebug"

mka vendorbootimage -j$(nproc --all)

if [ -f "$VENDOR_BOOT_IMG" ]; then
    echo "[+] SUCCESS: Generated vendor_boot.img at ${VENDOR_BOOT_IMG}"
else
    echo "[-] ERROR: Image creation failed!"
    exit 1
fi