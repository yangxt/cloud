//
//  CommentViewController.m
//  glpaint
//
//  Created by younkue on 2013. 12. 31..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()
{
    NSMutableDictionary* post;
}
@end


@implementation CommentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}
@end
