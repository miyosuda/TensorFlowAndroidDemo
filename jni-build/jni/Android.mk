LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

TENSORFLOW_CFLAGS	  := -frtti \
	-ffunction-sections \
	-funwind-tables \
	-no-canonical-prefixes \
	-fno-canonical-system-headers \
	-fstack-protector-strong \
	-fno-exceptions \
	-DEIGEN_AVOID_STL_ARRAY \
	'-std=c++11' \
	'-DMIN_LOG_LEVEL=0' \
	-DTF_LEAN_BINARY \
	-O2 \
	-Os \
	-MD \
	-MF \

TENSORFLOW_SRC_FILES := ./tensorflow_jni.cc \
	./imageutils_jni.cc \
	./jni_utils.cc \
	./rgb2yuv.cc \
	./yuv2rgb.cc \

LOCAL_MODULE    := tensorflow_demo
LOCAL_ARM_MODE  := arm
LOCAL_SRC_FILES := $(TENSORFLOW_SRC_FILES)
LOCAL_CFLAGS    := $(TENSORFLOW_CFLAGS)

LOCAL_LDLIBS    := \
	-Wl,-whole-archive \
	$(LOCAL_PATH)/libs/$(TARGET_ARCH_ABI)/libandroid_tensorflow_kernels.lo \
	$(LOCAL_PATH)/libs/$(TARGET_ARCH_ABI)/libandroid_tensorflow_lib.lo \
	$(LOCAL_PATH)/libs/$(TARGET_ARCH_ABI)/libandroid_tensorflow_lib_lite.lo \
	$(LOCAL_PATH)/libs/$(TARGET_ARCH_ABI)/libre2.a \
	$(LOCAL_PATH)/libs/$(TARGET_ARCH_ABI)/libprotos_all_cc.a \
	$(LOCAL_PATH)/libs/$(TARGET_ARCH_ABI)/libprotobuf.a \
	$(LOCAL_PATH)/libs/$(TARGET_ARCH_ABI)/libprotobuf_lite.a \
	-Wl,-no-whole-archive \
	$(NDK_ROOT)/sources/cxx-stl/gnu-libstdc++/4.9/libs/$(TARGET_ARCH_ABI)/libgnustl_static.a \
	$(NDK_ROOT)/sources/cxx-stl/gnu-libstdc++/4.9/libs/$(TARGET_ARCH_ABI)/libsupc++.a \
	-landroid -ljnigraphics -llog -lm -z defs -s '-Wl,--icf=all' -Wl,--exclude-libs,ALL -pthread -static-libgcc -no-canonical-prefixes -Wl,-S


LOCAL_C_INCLUDES += $(LOCAL_PATH)/include \
	$(LOCAL_PATH)/genfiles \
	$(LOCAL_PATH)/include/third_party/eigen3 \
	$(LOCAL_PATH)/include/external/eigen_archive \
	$(LOCAL_PATH)/include/external/eigen_archive/eigen-eigen-4c94692de3e5 \
	$(LOCAL_PATH)/include/google/protobuf/src

NDK_MODULE_PATH := $(call my-dir)

include $(BUILD_SHARED_LIBRARY)
