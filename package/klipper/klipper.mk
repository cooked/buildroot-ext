################################################################################
#
# klipper
#
################################################################################

KLIPPER_VERSION = v0.12.0
KLIPPER_SITE = https://github.com/Klipper3d/klipper.git
KLIPPER_SITE_METHOD = git
KLIPPER_DEPENDENCIES = host-python-cffi host-gcc-arm-none-eabi

KLIPPER_KCONFIG_DEFCONFIG = klipper.bin

KLIPPER_PYTHON_DIR = $(TARGET_DIR)/opt/klippy-env
KLIPPER_DEFAULT_FILE = $(TARGET_DIR)/etc/default/klipper

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

define LINUX_KCONFIG_FIXUP_CMDS

endef


# build uC code based on the KLIPPER_KCONFIG_FILE 
# -m 0755
define KLIPPER_BUILD_TARGET_CMDS

endef

define KLIPPER_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/opt/klippy
	cp -rf -m 0755 $(@D)/klippy $(TARGET_DIR)/opt/klippy
endef

define KLIPPER_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D "$(@D)/scripts/klipper-start.sh" \
		$(TARGET_DIR)/etc/init.d/S90klipper
endef



$(eval $(kconfig-package))