################################################################################
#
# klipper
#
################################################################################

KLIPPER_VERSION = v0.12.0
KLIPPER_SITE = https://github.com/Klipper3d/klipper.git
KLIPPER_SITE_METHOD = git

# TODO
# Create virtualenv if it doesn't already exist
#[ ! -d ${PYTHONDIR} ] && virtualenv -p python2 ${PYTHONDIR}
# Install/update dependencies
#${PYTHONDIR}/bin/pip install -r ${SRCDIR}/scripts/klippy-requirements.txt


# TODO define user


define KLIPPER_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D "$(@D)/scripts/klipper-start.sh" \
		$(TARGET_DIR)/etc/init.d/S90klipper
endef

$(eval $(generic-package))