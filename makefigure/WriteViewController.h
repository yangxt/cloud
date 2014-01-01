//
//  WriteViewController.h
//  makefigure
//
//  Created by younkue on 2013. 11. 29..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CLImageEditor.h"


@interface WriteViewController : UIViewController <UIImagePickerControllerDelegate, CLImageEditorDelegate>

- (IBAction)showObjectMenu:(id)sender;
- (void) toggleMenu;

- (IBAction)savePost:(id)sender;


- (IBAction)cancelWrite:(id)sender;

@property bool show_object_menu;

@property (weak, nonatomic) IBOutlet UIImageView *view_menu_up;

@property (weak, nonatomic) IBOutlet UIView *view_menu;
@property (weak, nonatomic) IBOutlet UIImageView *imageAtt;
- (IBAction)editImage:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *textTitle;
@property (weak, nonatomic) IBOutlet UITextView *textContents;


@end
