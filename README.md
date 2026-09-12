# PitchBlack Recovery Project Device Tree: Motorola Boston (boston v2)

## Specifications
- **Device**: Motorola Boston
- **Codename**: boston
- **Architecture**: ARM64 (arm64-v8a)
- **Android Target**: 12.0
- **Recovery Integration**: `vendor_boot` (Header v3)

## How to Build
```bash
# 1. Initialize PBRP Manifest
repo init -u https://github.com/PitchBlackRecoveryProject/manifest_pb -b android-12.0
repo sync -c -j$(nproc --all)

# 2. Build Vendor Boot Image
source build/envsetup.sh
lunch pb_boston-userdebug
mka vendorbootimage -j$(nproc --all)
```

## Flashing via Fastboot
```bash
adb reboot bootloader
fastboot flash vendor_boot out/target/product/boston/vendor_boot.img
fastboot reboot recovery
```