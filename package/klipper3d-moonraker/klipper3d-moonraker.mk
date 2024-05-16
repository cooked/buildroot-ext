################################################################################
#
# klipper3d-moonraker
#
################################################################################

KLIPPER3D_MOONRAKER_VERSION = master
KLIPPER3D_MOONRAKER_SITE = $(call github,Arksine,moonraker,$(KLIPPER3D_MOONRAKER_VERSION))
KLIPPER3D_MOONRAKER_DEPENDENCIES = klipper3d python-streaming-form-data
KLIPPER3D_MOONRAKER_SETUP_TYPE = pep517

# TODO: install the important FS to /opt and not to /home

# TODO: moonraker is based on systemd service, to start with

define KLIPPER3D_MOONRAKER_INSTALL_TARGET_CMDS
	mkdir -p -m 0755 $(TARGET_DIR)/opt/moonraker
	cp -rf $(@D)/moonraker $(TARGET_DIR)/opt/moonraker
	$(INSTALL) -D -m 0644 $(KLIPPER3D_MOONRAKER_PKGDIR)/opt/moonraker/moonraker.conf \
		$(TARGET_DIR)/opt/moonraker/moonraker.conf
endef

# $(INSTALL) -m 0755 -D $(KLIPPER3D_MOONRAKER_PKGDIR)/etc/init.d/S91moonraker $(TARGET_DIR)/etc/init.d
define KLIPPER3D_MOONRAKER_INSTALL_INIT_SYSV
	
endef

define KLIPPER3D_MOONRAKER_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(KLIPPER3D_MOONRAKER_PKGDIR)/etc/systemd/system/moonraker.service \
		$(TARGET_DIR)/usr/lib/systemd/system/moonraker.service
endef

$(eval $(generic-package))