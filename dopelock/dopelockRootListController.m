
#include "dopelockRootListController.h"

#import <Social/SLComposeViewController.h>
#import <Social/SLServiceTypes.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListController.h>
#import "Generic.h"

@implementation dopelockRootListController

- (NSArray *)specifiers {
if (!_specifiers) {
    _specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
}

return _specifiers;
}



-(void)loadView {
[super loadView];
	UIImage* image;
    if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
	    image = [UIImage imageNamed:@"images/heart.png" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
    }
    else {
        image = [UIImage imageNamed:@"images/heart.png" inBundle:[NSBundle bundleForClass:self.class]];
    }
	image = [image changeImageColor:[UIColor colorWithRed:0.17 green:0.24 blue:0.31 alpha:1.0]];
	CGRect frameimg = CGRectMake(0, 0, image.size.width, image.size.height);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image forState:UIControlStateNormal];
     
    [someButton addTarget:self action:@selector(heartWasTouched) forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    UIBarButtonItem *heartButton = [[UIBarButtonItem alloc] initWithCustomView:someButton];
    ((UINavigationItem*)self.navigationItem).rightBarButtonItem = heartButton;
}

-(void) viewWillAppear:(BOOL) animated{
	[super viewWillAppear:animated];
	[self setupHeader];
}

-(void)setupHeader{
	UIView *header = nil;
    header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    HBLogDebug(@"%f", self.view.bounds.size.width);
    UIImage *headerImage;
    if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
        headerImage = [UIImage imageNamed:@"images/banner.png" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
    }
    else {
        headerImage = [UIImage imageNamed:@"images/banner.png" inBundle:[NSBundle bundleForClass:self.class]];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:headerImage];
    //header.frame = (CGRect){ header.frame.origin, headerImage.size };
    imageView.frame = CGRectMake(header.frame.origin.x, 10, self.view.bounds.size.width, 100);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [header addSubview:imageView];
    [self.table setTableHeaderView:header];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self setupHeader];
}

-(void)_returnKeyPressed:(id)arg1 {
     [super _returnKeyPressed:arg1];
     [self.view endEditing:YES];
}


-(void)respring
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
system("killall -9 SpringBoard");
#pragma clang diagnostic pop
}

-(void)emailDev {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:wizagesmax@gmail.com,ziph0ntweak@gmail.com?subject=DopeLock%20Support"]];
}


-(void)heartWasTouched
{
	SLComposeViewController *composeController = [SLComposeViewController
                                                  composeViewControllerForServiceType:SLServiceTypeTwitter];
    [composeController setInitialText:@"Make your lockscreen dope using dopelock by @Wizages @Ziph0n @iBuzzeh"];
    
    [self presentViewController:composeController animated:YES completion:nil];
}

@end
