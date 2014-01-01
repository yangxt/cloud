//
//  ListViewCell.h
//  glpaint
//
//  Created by younkue on 2013. 12. 5..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAYMacro.h"
int no;

@interface ListViewCell : UITableViewCell
@property (nonatomic, retain) UIView *viewGroup;

@property (nonatomic, retain) UIImageView *imageAtt;

@property (nonatomic, retain) UIView *viewTop;
@property (nonatomic, retain) UIView *viewBottom;
@property (nonatomic, retain) UIButton *buttonLike;
@property (nonatomic, retain) UIButton *buttonReply;
@property (nonatomic, retain) UIButton *buttonFolk;

@property (nonatomic, retain) UIView *viewInfo;
@property (nonatomic, retain) UIImageView *imageProfile;
@property (nonatomic, retain) UILabel *labelSubject;
//@property (nonatomic, retain) UILabel *labelBy;
@property (nonatomic, retain) UILabel *labelWriter;
@property (nonatomic, retain) UILabel *labelLike;
@property (nonatomic, retain) UIView *viewLine;

-(void)setAllColor:(UIColor*) color;
@end
