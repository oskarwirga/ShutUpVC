include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ShutUpVCPrefs
ShutUpVCPrefs_FILES = SUVCPRootListController.m
ShutUpVCPrefs_INSTALL_PATH = /Library/PreferenceBundles
ShutUpVCPrefs_FRAMEWORKS = UIKit
ShutUpVCPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/ShutUpVCPrefs.plist$(ECHO_END)
