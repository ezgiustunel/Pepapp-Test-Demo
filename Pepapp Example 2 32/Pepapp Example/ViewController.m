//
//  ViewController.m
//  Pepapp Example
//
//  Created by Ezgi Ustunel on 28.08.2020.
//  Copyright © 2020 Ezgi Ustunel. All rights reserved.
//

#import "ViewController.h"
#import "KKUtils.h"

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController{
    CGFloat _continueBottomHeight;
    CGFloat _backBottomHeight;
    __weak IBOutlet KKUITextField *TFEmail;
    __weak IBOutlet NSLayoutConstraint *CNSContinueBottom;
    __weak IBOutlet NSLayoutConstraint *CNSBackBottom;
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet KKUIButton *BTNContinue;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _continueBottomHeight = CNSContinueBottom.constant;
    _backBottomHeight = CNSBackBottom.constant;
    TFEmail.layer.cornerRadius = 23.0f;

    TFEmail.layer.masksToBounds = YES;

    TFEmail.layer.borderColor = [[UIColor redColor]CGColor];

    TFEmail.layer.borderWidth = 1.0f;

    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - IBActions




#pragma mark - Notification

- (void)keyboardWillShow:(NSNotification*)aNotification {
    NSTimeInterval duration = [aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [scrollView setContentOffset:CGPointMake(0,TFEmail.center.y - (kbSize.height-(kbSize.height/2.3))) animated:YES];
    
    CNSContinueBottom.constant = kbSize.height / 4;
    CNSBackBottom.constant = kbSize.height / 4;
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    
    NSTimeInterval duration = [aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [scrollView  setContentOffset:CGPointMake(0,0) animated:YES];
    CNSContinueBottom.constant = _continueBottomHeight;
    CNSBackBottom.constant = _backBottomHeight;
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    }

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end

