################################################################################
#
# klipper3d
#
################################################################################

KLIPPER3D_VERSION = v0.12.0
KLIPPER3D_SITE = https://github.com/Klipper3d/klipper.git
KLIPPER3D_SITE_METHOD = git
KLIPPER3D_DEPENDENCIES = host-python-cffi

KLIPPER3D_PYTHON_DIR = $(TARGET_DIR)/opt/klippy-env
KLIPPER3D_DEFAULT_FILE = $(TARGET_DIR)/etc/default/klipper


# Klipper src/ configuration
ifndef KLIPPER3D_CONFIG_FILE
KLIPPER3D_CONFIG_FILE = $(call qstrip,$(BR2_PACKAGE_KLIPPER3D_CONFIG))
endif
KLIPPER3D_KCONFIG_FILE = $(KLIPPER3D_CONFIG_FILE)
KLIPPER3D_KCONFIG_DEPENDENCIES = \
	host-arm-gnu-toolchain-old \
	$(BR2_MAKE_HOST_DEPENDENCY)

# Build Klipper src/ for uC (to be flashed later) 
# Build Klippy C code part of the CFFI stuff
KLIPPER3D_MAKE_OPTS = CROSS_PREFIX=$(HOST_DIR)/bin/arm-none-eabi-
KLIPPER3D_KLIPPY_MAKE_OPTS = DIR=$(@D)/klippy/chelper CC=$(TARGET_CC)

define KLIPPER3D_BUILD_CMDS
	$(BR2_MAKE) $(KLIPPER3D_MAKE_OPTS) -C $(@D)
	$(BR2_MAKE) $(KLIPPER3D_KLIPPY_MAKE_OPTS) -C $(KLIPPER3D_PKGDIR)/klippy $(@D)/klippy/chelper/c_helper.so
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
#$(@D)/config
define KLIPPER3D_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/opt/klipper
	cp -rf $(@D)/klippy $(@D)/scripts $(TARGET_DIR)/opt/klipper

	mkdir -p -m 0755 $(TARGET_DIR)/opt/klipper/out
	cp $(@D)/out/klipper.bin $(@D)/out/klipper.dict $(@D)/out/compile_time_request.txt \
		$(TARGET_DIR)/opt/klipper/out
	
	mkdir -p -m 0755 $(TARGET_DIR)/etc/default
	cp $(KLIPPER3D_PKGDIR)/etc/default/klipper $(TARGET_DIR)/etc/default
	cp $(KLIPPER3D_PKGDIR)/opt/klipper/scripts/reset_phat2.sh $(TARGET_DIR)/opt/klipper/scripts

	$(if ($(BR2_PACKAGE_KLIPPER3D_PRNT_XYZ),y), \
		cp $(KLIPPER3D_PKGDIR)/opt/klipper/config/printer_xyz.cfg  $(TARGET_DIR)/opt/klipper/printer.cfg, \
		wget -O $(TARGET_DIR)/opt/klipper/printer.cfg https://raw.githubusercontent.com/wreck-lab/wrecklabOS/devel/src/modules/klipper/filesystem/home/pi/klipper_config/config/generic-wrecklab-printhat-v2-cartesian.cfg \
		)

endef

# Custom SYSV init script
# see https://github.com/buildroot/buildroot/blob/master/package/restorecond/S02restorecond
define KLIPPER3D_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D $(KLIPPER3D_PKGDIR)/etc/init.d/S90klipper $(TARGET_DIR)/etc/init.d
endef

define KLIPPER3D_USERS
	klippy -1 klippy -1 * - - - Klipper daemon
endef

$(eval $(kconfig-package))