ARCHS = armv7 armv7s arm64
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ShutUpVC
# TWEAKNAME_FRAMEWORKS = ExternalAccessory
ShutUpVC_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += shutupvcprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
