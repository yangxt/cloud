//
//  ListMyCell.m
//  glpaint
//
//  Created by younkue on 2013. 12. 11..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#import "ListMyCell.h"
#import "UIImageView+WebCache.h"
@implementation ListMyCell
{
    BOOL is_like;
    BOOL is_init;
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"sdsds");
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)toggleLike{
    is_like = !is_like;
    
    
    if(is_like) {
        _imageLike.image = IMAGE(@"buttonHeart_hover.png");
    } else {
        _imageLike.image = IMAGE(@"buttonHeart_unhover.png");
    }
    //_labelLike
    //_imageLike
}

- (void)viewComment {
    
}


- (void)init:(NSDictionary*) item {
    if(is_init)
        return;
    
    
    is_init = YES;
    
    _buttonPlay.layer.cornerRadius = 3;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = _viewInfo.bounds;
    gradient.colors = [NSArray arrayWithObjects:RGBA(0, 0, 0, 0.2).CGColor,RGBA(0, 0, 0, 0.15).CGColor,RGBA(0, 0, 0, 0.05).CGColor, RGBA(0, 0, 0, 0).CGColor , nil];
    [_viewBottom.layer insertSublayer:gradient atIndex:0];
    
//    UITapGestureRecognizer *singleTap = GestureTap(self, toggleLike);
//    singleTap.numberOfTapsRequired = 1;
//    _labelLike.userInteractionEnabled = YES;
//    [_labelLike addGestureRecognizer:singleTap];
    TapGesture(self, _labelLike, toggleLike);
    TapGesture(self, _imageLike, toggleLike);

    self.labelTitle.text = [item objectForKey:@"title"];
    NSString* url;
    if([item objectForKey:@"filename"] && [item objectForKey:@"filename"] != [NSNull null]  &&  [item objectForKey:@"filename"] != NULL ) {//IOS상에서는 [NSNull null]. 이게 진짜 널인가 보다. ㅋㅋ
        NSLog(@"%@", [item objectForKey:@"filename"]);
        url = [NSString stringWithFormat:@"%@%@", @"http://localhost:8080/images/", [item objectForKey:@"filename"]];
    } else
        url = @"http://localhost:8080/img/noimage.png";//이미지 파일이 없을 때
    
    [self.imageAttachment setImageWithURL:[NSURL URLWithString:url]];
    
    NSArray* comments = item[@"comments"];
    NSDictionary* writer = item[@"user"];
    
    
    self.labelCommentCount.text = [NSString stringWithFormat:@"%d",comments.count];
    self.labelWriter.text = writer[@"name"];
    
}

@end
