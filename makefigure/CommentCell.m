//
//  CommentCell.m
//  glpaint
//
//  Created by younkue on 2013. 12. 31..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)init:(NSDictionary*) item
{
    NSDictionary* user = [item objectForKey:@"user"];
    self.labelWriter.text = [user objectForKey:@"name"];
    self.labelComment.text = [item objectForKey:@"contents"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
