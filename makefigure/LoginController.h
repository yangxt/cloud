//
//  LoginController.h
//  makefigure
//
//  Created by younkue on 2013. 11. 28..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAYMacro.h"


@interface LoginController : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *internalView;


@property (weak, nonatomic) IBOutlet UITextField *InputID;
@property (weak, nonatomic) IBOutlet UITextField *InputPWD;
@property (weak, nonatomic) IBOutlet UITextField *InputPWD_CHK;
@property (weak, nonatomic) IBOutlet UITextField *InputNAME;



- (IBAction)InputFocus:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *ButtonLogin;


- (IBAction)SignUpClick:(id)sender;
- (IBAction)goBack:(id)sender;

@end


//ss