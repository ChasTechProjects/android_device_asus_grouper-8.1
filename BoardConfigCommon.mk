# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include hardware/nvidia/tegra3/BoardConfigCommon.mk

TARGET_BOOTLOADER_BOARD_NAME := grouper

# Filesystem
TARGET_USERIMAGES_USE_EXT4 := true
ifeq ($(HOST_OS),linux)
TARGET_USERIMAGES_USE_F2FS := true
endif
BOARD_BOOTIMAGE_PARTITION_SIZE := 8388608
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 12582912
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 681574400
BOARD_CACHEIMAGE_PARTITION_SIZE := 464519168
BOARD_USERDATAIMAGE_PARTITION_SIZE := 6567231488
BOARD_FLASH_BLOCK_SIZE := 4096

# Disable journaling on system.img to save space
BOARD_SYSTEMIMAGE_JOURNAL_SIZE := 0

# Configure jemalloc for low-memory
MALLOC_SVELTE := true

# We have very little system space
WITH_DEXPREOPT := false

# Graphics flags
TARGET_FORCE_SCREENSHOT_CPU_PATH := true
USE_OPENGL_RENDERER := true
TARGET_RUNNING_WITHOUT_SYNC_FRAMEWORK := true
TARGET_NEEDS_PLATFORM_TEXT_RELOCATIONS := true
BOARD_EGL_WORKAROUND_BUG_10194508 := true
HWUI_COMPILE_FOR_PERF := true

# Shims: gpsd
TARGET_LD_SHIM_LIBS += \
    /system/vendor/bin/gpsd|/vendor/lib/gpsd_shim.so

# Use clang platform builds
USE_CLANG_PLATFORM_BUILD := true

# Kernel
BOARD_KERNEL_CMDLINE := androidboot.hardware=$(TARGET_BOOTLOADER_BOARD_NAME) androidboot.selinux=permissive
TARGET_KERNEL_CONFIG := tegra3_android_defconfig
TARGET_KERNEL_SOURCE := kernel/asus/grouper
KERNEL_TOOLCHAIN := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_OS)-x86/arm/arm-eabi-4.8/bin
KERNEL_TOOLCHAIN_PREFIX := arm-eabi-
BOARD_KERNEL_IMAGE_NAME := zImage

# Wi-Fi
BOARD_WLAN_DEVICE           := bcmdhd
WPA_SUPPLICANT_VERSION      := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA     := "/vendor/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_AP      := "/vendor/firmware/fw_bcmdhd_apsta.bin"

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_CUSTOM_BT_CONFIG := device/asus/grouper/bluetooth/vnd_grouper.txt
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/asus/grouper/bluetooth

# Security
BOARD_SEPOLICY_DIRS += device/asus/grouper/sepolicy
