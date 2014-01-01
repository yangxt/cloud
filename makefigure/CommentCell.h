//
//  CommentCell.h
//  glpaint
//
//  Created by younkue on 2013. 12. 31..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelComment;

@property (weak, nonatomic) IBOutlet UILabel *labelWriter;


- (void)init:(NSDictionary*) item;
@end
