SHARED_CFLAGS = -fobjc-arc
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DopeLock
DopeLock_FILES = Tweak.xm dopeLockObject.m LPView.m LPViewController.m
DopeLock_FRAMEWORKS = EventKit
DopeLock_LDFLAGS = -llockpages

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += dopelock
include $(THEOS_MAKE_PATH)/aggregate.mk