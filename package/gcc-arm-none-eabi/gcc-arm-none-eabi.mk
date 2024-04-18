################################################################################
#
# GNU Arm Embedded Toolchain
#
################################################################################

# GCC Version being packaged
GCC_ARM_NONE_EABI_VERSION_GCC = 13.2
GCC_ARM_NONE_EABI_VERSION_REL = 1
GCC_ARM_NONE_EABI_VERSION = $(GCC_ARM_NONE_EABI_VERSION_GCC).rel$(GCC_ARM_NONE_EABI_VERSION_REL)

GCC_ARM_NONE_EABI_SOURCE = arm-gnu-toolchain-$(GCC_ARM_NONE_EABI_VERSION)-x86_64-arm-none-eabi.tar.xz
GCC_ARM_NONE_EABI_SITE = https://developer.arm.com/-/media/Files/downloads/gnu/$(GCC_ARM_NONE_EABI_VERSION)/binrel
#?rev=e434b9ea4afc4ed7998329566b764309&hash=CA590209F5774EE1C96E6450E14A3E26

GCC_ARM_NONE_EABI_LICENSE = GPL-2.0+, LGPL-2.1+
GCC_ARM_NONE_EABI_LICENSE_FILES = share/doc/gcc-arm-none-eabi/license.txt

# This is a prebuilt toolchain, we only extract it to the host
GCC_ARM_NONE_EABI_INSTALLDIR = $(HOST_DIR)/share/gcc-arm-none-eabi

define HOST_GCC_ARM_NONE_EABI_INSTALL_CMDS
	mkdir -p $(GCC_ARM_NONE_EABI_INSTALLDIR)
	cp -dpfr $(@D)/* $(GCC_ARM_NONE_EABI_INSTALLDIR)
endef

$(eval $(host-generic-package))
