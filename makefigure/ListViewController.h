//
//  ListViewController.h
//  makefigure
//
//  Created by younkue on 2013. 11. 29..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate>

- (void) saveBoardArray:(NSArray *)array;


- (IBAction)newPost:(id)sender;
- (void)setGoPostNum:(int)postNum;
- (void)setReadyGo;
@property (weak, nonatomic) IBOutlet UIView *viewTitle;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *viewTitleBar;
@property (weak, nonatomic) IBOutlet UIView *viewBackground;

//@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end
