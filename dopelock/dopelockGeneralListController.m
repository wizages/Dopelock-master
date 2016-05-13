
#include "dopelockGeneralListController.h"
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListController.h>
#import "dopelockGeneralListController.h"
#import "Generic.h"


@implementation dopelockGeneralListController

- (NSArray *)specifiers {
    if (!_specifiers) {
        _specifiers = [[self loadSpecifiersFromPlistName:@"dopelockGeneralListController" target:self] retain];
    }
    return _specifiers;
}

-(void)respring
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    system("killall -9 SpringBoard");
#pragma clang diagnostic pop
}
@end
