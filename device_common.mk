$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/meizu/arale/arale-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/meizu/arale/overlay

LOCAL_PATH := device/meizu/arale
ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := $(LOCAL_PATH)/prebuilt/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

# Boot animation
# Select the 1080-width one; despite the variables' names, they seem to be
# used by bootanimation only.
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080  # 1152

PRODUCT_PACKAGES += \
    libxlog

# be a chinese
EXTENDED_FONT_FOOTPRINT := true
PRODUCT_LOCALES := zh_CN zh_HK zh_TW

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.timezone=Asia/Shanghai

# init
PRODUCT_PACKAGES += \
    proj-dev-setup

# various MTK ABI fixes
# this is the approach of the cm-13.0 sprout port
PRODUCT_PACKAGES += \
    libmtkabi

# workaround proximity sensor sometimes losing calibration after making a call
PRODUCT_PACKAGES += \
    meizupshelper

# Display
PRODUCT_PACKAGES += \
    libgralloc_extra \
    libion_mtk \
    libui_ext \
    libgui_ext \
    guiext-server \
    librrc \
    libmtk_drvb \

# Power
PRODUCT_PACKAGES += \
    power.mt6595 \

# Lights
PRODUCT_PACKAGES += \
    lights.mt6595 \

# Camera
PRODUCT_PACKAGES += \
    Snap \
    libnvramagentclient \

# Use CM Gello browser---suda-disable-because-not have arm folder
#PRODUCT_PACKAGES += \
#    Gello \

# Audio
PRODUCT_PACKAGES += \
    audio.r_submix.default \
    audio_policy.default \
    libtinycompress \
    libtinyxml \
    libblisrc \
    libblisrc32 \

# this can't be compiled right now due to ABI mismatches (MTK_Tfa98xx_SetEQ),
# and I don't feel like compiling the whole audio HAL from the source...
#    libtfa9890_interface \

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml \
    $(LOCAL_PATH)/configs/audio_policy.conf:system/etc/audio_policy.conf

# Digital Restrictions Management
# many many many segfaults, disable for now
#PRODUCT_PACKAGES += \
#    com.google.widevine.software.drm.xml \
#    libdrmctaplugin \
#    libdrmmtkplugin \
#    libdrmwvmplugin \
#    libwvm \
#    # libdrmmtkutil -- pulled in by libwvm
#    # libwvdrm_L3 libWVStreamControlAPI_L3 -- pulled in by libdrmwvmplugin
#    # libdrmmtkwhitelist -- pulled in by libdrmmtkutil

# Wifi
PRODUCT_PACKAGES += \
    libwpa_client \
    hostapd \
    dhcpcd.conf \
    wpa_supplicant \
    wpa_supplicant.conf
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/hostapd/hostapd_default.conf:system/etc/hostapd/hostapd_default.conf \
    $(LOCAL_PATH)/configs/hostapd/hostapd.accept:system/etc/hostapd/hostapd.accept \
    $(LOCAL_PATH)/configs/hostapd/hostapd.deny:system/etc/hostapd/hostapd.deny

# Bluetooth
PRODUCT_PACKAGES += \
    libbt-vendor \
    audio.a2dp.default
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/bt_did.conf:system/etc/bluetooth/bt_did.conf

# RIL
PRODUCT_PACKAGES += \
    gsm0710muxd \
    gsm0710muxdmd2 \
    mtkrild \
    mtkrildmd2 \
    mtk-ril \
    mtk-rilmd2 \
#    volte_stack \
#    volte_imcb \
#    volte_ua \
#    volte_imsm \
#    libmal \
#    libmal_datamngr \
#    libmal_epdga \
#    libmal_imsmngr \
#    libmal_mdmngr \
#    libmal_nwmngr \
#    libmal_rds \
#    libmal_rilproxy \
#    libmal_simmngr \
#    epdg_wod \
#    mtkmal \
#    charon starter stroke ipsec \
#    libcharon libhydra libstrongswan libsimaka \

# wifi offload service common library
#PRODUCT_PACKAGES += wfo-common  # this is pulled in by ImsService
#ifeq ($(strip $(MTK_EPDG_SUPPORT)),yes)
#PRODUCT_PACKAGES += WfoService libwfo_jni
#endif

# IMS and VoLTE feature
#ifeq ($(strip $(MTK_IMS_SUPPORT)),yes)
#    PRODUCT_PACKAGES += ImsService
#endif

# IKEv2
#ifeq ($(strip $(MTK_EPDG_SUPPORT)),yes)
#PRODUCT_COPY_FILES += $(LOCAL_PATH)/mtk/strongswan/epdg_conf/ipsec.conf:system/etc/ipsec/ipsec.conf
#PRODUCT_COPY_FILES += $(LOCAL_PATH)/mtk/strongswan/epdg_conf/strongswan.conf:system/etc/ipsec/strongswan.conf
#PRODUCT_COPY_FILES += $(LOCAL_PATH)/mtk/strongswan/epdg_conf/updown_script:system/etc/ipsec/updown_script
#PRODUCT_COPY_FILES += $(LOCAL_PATH)/mtk/strongswan/epdg_conf/openssl.cnf:system/etc/ipsec/ssl/openssl.cnf

#ifeq ($(strip $(MTK_CIP_SUPPORT)),no)
#PRODUCT_COPY_FILES += $(LOCAL_PATH)/mtk/strongswan/epdg_conf/Entrust.net_Certification_Authority_2048.cer:system/etc/ipsec/ipsec.d/cacerts/CA1.cer
#PRODUCT_COPY_FILES += $(LOCAL_PATH)/mtk/strongswan/epdg_conf/test2_ca.crt:system/etc/ipsec/ipsec.d/cacerts/CA1L1.crt
#endif
#endif

# Telecom
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/apns-conf.xml:system/etc/apns-conf.xml \
    $(LOCAL_PATH)/configs/ecc_list.xml:system/etc/ecc_list.xml \
    $(LOCAL_PATH)/configs/spn-conf.xml:system/etc/spn-conf.xml \

# GPS
PRODUCT_COPY_FILES += \
     $(LOCAL_PATH)/configs/agps_profiles_conf2.xml:system/etc/agps_profiles_conf2.xml

PRODUCT_PACKAGES += \
    gps.mt6595 \
    mtk_agpsd \

# Vibration
PRODUCT_PACKAGES += \
    openimmvibed \


# Keylayout
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/mtk-kpd.kl:system/usr/keylayout/mtk-kpd.kl \
    $(LOCAL_PATH)/configs/mtk-tpd.kl:system/usr/keylayout/mtk-tpd.kl

# Thermal
PRODUCT_COPY_FILES += \
     $(LOCAL_PATH)/configs/.ht120.mtc:system/etc/.tp/.ht120.mtc \
     $(LOCAL_PATH)/configs/thermal.conf:system/etc/.tp/thermal.conf \
     $(LOCAL_PATH)/configs/thermal.off.conf:system/etc/.tp/thermal.off.conf \
     $(LOCAL_PATH)/configs/thermal.high.conf:system/etc/.tp/thermal.high.conf \
     $(LOCAL_PATH)/configs/thermal.low.conf:system/etc/.tp/thermal.low.conf \
     $(LOCAL_PATH)/configs/thermal.mid.conf:system/etc/.tp/thermal.mid.conf

# Ramdisk
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/root/enableswap.sh:root/enableswap.sh \
    $(LOCAL_PATH)/root/fstab.mt6595:root/fstab.mt6595 \
    $(LOCAL_PATH)/root/twrp.fstab:recovery/root/etc/twrp.fstab \
    $(LOCAL_PATH)/root/init.mt6595.rc:root/init.mt6595.rc \
    $(LOCAL_PATH)/root/init.mt6595.usb.rc:root/init.mt6595.usb.rc \
    $(LOCAL_PATH)/root/init.recovery.mt6595.rc:root/init.recovery.mt6595.rc \
    $(LOCAL_PATH)/root/init.aee.rc:root/init.aee.rc \
    $(LOCAL_PATH)/root/init.modem.rc:root/init.modem.rc \
    $(LOCAL_PATH)/root/init.project.rc:root/init.project.rc \
    $(LOCAL_PATH)/root/init.ssd.rc:root/init.ssd.rc \
    $(LOCAL_PATH)/root/init.xlog.rc:root/init.xlog.rc \
    $(LOCAL_PATH)/root/ueventd.mt6595.rc:root/ueventd.mt6595.rc \
    $(LOCAL_PATH)/root/sbin/busybox:root/sbin/busybox \
    $(LOCAL_KERNEL):kernel

# PRODUCT_COPY_FILES += \
#     $(LOCAL_PATH)/root/init.volte.rc:root/init.volte.rc \
#     $(LOCAL_PATH)/root/init.epdg.rc:root/init.epdg.rc \
#     $(LOCAL_PATH)/root/init.mal.rc:root/init.mal.rc \
#     $(LOCAL_PATH)/root/init.wfca.rc:root/init.wfca.rc \


# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.manual_sensor.xml:system/etc/permissions/android.hardware.camera.manual_sensor.xml \
    frameworks/native/data/etc/android.hardware.camera.manual_postprocessing.xml:system/etc/permissions/android.hardware.camera.manual_postprocessing.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:system/etc/permissions/android.hardware.camera.raw.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.software.midi.xml:system/etc/permissions/android.software.midi.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \

# USB
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp \
    ro.hardware=mt6595 \

# NFC
#PRODUCT_PACKAGES += \
#    com.android.nfc_extras \
#    Tag
#PRODUCT_COPY_FILES += \
#    packages/apps/Nfc/migrate_nfc.txt:system/etc/updatecmds/migrate_nfc.txt \
#    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
#    frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
#    frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml

PRODUCT_PACKAGES += \
    Torch


$(call inherit-product, build/target/product/full.mk)

$(call inherit-product, frameworks/native/build/phone-xxhdpi-2048-dalvik-heap.mk)


# vim:set ai et ts=4 sw=4 sts=4 fenc=utf-8:
