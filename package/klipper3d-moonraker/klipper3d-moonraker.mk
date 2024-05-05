################################################################################
#
# klipper3d-moonraker
#
################################################################################

KLIPPER3D_MOONRAKER_VERSION = master
KLIPPER3D_MOONRAKER_SITE = $(call github,Arksine,moonraker,$(KLIPPER3D_MOONRAKER_VERSION))
KLIPPER3D_MOONRAKER_DEPENDENCIES = klipper3d

# TODO: install the important FS to /opt and not to /home

# TODO: moonraker is based on systemd service, to start with

define KLIPPER3D_MOONRAKER_INSTALL_TARGET_CMDS

endef

$(eval $(generic-package))