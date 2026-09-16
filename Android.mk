LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),boston)
include $(call all-subdir-makefiles)
endif