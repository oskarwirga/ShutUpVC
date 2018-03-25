@interface FBSystemService
+(id)sharedInstance;
-(void)exitAndRelaunch:(BOOL)arg1;
@end

%hook SBMainDisplayPolicyAggregator

void respringDevice() {
    [[%c(FBSystemService) sharedInstance] exitAndRelaunch:YES];
}

- (BOOL) _allowsCapabilityVoiceControlWithExplanation:(id*)voiceControlReason {
    BOOL originalValue = %orig;
    NSString *settingsPath = @"/var/mobile/Library/Preferences/com.oskarw.shutupvcprefs.plist";
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsPath];
    BOOL enabled = [[prefs objectForKey:@"enabled"] boolValue];
    if(enabled)
        return NO;
    return originalValue;
}
%end

%ctor {
    
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)respringDevice, CFSTR("com.oskarw.shutupvc/respring"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);


}
