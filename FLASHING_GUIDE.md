# PBRP v4.0 (Android 12.1) Flashing & Installation Guide

## Target Device Specifications
- **Device:** Motorola Moto G Stylus 5G 2024 (`boston`)
- **Chipset Platform:** Qualcomm Snapdragon 6 Gen 1 (`SM6450`)
- **Android Target:** Android 12.1 / 12L (PBRP v4.0)
- **Recovery Ramdisk Container:** `vendor_boot` Partition

---

## Output Target File
After executing `build_pbrp_12.1.sh`, the PBRP recovery vendor boot image will be generated at:
```text
out/target/product/boston/vendor_boot.img
```

---

## Fastboot Installation Instructions

1. **Reboot your Motorola Boston into Fastboot Mode:**
   ```bash
   adb reboot bootloader
   ```

2. **Flash the PBRP 12.1 Vendor Boot Image:**
   ```bash
   fastboot flash vendor_boot out/target/product/boston/vendor_boot.img
   ```

3. **Reboot directly into PBRP Recovery UI:**
   ```bash
   fastboot reboot recovery
   ```

4. **Verify PBRP v4.0 (Android 12.1) UI:**
   Once booted, you can decrypt `/data`, flash custom ROMs, manage partitions, or enter `fastbootd` directly from the PitchBlack Recovery menu.