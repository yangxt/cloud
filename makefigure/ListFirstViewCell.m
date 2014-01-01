//
//  ListFirstViewCell.m
//  glpaint
//
//  Created by younkue on 2013. 12. 10..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#import "ListFirstViewCell.h"

@implementation ListFirstViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        _viewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];

        _viewBackground.backgroundColor = RGB(128, 133, 255);
        
        int radius = 40;
        _imageProfile = [[UIImageView alloc] initWithFrame:CGRectMake(50 - radius/2, 40, radius, radius)];
        
        _labelName = [[UILabel alloc] initWithFrame:CGRectMake(POSITION_RIGHT(_imageProfile) + 10, 40 + 4, 150, 14)];
        _labelTest = [[UILabel alloc] initWithFrame:CGRectMake(POSITION_RIGHT(_imageProfile) + 10 + 1, POSITION_BOTTOM(_labelName) , 150, 16)];
        
        [self decorate ];
        
        
        [_viewBackground addSubview:_imageProfile];
        [_viewBackground addSubview:_labelName];
        [_viewBackground addSubview:_labelTest];
        [self addSubview:_viewBackground];
    }
    return self;
}
- (void)decorate {
    UIImage *sample = [UIImage imageNamed:@"Blurred Background (6).jpg"];
    [_imageProfile setImage:sample];
    _imageProfile.layer.masksToBounds = YES;
    _imageProfile.layer.cornerRadius = _imageProfile.frame.size.height / 2;
    _imageProfile.layer.borderColor = WHITE.CGColor;
    _imageProfile.layer.borderWidth = 2;
    
    
    _labelName.font = FONT(@"HelveticaNeue-Medium", 13);
    _labelName.textColor = WHITE;
    _labelName.text = @"TEST NAME";
    
    _labelTest.font = FONT(@"HelveticaNeue-Light", 10);
    _labelTest.textColor = WHITE;
    _labelTest.text = @"TEST LABEL";
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
