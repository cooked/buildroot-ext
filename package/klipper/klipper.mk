################################################################################
#
# klipper
#
################################################################################

KLIPPER_VERSION = v0.12.0
KLIPPER_SITE = https://github.com/Klipper3d/klipper.git
KLIPPER_SITE_METHOD = git
KLIPPER_DEPENDENCIES = host-python-cffi

KLIPPER_PYTHON_DIR = $(TARGET_DIR)/opt/klippy-env
KLIPPER_DEFAULT_FILE = $(TARGET_DIR)/etc/default/klipper


# Klipper src/ configuration
ifndef KLIPPER_CONFIG_FILE
KLIPPER_CONFIG_FILE = $(call qstrip,$(BR2_PACKAGE_KLIPPER_CONFIG))
endif
KLIPPER_KCONFIG_FILE = $(KLIPPER_CONFIG_FILE)
KLIPPER_KCONFIG_DEPENDENCIES = \
	host-arm-gnu-toolchain-old \
	$(BR2_MAKE_HOST_DEPENDENCY)

# Build Klipper src/ for uC (to be flashed later) 
# Build Klippy C code part of the CFFI stuff
KLIPPER_MAKE = $(BR2_MAKE)
KLIPPER_MAKE_ENV = $(TARGET_MAKE_ENV)
KLIPPER_MAKE_OPTS = CROSS_PREFIX=$(HOST_DIR)/bin/arm-none-eabi-
KLIPPER_KLIPPY_MAKE_OPTS = DIR=$(@D)/klippy/chelper CC=$(TARGET_CC)

define KLIPPER_BUILD_CMDS
	$(KLIPPER_MAKE) $(KLIPPER_MAKE_OPTS) -C $(@D)
	$(KLIPPER_MAKE) $(KLIPPER_KLIPPY_MAKE_OPTS) -C $(KLIPPER_PKGDIR)/klippy $(@D)/klippy/chelper/c_helper.so
endef

# copy klippy over
# Create virtualenv if it doesn't already exist
# Install/update dependencies

#cffi==1.14.6
#pyserial==3.4
#greenlet==2.0.2 ; python_version < '3.12'
#greenlet==3.0.3 ; python_version >= '3.12'
#Jinja2==2.11.3
#python-can==3.3.4
#markupsafe==1.1.1

# [ ! -d ${KLIPPER_PYTHON_DIR} ] && virtualenv -p python3 ${KLIPPER_PYTHON_DIR}
# ${KLIPPER_PYTHON_DIR}/bin/pip install -r ${@D}/scripts/klippy-requirements.txt

# TODO move printer.cfg download to <pkg>_EXTRA_DOWNLOADS
define KLIPPER_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/opt/klipper
	cp -rf $(@D)/klippy $(@D)/config $(@D)/scripts $(TARGET_DIR)/opt/klipper

	mkdir -p -m 0755 $(TARGET_DIR)/opt/klipper/out
	cp $(@D)/out/klipper.bin $(@D)/out/klipper.dict $(@D)/out/compile_time_request.txt \
		$(TARGET_DIR)/opt/klipper/out
	
	mkdir -p -m 0755 $(TARGET_DIR)/etc/default
	cp $(KLIPPER_PKGDIR)/etc/default/klipper $(TARGET_DIR)/etc/default
	cp $(KLIPPER_PKGDIR)/opt/klipper/scripts/reset_phat2.sh $(TARGET_DIR)/opt/klipper/scripts

	wget -O $(TARGET_DIR)/opt/klipper/printer.cfg https://raw.githubusercontent.com/wreck-lab/wrecklabOS/devel/src/modules/klipper/filesystem/home/pi/klipper_config/config/generic-wrecklab-printhat-v2-cartesian.cfg

endef

# Custom SYSV init script
# see https://github.com/buildroot/buildroot/blob/master/package/restorecond/S02restorecond
define KLIPPER_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D $(KLIPPER_PKGDIR)/etc/init.d/S90klipper $(TARGET_DIR)/etc/init.d
endef

define KLIPPER_USERS
	klippy -1 klippy -1 * - - - Klipper daemon
endef

$(eval $(kconfig-package))