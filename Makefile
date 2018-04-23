# Set supported architectures
ARCHS = armv7 armv7s arm64
include $(THEOS)/makefiles/common.mk

# Name your tweak
TWEAK_NAME = ShutUpVC
# Include any other frameworks
ShutUpVC_FRAMEWORKS = UIKit
# Include your Tweak
ShutUpVC_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

# Reload SpringBoard after installation
after-install::
	install.exec "killall -9 SpringBoard"
# Include the settings page
SUBPROJECTS += shutupvcprefs

include $(THEOS_MAKE_PATH)/aggregate.mk
