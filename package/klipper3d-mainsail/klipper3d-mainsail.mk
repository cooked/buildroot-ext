################################################################################
#
# klipper3d-mainsail
#
################################################################################

KLIPPER3D_MAINSAIL_VERSION = v2.11.2
KLIPPER3D_MAINSAIL_SITE = $(call github,mainsail-crew,mainsail,$(KLIPPER3D_MAINSAIL_VERSION))
KLIPPER3D_MAINSAIL_DEPENDENCIES = nginx klipper3d klipper3d-moonraker

# TODO: install the important FS to /opt and not to /home

define KLIPPER3D_MAINSAIL_INSTALL_TARGET_CMDS

endef

$(eval $(generic-package))