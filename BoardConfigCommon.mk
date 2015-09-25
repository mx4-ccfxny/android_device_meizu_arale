# inherit from the proprietary version
-include vendor/meizu/arale/BoardConfigVendor.mk

DEVICE_FOLDER_COMMON := device/meizu/arale

# Platform
TARGET_BOARD_PLATFORM := mt6595
TARGET_NO_BOOTLOADER := true

TARGET_LDPRELOAD += libxlog.so

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
TARGET_CPU_VARIANT := cortex-a7
ARCH_ARM_HAVE_NEON := true
ARCH_ARM_HAVE_VFP := true
ARCH_ARM_HAVE_TLS_REGISTER := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := mt6595

TARGET_USERIMAGES_USE_EXT4:=true
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false

# Kernel
BOARD_KERNEL_CMDLINE :=
BOARD_KERNEL_BASE := 0x40000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS := \
	--base 0x40000000 \
	--pagesize 2048 \
	--kernel_offset 0x00008000 \
	--ramdisk_offset 0x04000000 \
	--second_offset 0x00f00000 \
	--tags_offset 0x0e000000 \
	--board 32

TARGET_PREBUILT_KERNEL := $(DEVICE_FOLDER_COMMON)/prebuilt/kernel
BOARD_CUSTOM_BOOTIMG_MK := $(DEVICE_FOLDER_COMMON)/boot.mk
#BOARD_MKBOOTIMG_ARGS := --board 1419997733
#BOARD_CUSTOM_BOOTIMG := true

TARGET_KMODULES := true

COMMON_GLOBAL_CFLAGS += -DDISABLE_HW_ID_MATCH_CHECK
TARGET_RUNNING_WITHOUT_SYNC_FRAMEWORK := true

# Disable memcpy opt (for audio libraries)
TARGET_CPU_MEMCPY_OPT_DISABLE := true

# EGL
BOARD_EGL_CFG := $(DEVICE_FOLDER_COMMON)/configs/egl.cfg
USE_OPENGL_RENDERER := true
BOARD_EGL_WORKAROUND_BUG_10194508 := true

TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1152

# MTK Hardware
BOARD_HAS_MTK_HARDWARE := true
MTK_HARDWARE := true
COMMON_GLOBAL_CFLAGS += -DMTK_HARDWARE -DADD_LEGACY_ACQUIRE_BUFFER_SYMBOL
COMMON_GLOBAL_CPPFLAGS += -DMTK_HARDWARE

# RIL
# moved to forked frameworks_opt_telephony repo
#BOARD_RIL_CLASS := ../../../$(DEVICE_FOLDER)/ril/

BOARD_CONNECTIVITY_VENDOR := MediaTek
BOARD_CONNECTIVITY_MODULE := conn_soc

# WIFI
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_mt66xx
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_mt66xx
WIFI_DRIVER_FW_PATH_PARAM:="/dev/wmtWifi"
WIFI_DRIVER_FW_PATH_STA:=STA
WIFI_DRIVER_FW_PATH_AP:=AP
WIFI_DRIVER_FW_PATH_P2P:=P2P

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_MTK := true
BOARD_BLUETOOTH_DOES_NOT_USE_RFKILL := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_FOLDER_COMMON)/bluetooth

# system.prop
TARGET_SYSTEM_PROP := $(DEVICE_FOLDER_COMMON)/system.prop

# CWM
TARGET_RECOVERY_FSTAB := $(DEVICE_FOLDER_COMMON)/root/recovery.fstab
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBA_8888"
BOARD_USE_FRAMEBUFFER_ALPHA_CHANNEL := true
TARGET_DISABLE_TRIPLE_BUFFERING := false
#BOARD_CUSTOM_GRAPHICS := $(DEVICE_FOLDER)/recovery/graphics.cwmt.c
RECOVERY_FONT := roboto_15x24.h

# TWRP
# disabled due to graphics problem... can't open fb
#RECOVERY_VARIANT=twrp
#DEVICE_RESOLUTION := 1152x1920
DEVICE_RESOLUTION := 1080x1920
TW_NO_USB_STORAGE := true
RECOVERY_GRAPHICS_USE_LINELENGTH := true
TW_NO_REBOOT_BOOTLOADER := true
TW_BRIGHTNESS_PATH := /sys/devices/platform/leds-mt65xx/leds/lcd-backlight/brightness
TW_MAX_BRIGHTNESS := 255
TW_CUSTOM_CPU_TEMP_PATH := /sys/devices/virtual/thermal/thermal_zone1/temp
#BOARD_CUSTOM_GRAPHICS := \
#	../../../$(DEVICE_FOLDER)/recovery/graphics.c \
#	../../../$(DEVICE_FOLDER)/recovery/graphics_adf.c \
#	../../../$(DEVICE_FOLDER)/recovery/graphics_fbdev.c
#TW_BOARD_CUSTOM_GRAPHICS := ../../../$(DEVICE_FOLDER)/recovery/graphics.twrp.c
#TW_INTERNAL_STORAGE_PATH := "/emmc"
#TW_INTERNAL_STORAGE_MOUNT_POINT := "emmc"
#TW_EXTERNAL_STORAGE_PATH := "/sdcard"
#TW_EXTERNAL_STORAGE_MOUNT_POINT := "sdcard"

TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/virtual/android_usb/android0/f_mass_storage/lun%d/file"

BOARD_SEPOLICY_DIRS := \
       $(DEVICE_FOLDER_COMMON)/sepolicy

BOARD_SEPOLICY_UNION := \
       device.te \
       app.te \
       system.te \
       netd.te \
       file_contexts