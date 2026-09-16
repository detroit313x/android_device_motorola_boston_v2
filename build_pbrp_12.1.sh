#!/usr/bin/env bash
#
# PitchBlack Recovery Project (PBRP v4.0) Build Automator for Android 12.1 (12L)
# Target Device: Motorola Moto G Stylus 5G 2024 (boston)
# Hardware: Qualcomm Snapdragon 6 Gen 1 (SM6450 - arm64)
# Target Image: out/target/product/boston/vendor_boot.img
#

set -e

export DEVICE_CODENAME="boston"
export PBRP_BRANCH="android-12.1"
export DEVICE_REPO="https://github.com/Detroit313x/android_device_motorola_boston_v2"

echo "=================================================================="
echo " Starting PitchBlack Recovery Project (PBRP v4.0) Build"
echo " Target Device: Motorola Boston (SM6450 - Qualcomm Snapdragon 6 Gen 1)"
echo " Android Ver:   Android 12.1 / 12L"
echo "=================================================================="

# Create Root Source Directory
WORKDIR="$HOME/pbrp_12.1_${DEVICE_CODENAME}"
mkdir -p "$WORKDIR"
cd "$WORKDIR"

# Initialize PBRP Android 12.1 Manifest
echo "==> [1/4] Initializing PBRP Manifest (${PBRP_BRANCH})..."
if [ ! -d ".repo" ]; then
    repo init -u https://github.com/PitchBlackRecoveryProject/manifest_pb -b ${PBRP_BRANCH} --git-lfs
fi

# Populate Local Manifest for Motorola Boston
echo "==> [2/4] Creating .repo/local_manifests/pbrp_boston.xml..."
mkdir -p .repo/local_manifests
cat << 'EOF' > .repo/local_manifests/pbrp_boston.xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <project path="device/motorola/boston" name="Detroit313x/android_device_motorola_boston_v2" remote="github" revision="android-12.1" />
</manifest>
EOF

# Synchronize Repositories
echo "==> [3/4] Syncing Repositories (PBRP 12.1 Base)..."
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# Setup Build Environment & Lunch Target
echo "==> [4/4] Sourcing envsetup.sh & compiling vendor_boot..."
source build/envsetup.sh
lunch pb_${DEVICE_CODENAME}-userdebug

# Clean Stale Output Images
rm -rf "out/target/product/${DEVICE_CODENAME}/vendor_boot.img"
rm -rf "out/target/product/${DEVICE_CODENAME}/vendor_ramdisk"

mka vendorbootimage -j$(nproc --all)

OUT_DIR="out/target/product/${DEVICE_CODENAME}"
if [ -f "${OUT_DIR}/vendor_boot.img" ]; then
    echo "=================================================================="
    echo " 🎉 PBRP v4.0 (Android 12.1) BUILD SUCCESSFUL!"
    echo " Target Output: ${OUT_DIR}/vendor_boot.img"
    echo " File Size:     $(du -h "${OUT_DIR}/vendor_boot.img" | cut -f1)"
    echo " Flash Command: fastboot flash vendor_boot ${OUT_DIR}/vendor_boot.img"
    echo "=================================================================="
else
    echo "[-] ERROR: vendor_boot.img generation failed. Review console logs."
    exit 1
fi