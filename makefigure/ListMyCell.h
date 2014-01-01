//
//  ListMyCell.h
//  glpaint
//
//  Created by younkue on 2013. 12. 11..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAYMacro.h"
@interface ListMyCell : UITableViewCell

- (void)init:(NSDictionary*) item ;

@property (weak, nonatomic) IBOutlet UIButton *buttonPlay;

@property (weak, nonatomic) IBOutlet UIImageView *imageAttachment;
@property (weak, nonatomic) IBOutlet UIView *viewInfo;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelWriter;

@property (weak, nonatomic) IBOutlet UILabel *labelLike;
@property (weak, nonatomic) IBOutlet UIImageView *imageLike;

@property (weak, nonatomic) IBOutlet UIView *viewBottom;

@property (weak, nonatomic) IBOutlet UILabel *labelCommentCount;

@end
