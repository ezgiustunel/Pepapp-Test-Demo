//
//  PregnantWeekViewController.m
//  Pepapp Example
//
//  Created by Ezgi Ustunel on 3.09.2020.
//  Copyright © 2020 Ezgi Ustunel. All rights reserved.
//

#import "PregnantWeekViewController.h"
#import "PEPPregnancyWeekView.h"
#import "LastPeriodViewController.h"

@interface PregnantWeekViewController () <PEPPregnancyWeekViewDelegate>
@end
NSString *notificationBroadcast2 = @"pregnancyWeekReceived";
CATransition *transition;

@implementation PregnantWeekViewController {
    __weak IBOutlet PEPPregnancyWeekView *VPregnancy;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:notificationBroadcast2 object:nil];
    transition = [[CATransition alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fillLetters];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

#pragma mark - Notifications

- (void)handleNotification:(NSNotification *)n {
    if ([n.name isEqualToString:notificationBroadcast2]) {
        if (n.userInfo && [n.userInfo objectForKey:@"pregnancyWeek"]){
            NSLog (@"Current index is %@", [n.userInfo objectForKey:@"pregnancyWeek"]);
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:notificationBroadcast2 object:nil];
}

#pragma mark -

- (void)fillLetters {
    
    NSMutableArray *_lettersM = [NSMutableArray new];
    for (int i = 1; i < 41 ; i++) {
        [_lettersM addObject: [NSString stringWithFormat:@"%i", i]];
    }
    VPregnancy.letters = [NSArray arrayWithArray:_lettersM];
}

- (void)pregnancyWeekView:(PEPPregnancyWeekView *)pregnancyWeekView didSelectIndex:(NSInteger)index {
    NSLog(@"calisiyor: %li", (long)index);
}

#pragma mark - IBActions

- (IBAction)backToLastPeriod:(id)sender {
    LastPeriodViewController *back = [self.storyboard instantiateViewControllerWithIdentifier:@"lastPeriod"];

    CATransition *transition = [CATransition animation];
    transition.duration = 0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    //transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [[self navigationController] pushViewController:back animated:YES];
}

@end




