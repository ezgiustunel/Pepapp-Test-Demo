//
//  LastPeriodViewController.m
//  Pepapp Example
//
//  Created by Ezgi Ustunel on 1.09.2020.
//  Copyright © 2020 Ezgi Ustunel. All rights reserved.
//

#import "LastPeriodViewController.h"
#import "ViewController.h"

@interface LastPeriodViewController ()

@end

@implementation LastPeriodViewController{
    UIDatePicker *lastPeriodDate;
    __weak IBOutlet UITextField *TFDatePicker;
    __weak IBOutlet UIScrollView *scrollView;
}

#pragma mark - View Lifecycles

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self lastPeriodDate];
    
    TFDatePicker.layer.cornerRadius = 23.0f;
    
    TFDatePicker.layer.masksToBounds = YES;
    
    TFDatePicker.layer.borderColor = [[UIColor redColor]CGColor];
    
    TFDatePicker.layer.borderWidth = 1.0f;
}

#pragma mark - DatePicker Methods

-(void)lastPeriodDate {
    lastPeriodDate=[[UIDatePicker alloc]init];
    lastPeriodDate.datePickerMode=UIDatePickerModeDate;
    [TFDatePicker setInputView:lastPeriodDate];
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(ShowSelectedDate)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [TFDatePicker setInputAccessoryView:toolBar];
}

-(void)ShowSelectedDate
{   NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd MMM YYYY"];
    TFDatePicker.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:lastPeriodDate.date]];
    [TFDatePicker resignFirstResponder];
}

#pragma mark - IBActions

- (IBAction)backButton:(id)sender {
    ViewController *back = [self.storyboard instantiateViewControllerWithIdentifier:@"first"];
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    //transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [[self navigationController] pushViewController:back animated:YES];
}



@end
