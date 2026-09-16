# Prebuilt Kernel & DTB Instructions

Because AI cannot automatically dump proprietary binaries from your physical device, you need to provide the kernel and device tree blobs for the SM6450 chip.

## Required Files
Place the following files exactly in the `prebuilt/` directory of this device tree:

1. `Image.gz` (Your stock kernel binary, gzipped)
2. `dtb.img` (Your stock Device Tree Blob)

## How to get them:
1. Download the official firmware (fastboot ROM) for your specific Motorola Boston variant.
2. Extract the `vendor_boot.img` or `boot.img` from the payload using a tool like `payload-dumper-go`.
3. Unpack the boot image using Android Image Kitchen (AIK).
4. Rename the extracted kernel to `Image.gz` and the dtb to `dtb.img`.
5. Place them in this folder.

*Note: If you have `.ko` driver modules for touchscreen or storage, create a `modules/` subfolder inside `prebuilt/` and place them there.*