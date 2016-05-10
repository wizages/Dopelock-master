//
//  LockLyrics7.xm
//  LockLyrics7
//
//  Created by Pigi Galdi on 13.10.2014.
//  Copyright (c) 2014 Pigi Galdi. All rights reserved.
//
//	Imports.
#import "Imports.h"
#import "dopeLockObject.h"
#include "Headers.h"
static DopeLock *lockView;
static UIScrollView *dopeScroll;

@implementation LPViewController
- (id)init{
	self = [super init];
	if (self) {
		CGRect screenRect = [[UIScreen mainScreen] bounds];
		CGFloat screenWidth = screenRect.size.width;
		CGFloat screenHeight = screenRect.size.height;
        __mainView = [[LPView alloc] initWithFrame:screenRect];
        lockView = [[DopeLock alloc] initWithFrame:screenRect];

        
        //Sets the size area for dopeScroll
        if(screenRect.size.width>screenRect.size.height) //Landscape
            dopeScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)]; //Landscape Respring on iPad
        else //portrait
            dopeScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)]; //Landscape Respring on iPad
        
        // Sets size for the content of dopeScroll
		[dopeScroll addSubview:lockView];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            [dopeScroll setContentSize: CGSizeMake(screenWidth, 1725)];
        else
            [dopeScroll setContentSize: CGSizeMake(screenWidth, 1600)];

        
        lockView.user = @"Friend";
        [lockView addBasicsToView];
		// Calling methods declared in LPView.h to set LPViewController as delegate of LPPage protocol.
        [__mainView setDelegate:self];
        // Remeber: LPView is a subclass of UIView! ;)
		[__mainView setBackgroundColor:[UIColor clearColor]];
		[__mainView addSubview:dopeScroll];
		//__mainView.userInteractionEnabled=NO; //hey hey :)
		// Setting LPView as LPViewController's view.
		[self setView:__mainView];
	}
	return self;
}

-(void)addArray:(NSMutableArray *)arg1{
	[lockView removeFromSuperview];
	[dopeScroll removeFromSuperview];
	[lockView updateTodayTomorrow:arg1];
	[lockView updateView];
	[dopeScroll addSubview:lockView];
	[__mainView addSubview:dopeScroll];
	[self setView:__mainView];
}

-(void)addUser:(NSString *)arg1{
	lockView.user = arg1;
}

-(void)setBlur:(BOOL)arg1{
	lockView.fullBlur = arg1;
}

-(void)setStyleColor:(long long)arg1{
    lockView.styleColor = arg1;
}

-(void)setMilitaryTime:(BOOL)arg1{
	lockView.militaryTime = arg1;
}

-(void) viewWillAppear:(BOOL) animated{
    [super viewWillAppear:animated];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [__mainView setFrame:screenRect];
}

-(void)rotateView {// When iPad is rotated
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;

    if (screenWidth>screenHeight) //Landscape Rotation
        [lockView setFrame:CGRectMake(128, 5, screenHeight, screenHeight)];
    else //Portrait
        [lockView setFrame:CGRectMake(0, 0, screenWidth, screenHeight)];

    [dopeScroll setFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    [dopeScroll setContentSize: CGSizeMake(screenWidth, 1725)];
}


-(void)setColor:(BOOL)arg1{
	lockView.textColor = arg1;
}
// 	Delegate methods.
// 	See LPView.h for more methods.
- (NSInteger)priority {
	return 10; // Pages are rendered in descending priority order, so use an high value to put your view as first or a lower to put your page as last page.
}

- (double)idleTimerInterval {
	return 60.0; //Autolock is disabled during 145 minutes when you are on the DopeView
}
@end
