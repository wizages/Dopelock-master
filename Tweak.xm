#import "Headers.h"
#import "dopeLockObject.h"
#import "Imports.h"
static bool enabled = true;
static bool textColor = false;
static bool fullBlur = false;
static NSMutableArray *todayArray = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", nil];
static LPViewController *_mainPage;
static NSString *user = @"Friend";
static bool keepLSNotif = false;
static bool militaryTime = false;
static long long styleColor = 3;


id delegate;
int testing = 0;

%hook SpringBoard

-(void)applicationDidFinishLaunching:(id)application {
%orig;
if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Dopelock Helper"
    message:@"Rotate your iPad once to fix any landscape rotation issues!"
    delegate:nil
    cancelButtonTitle:@"Sure!"
    otherButtonTitles:nil];
    [alert show];
    [alert release];
    }
}

%end

%hook BBBulletin

+ (BBBulletin *)bulletinWithBulletin:(id)arg1 {
    
    //%log;
    if (enabled){
        BBBulletin *test = %orig;
    //test.publisherBulletinID Use this if we want to sort.
        HBLogDebug(@"Message: %@", test.message);
        if (test.message){
            if ([test.section isEqualToString:@"com.apple.mobilecal.today"] && [test.publisherBulletinID isEqualToString:@"EKBBBirthdayBulletin"] ) {
            [todayArray replaceObjectAtIndex:0 withObject:test.message];
            }
            else if ([test.section isEqualToString:@"com.apple.weather.today"])
            {
                [todayArray replaceObjectAtIndex:1 withObject:test.message];
            }
            else if ([test.section isEqualToString:@"com.apple.mobilecal.today"] && [test.publisherBulletinID isEqualToString:@"EKBBUpcomingEventBulletin"])
            {
                [todayArray replaceObjectAtIndex:2 withObject:test.message];
            }
            else if ([test.section isEqualToString:@"com.apple.mobiletimer"])
            {
                [todayArray replaceObjectAtIndex:3 withObject:test.message];
            }
            else if ([test.section isEqualToString:@"com.apple.mobilecal.today"] && [test.publisherBulletinID isEqualToString:@"EKBBTomorrowSnippetBulletin"])
            {
                [todayArray replaceObjectAtIndex:4 withObject:test.message];
            }
        }
        return test;
    }
    else
        return %orig;
    
    //return %orig;
}

%end

%hook SBLockScreenView
         
 -(void)didMoveToWindow {
    if(enabled){
        [_mainPage setMilitaryTime:militaryTime];
        [_mainPage setBlur:fullBlur];
        [_mainPage addUser:user];
        [_mainPage addArray:todayArray];
        [_mainPage viewWillAppear:NO];
        %orig;
    }
    %orig;
}

%end

%hook SBLockScreenNotificationListController

- (_Bool)removeItemsForNotificationCenterPresentation
{
    if(enabled && keepLSNotif)
        return NO;
    else
        return %orig;
}
- (_Bool)removeItemsForUnlock
{
    if(enabled && keepLSNotif)
        return NO;
    else
        return %orig;
}

%end

%hook SBLockScreenViewController
- (_Bool)isBounceEnabledForPresentingController:(id)arg1 locationInWindow:(struct CGPoint)arg2 {
    if(enabled)
        return NO;
    else
        return %orig;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    %orig;
    [_mainPage rotateView];
}

%end

static void loadPrefs()
{
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.dopeteam.dopelock.plist"];
    if (prefs)
    {
        enabled =  ( [prefs objectForKey:@"enabled"] ? [[prefs objectForKey:@"enabled"] boolValue] : enabled );
        user = [prefs objectForKey:@"name"];
        textColor =  ( [prefs objectForKey:@"textColor"] ? [[prefs objectForKey:@"textColor"] boolValue] : textColor );
        fullBlur = ( [prefs objectForKey:@"fullBlur"] ? [[prefs objectForKey:@"fullBlur"] boolValue] : fullBlur );
        keepLSNotif = ( [prefs objectForKey:@"keepLSNotif"] ? [[prefs objectForKey:@"keepLSNotif"] boolValue] : keepLSNotif );
        militaryTime = ( [prefs objectForKey:@"militaryTime"] ? [[prefs objectForKey:@"militaryTime"] boolValue] : militaryTime );
        styleColor = ( [prefs objectForKey:@"styleColor"] ? [[prefs objectForKey:@"styleColor"] longValue] : styleColor );

        if(!user || user == nil)
            user=@"Friend";
    }
    [prefs release];
}

%ctor
{
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.dopeteam.dopelock/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
    if(enabled)
    {
            @autoreleasepool {
             _mainPage = [[LPViewController alloc] init];
             [_mainPage setBlur:fullBlur];
             [_mainPage addUser:user];
             [_mainPage setColor:textColor];
             [_mainPage setStyleColor:styleColor];
            [[LPPageController sharedInstance] addPage:_mainPage];
    }
    }
   
}