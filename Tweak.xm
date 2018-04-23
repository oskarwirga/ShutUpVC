#import <UIKit/UIKit.h>
// Springboard Reload Notifier
@interface FBSystemService
+(id)sharedInstance;
-(void)exitAndRelaunch:(BOOL)arg1;
@end
// Hook into the SpringBoard where Voice Control is managed
%hook SBMainDisplayPolicyAggregator

// Setup a respring call
void respringDevice() {
    [[%c(FBSystemService) sharedInstance] exitAndRelaunch:YES];
}
// This method is a function which returns YES or NO on whether to start VC
- (BOOL) _allowsCapabilityVoiceControlWithExplanation:(id*)voiceControlReason {
    // Execute the original method
    BOOL originalValue = %orig;
    // Get the state of the toggle in the Settings pane
    NSString *settingsPath = @"/var/mobile/Library/Preferences/com.oskarw.shutupvcprefs.plist";
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsPath];
    BOOL enabled = [[prefs objectForKey:@"enabled"] boolValue];
    // Return based on that toggle's state
    if(enabled)
        return NO;
    return originalValue;
}
%end
// Hook into the Dictation class
%hook UIDictationController

- (BOOL) dictationEnabled {
    // Get the state of the toggle
    BOOL originalValue = %orig;
    NSString *settingsPath = @"/var/mobile/Library/Preferences/com.oskarw.shutupvcprefs.plist";
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsPath];
    BOOL enabled = [[prefs objectForKey:@"enabledDictation"] boolValue];
    // Return based on that state
    if(enabled)
        return NO;
    return originalValue;
}
%end
// Set up an object which will listen to any notifications posted to it
%ctor {
    // Call the respringDevice function when this notification is received
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)respringDevice, CFSTR("com.oskarw.shutupvc/respring"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);


}
