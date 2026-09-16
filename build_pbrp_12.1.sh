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
export CPU_THREADS="16"
export CCACHE_SIZE="50G"
export TARGET_BOARD_PLATFORM="sm6450"

echo "=================================================================="
echo " Starting PitchBlack Recovery Project (PBRP v4.0) Build"
echo " Target Device: Motorola Boston (SM6450 - Qualcomm Snapdragon 6 Gen 1)"
echo " Android Ver:   Android 12.1 / 12L"
echo " PBRP Branch:   ${PBRP_BRANCH}"
echo " Device Repo:   ${DEVICE_REPO}"
echo " Build Jobs:    -j${CPU_THREADS}"
echo "=================================================================="

# 1. Environment Verification
echo "==> [1/7] Verifying PBRP Build Dependencies..."
REQUIRED_PKGS=(bc bison build-essential curl flex g++-multilib gcc-multilib git gnupg gperf lib32ncurses5-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc zip zlib1g-dev python3 repo ccache libssl-dev lz4 android-sdk-libsparse-utils)

for pkg in "${REQUIRED_PKGS[@]}"; do
    if ! dpkg -l | grep -q "^ii  $pkg "; then
        echo "[!] Warning: Package $pkg may be missing from host environment."
    fi
done

# 2. CCache Setup
export USE_CCACHE=1
export CCACHE_EXEC=$(which ccache)
export CCACHE_DIR="$HOME/.ccache"
ccache -M ${CCACHE_SIZE}
echo "[+] CCache initialized at ${CCACHE_DIR} (${CCACHE_SIZE} limit)"

# 3. Create Root Source Directory
WORKDIR="$HOME/pbrp_12.1_${DEVICE_CODENAME}"
mkdir -p "$WORKDIR"
cd "$WORKDIR"

# 4. Initialize PBRP Android 12.1 Manifest
echo "==> [2/7] Initializing PBRP Manifest (${PBRP_BRANCH})..."
if [ ! -d ".repo" ]; then
    repo init -u https://github.com/PitchBlackRecoveryProject/manifest_pb -b ${PBRP_BRANCH} --git-lfs
fi

# 5. Populate Local Manifest for Motorola Boston
echo "==> [3/7] Creating .repo/local_manifests/pbrp_boston.xml..."
mkdir -p .repo/local_manifests

cat << 'EOF' > .repo/local_manifests/pbrp_boston.xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <!-- Device Tree for Motorola Boston (boston) - PBRP Android 12.1 -->
  <project path="device/motorola/boston" name="Detroit313x/android_device_motorola_boston_v2" remote="github" revision="android-12.1" />
</manifest>
EOF

# 6. Synchronize Repositories
echo "==> [4/7] Syncing Repositories (PBRP 12.1 Base)..."
repo sync -c -j${CPU_THREADS} --force-sync --no-clone-bundle --no-tags

# 7. Setup Build Environment & Lunch Target
echo "==> [5/7] Sourcing envsetup.sh & setting target pb_boston-userdebug..."
source build/envsetup.sh
lunch pb_${DEVICE_CODENAME}-userdebug

# 8. Clean Stale Output Images
echo "==> [6/7] Cleaning previous vendor_boot outputs..."
rm -rf "out/target/product/${DEVICE_CODENAME}/vendor_boot.img"
rm -rf "out/target/product/${DEVICE_CODENAME}/vendor_ramdisk"

# 9. Compile PBRP Vendor Boot Image
echo "==> [7/7] Compiling PBRP vendor_boot.img (Android 12.1 Header v3/v4)..."
mka vendorbootimage -j${CPU_THREADS}
mka pbrp -j${CPU_THREADS} || true

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