//
//  ViewController.m
//  makefigure
//
//  Created by younkue on 2013. 11. 27..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //UIFont * font = [UIFont fontWithName: @"Lato-Light" size: self.labelTitle.font.pointSize];
    //NSLog(@"LATO FONT iS %@",font);
    
    //self.labelTitle.font = font;

    

    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames ){
        //printf( "Family: %s \n", [familyName UTF8String] );
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames ){
           // printf( "\tFont: %s \n", [fontName UTF8String] );
        }
    }
 
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returned:(UIStoryboardSegue *)segue {
    //self.textLabel.text =@"난 돌아왔음";
}



























- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
    // Use this to allow upside down as well
    //return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}
- (NSUInteger) supportedInterfaceOrientations {
    // Return a bitmask of supported orientations. If you need more,
    // use bitwise or (see the commented return).
    return UIInterfaceOrientationMaskPortrait;
    // return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation {
    // Return the orientation you'd prefer - this is what it launches to. The
    // user can still rotate. You don't have to implement this method, in which
    // case it launches in the current orientation
    return UIDeviceOrientationPortrait;
}


@end
