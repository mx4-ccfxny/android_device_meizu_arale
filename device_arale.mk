-include device/meizu/arale/device_common.mk

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := full_arale
PRODUCT_DEVICE := arale

PRODUCT_COPY_FILES += \
    device/meizu/arale/bootanimation/bootanimation.zip:system/media/bootanimation.zip

# vim:set ai et ts=4 sw=4 sts=4 fenc=utf-8:
