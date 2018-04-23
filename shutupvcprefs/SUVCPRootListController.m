#include "SUVCPRootListController.h"

@implementation SUVCPRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}
// Specify a respring action and issue a notification on press
- (void)respring {
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.oskarw.shutupvc/respring"), NULL, NULL, YES);
}
// Open my Twitter
- (void)twitter {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/oskarwirga"]];
}
// Open the project Github Repo 
- (void)github {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/oskarwirga/ShutUpVC"]];
}
@end
