LOCAL_PATH := $(call my-dir)
splash_local_path := $(LOCAL_PATH)

include $(CLEAR_VARS)

ifeq ($(TWRP_EVENT_LOGGING), true)
  LOCAL_CFLAGS += -D_EVENT_LOGGING
endif

splash_sources := \
    splashmenu.c \
    ui.c

ifndef SPLASH_RECOVERY_KEY
  SPLASH_RECOVERY_KEY := KEY_MENU
endif
LOCAL_CFLAGS += -DSPLASH_RECOVERY_KEY=$(SPLASH_RECOVERY_KEY)
ifndef SPLASH_CONTINUE_KEY
  SPLASH_RECOVERY_KEY := KEY_SEARCH
endif
LOCAL_CFLAGS += -DSPLASH_CONTINUE_KEY=$(SPLASH_CONTINUE_KEY)
ifndef SPLASH_DISABLE_KEY
  SPLASH_DISABLE_KEY := -1
endif
LOCAL_CFLAGS += -DSPLASH_DISABLE_KEY=$(SPLASH_DISABLE_KEY)
ifdef SPLASH_USE_REBOOT
  LOCAL_CFLAGS += -DSPLASH_USE_REBOOT
endif

ifeq ($(TW_TARGET_USES_QCOM_BSP), true)
    LOCAL_CFLAGS += -DTW_QCOM_BSP
endif

LOCAL_MODULE := safestrapmenu
LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := $(splash_sources)

LOCAL_CFLAGS += -DMAX_ROWS=44 -DMAX_COLS=96


LOCAL_STATIC_LIBRARIES := \
	libminui_ss \
	libpixelflinger_static \
	libpng \
	libz \
	libstdc++ \
	libc \
	libcutils \
	liblog

LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_OUT)/root/../../install-files/etc/safestrap

include $(BUILD_EXECUTABLE)

include $(call all-makefiles-under,$(splash_local_path))

