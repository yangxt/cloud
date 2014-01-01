//
//  LoginController.m
//  makefigure
//
//  Created by younkue on 2013. 11. 28..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#import "LoginController.h"
#import "DAYDataModel.h"
#import "DAYAlert.h"


@interface LoginController ()

@end

@implementation LoginController
{
    DAYDataModel* _myModel;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:
     @selector(KeyboardNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:
     @selector(KeyboardNotification:) name:UIKeyboardWillHideNotification object:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _ButtonLogin.layer.borderWidth = 0;
    _ButtonLogin.layer.cornerRadius = 3;
    _ButtonLogin.layer.backgroundColor = RGB(250, 100, 100).CGColor;
    
    _myModel = [[DAYDataModel alloc] init];
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    
    //[self.navigationController.interactivePopGestureRecognizer addTarget:self action:@selector(handleGesture:)];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    [self.view addGestureRecognizer:tap];
    
}

-(void)didTap: (UITapGestureRecognizer *)rec
{
    [self.InputID resignFirstResponder];
    [self.InputPWD resignFirstResponder];
    [self.InputPWD_CHK resignFirstResponder];
    [self.InputNAME resignFirstResponder];
}

-(void)KeyboardNotification : (NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGRect endInfoKey = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
//    [UIView animateWithDuration:1 animations:^{
    _scrollView.frame = CGRectMake(0, 86, self.view.frame.size.width,  endInfoKey.origin.y - 86);
    //endInfoKey
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prePareSegue");
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    NSLog(@"Segue");
    
    BOOL perform = NO;
    if ( [identifier isEqualToString:@"GoHome"]) {
        NSString* userid = _InputID.text;
        NSString* password = _InputPWD.text;
        BOOL is_check = [_myModel loginCheck:userid withPassword:password];
        perform = is_check;
    } else {
        return YES;
    }
    return perform;
}

- (IBAction)SignUpClick:(id)sender {
    NSString* userid = _InputID.text;
    NSString* password = _InputPWD.text;
    NSString* password_check = _InputPWD_CHK.text;
    NSString* name = _InputNAME.text;
    if(ISEMPTY(userid)) {
        NSLog(@"아이디를 입력해주세요.");
        [DAYAlert showMessage:self withMessage:@"아이디를 입력해주세요"];
        return;
    }
    if(ISEMPTY(password)) {
        NSLog(@"비밀번호를 입력해주세요.");
        [DAYAlert showMessage:self withMessage:@"비번을 입력해주세요"];
        return;
    }
    if(!compare(password, password_check)) {
        NSLog(@"비번이 같지 않습니다.");
        [DAYAlert showMessage:self withMessage:@"비번이 같지 않습니다."];
        return;
    }
    
    BOOL check = [_myModel saveID: userid withPassword:password withName:name];
    if(check) {
        [self.navigationController popViewControllerAnimated:YES];
        [DAYAlert showMessage:self.parentViewController withMessage:@"축하합니다."];
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"RETURN");
    switch(textField.tag) {
        case 1:
            if(ISEMPTY(textField.text)) {
                [DAYAlert showMessage:self withMessage:@"아이디를 입력해주세요"];
                return NO;
            }
            NSLog(@"패스워드로 이동");
            
            [self.InputPWD becomeFirstResponder];
            return NO;
        case 2:

            if(ISEMPTY(textField.text)) {
                [DAYAlert showMessage:self withMessage:@"비밀번호를 입력해주세요"];
                NSLog(@"비밀번호를 입력해주세요.");
                return NO;
            }
            if([self shouldPerformSegueWithIdentifier:@"GoHome" sender:self])
                [self performSegueWithIdentifier:@"GoHome" sender:self];
            
            return NO;
    }
    
  
    return YES;
}

- (IBAction)InputFocus:(id)sender {
    NSLog(@"Focus");
    UITextField * textfield = (UITextField *)sender;
    
    CGFloat y = textfield.frame.origin.y;
    //_scrollView.contentOffset = CGPointMake(0, y - 10);
    
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController setViewControllers:@[]];
}

@end
