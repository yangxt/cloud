//
//  PostViewController.h
//  glpaint
//
//  Created by younkue on 2013. 12. 5..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#import "ViewController.h"
#import "DAYMacro.h"


@interface PostViewController : ViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSDictionary* post;
}


@property (weak, nonatomic) IBOutlet UITextView *textSubject;
@property (weak, nonatomic) IBOutlet UITextView *textContents;


@property (weak, nonatomic) IBOutlet UIImageView *imageAtt;
@property (weak, nonatomic) IBOutlet UIButton *buttonLike;

@property (weak, nonatomic) IBOutlet UITableView *tableView;



@property (weak, nonatomic) IBOutlet UIImageView *imageProfile;

- (IBAction)ClickLike:(id)sender;
- (BOOL)setPost : (NSDictionary*) _post;
- (void)setPostId : (int)postNum;


- (IBAction)buttonBack:(id)sender;
- (IBAction)showReply:(id)sender;

@end
