//
//  ListViewCell.m
//  glpaint
//
//  Created by younkue on 2013. 12. 5..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#import "ListViewCell.h"

#define MARGIN 6
#define SCREEN_WIDTH 320
#define GROUP_WIDTH 300
@implementation ListViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        int SCREEN_GROUP_PADDING = (SCREEN_WIDTH - GROUP_WIDTH)/2;
        _viewGroup = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_GROUP_PADDING, SCREEN_GROUP_PADDING, GROUP_WIDTH, 192)];
        
        
        int y = 6;

        _imageProfile = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 25, 25)];
        _labelSubject = [[UILabel alloc] initWithFrame:CGRectMake(POSITION_RIGHT(_imageProfile) +  MARGIN, POSITION_TOP(_imageProfile) - 1, 217, 15)];
        _labelWriter = [[UILabel alloc] initWithFrame:CGRectMake(POSITION_RIGHT(_imageProfile) + MARGIN , POSITION_BOTTOM(_labelSubject), 200, 13)];

        
        y = POSITION_BOTTOM(_imageProfile) + MARGIN;
        
        _imageAtt = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN, MARGIN, GROUP_WIDTH - 50 , 180)];

        
        _viewInfo = [[UIView alloc] initWithFrame:CGRectMake(10, POSITION_BOTTOM(_viewGroup) + 3, GROUP_WIDTH, 40)];
        //_imageAtt = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, SCREEN_WIDTH  , 180)];
        
        //        _imageAtt = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN + 40, y, GROUP_WIDTH - 2 * MARGIN - 40 - 5, 160)];
        
        
        //_labelBy = [[UILabel alloc] initWithFrame:CGRectMake(60, 235, 16, 16)];
        _viewLine = [[UIView alloc] initWithFrame:CGRectMake(10 + MARGIN + 15, 0, 4, 300)];
        
        int buttonHeight = 20;
        int buttonTop = POSITION_BOTTOM(_imageAtt) + 4;
        
        _viewTop = [[UIView alloc] initWithFrame:CGRectMake(0, buttonTop - 1, 320, 1)];
        
        _buttonLike = [[UIButton alloc] initWithFrame:CGRectMake(POSITION_RIGHT(_imageAtt) - 50 - MARGIN, POSITION_BOTTOM(_imageAtt) - 20 - MARGIN, 50, 20)];
        

        
        
        _buttonReply = [[UIButton alloc] initWithFrame:CGRectMake(POSITION_RIGHT(_buttonLike) + MARGIN, buttonTop, 55, buttonHeight)];
        _buttonFolk = [[UIButton alloc] initWithFrame:CGRectMake(POSITION_RIGHT(_buttonReply) + MARGIN, buttonTop, 50, buttonHeight)];
        _viewBottom = [[UIView alloc] initWithFrame:CGRectMake(POSITION_RIGHT(_viewLine), POSITION_BOTTOM(_buttonLike) - 1, 95 * 3, 2)];
        
        
        [_buttonLike setTitle:@"123" forState:UIControlStateNormal];
        [_buttonReply setTitle:@"Reply" forState:UIControlStateNormal];
        [_buttonFolk setTitle:@"Pick" forState:UIControlStateNormal];
        _labelWriter.text = @"Sample - 19 November 2013";
        


        
        [self decorate];
        [self addEvent];
        
        [_viewGroup addSubview:_imageAtt];



        [_viewInfo addSubview:_imageProfile];
        [_viewInfo addSubview:_labelSubject];
        [_viewInfo addSubview:_labelWriter];

        
        [_viewGroup addSubview:_buttonLike];
        [_viewGroup addSubview:_buttonReply];
        [_viewGroup addSubview:_buttonFolk];
        //[_viewGroup addSubview:_viewTop];
        //[_viewGroup addSubview:_viewBottom];
        //[self addSubview:_viewLine];
        [self addSubview:_viewGroup];
        [self addSubview:_viewInfo];


    }
    return self;
}
- (void) createImageButton:(UIButton*)button WithSize:(int)size WithX:(int)x {
    
    int width = button.frame.size.width;
    int height = button.frame.size.height;
    
    int imageWidth = button.imageView.image.size.width;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth + 18, 0, 0);
    button.imageEdgeInsets  = UIEdgeInsetsMake(height/2 - size/2, x, height/2 - size/2, width - x - size);
    
}
- (void) decorate {
    UIFont* font = FONT(@"HelveticaNeue-Medium", 11);
    _viewGroup.backgroundColor = WHITE;
    _viewGroup.layer.masksToBounds = true;
    _viewGroup.layer.cornerRadius = 4;


    
    //_buttonLike.backgroundColor = RGB(250,250,250);
    //_buttonReply.backgroundColor = RGB(250,250,250);
    //_buttonFolk.backgroundColor = RGB(250,250,250);


//    
//    //[_buttonLike setImage:resizeableImage forState:UIControlStateNormal];
//    [_buttonLike setImage:heart forState:UIControlStateNormal];
//    [_buttonReply setImage:heart forState:UIControlStateNormal];
//    [_buttonFolk setImage:heart forState:UIControlStateNormal];
//    
//    
//
////    _buttonLike.contentEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
////    _buttonReply.contentEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
////    _buttonFolk.contentEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
////
//    [self createImageButton:_buttonLike WithSize:16 WithX:24];
//    [self createImageButton:_buttonReply WithSize:16 WithX:24];
//    [self createImageButton:_buttonFolk WithSize:16 WithX:24];

    //40  12  12   24 + 16
    _buttonLike.titleLabel.font = font;
    _buttonReply.titleLabel.font = font;
    _buttonFolk.titleLabel.font = font;
    
    //_buttonLike.layer.borderWidth = 1.2;
    //_buttonLike.layer.cornerRadius = _buttonLike.frame.size.height / 2;
    //_buttonLike.layer.borderColor = nowColor.CGColor;

//    _buttonReply.layer.borderWidth = 1.2;
//    _buttonReply.layer.cornerRadius = _buttonReply.frame.size.height / 2;
//    _buttonReply.layer.borderColor = nowColor.CGColor;
    
//    _buttonFolk.layer.borderWidth = 1.2;
//    _buttonFolk.layer.cornerRadius = _buttonFolk.frame.size.height / 2;
//    _buttonFolk.layer.borderColor = nowColor.CGColor;
    
    
    [_buttonLike setImage:IMAGE(@"buttonHeart_hover.png") forState:UIControlStateNormal];
    [_buttonReply setImage:IMAGE(@"chat.png") forState:UIControlStateNormal];
    
    [self createImageButton:_buttonLike WithSize:15 WithX:5];
    [self createImageButton:_buttonReply WithSize:15 WithX:5];
    
    UIImage *sample = [UIImage imageNamed:@"Bubble-Background-PSD---cssauthor.com.png"];
    [self.imageAtt setImage:sample];
    [self.imageProfile setImage:sample];
    
    _imageProfile.layer.cornerRadius = 4;
    _imageProfile.layer.masksToBounds = YES;
    
    //_imageAtt.layer.cornerRadius = 2;
    _imageAtt.layer.masksToBounds = YES;
    
    //_viewGroup.backgroundColor = [UIColor clearColor];//[UIColor whiteColor];
    
    self.backgroundColor = RGB(230,230,230);
    
    
    //살짝 그라데이션?
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = _viewInfo.bounds;
    gradient.colors = [NSArray arrayWithObjects:RGBA(0, 0, 0, 0).CGColor, RGBA(0, 0, 0, 0.2).CGColor, nil];
    //[_viewInfo.layer insertSublayer:gradient atIndex:0];
    
    
    //_viewInfo.backgroundColor = RGBA(100, 100, 100, 0.2);
    _labelSubject.font = FONT(@"ArialRoundedMTBold", 13);
    _labelWriter.font = [UIFont fontWithName: @"HelveticaNeue-Medium" size: 10];
    
    //_labelWriter.textColor = RGB(50, 0, 230);
    _labelSubject.textColor = RGB(50, 50, 50);
    
    
    //_labelWriter.textColor = RGB(230, 230, 230);
    //_labelSubject.textColor = RGB(255, 255, 255);
    
//    _viewTop.backgroundColor = _viewBottom.backgroundColor = RGBA(220, 220, 220, 0.3);
//    _viewLine.backgroundColor = RGBA(220, 220, 220, 0.3);
    
    
}
- (void) addEvent {
    [_buttonLike addTarget:self
                       action:@selector(toggleLike:)
             forControlEvents:UIControlEventTouchUpInside];
    
//    UITapGestureRecognizer *singleTap = GestureTap(self, tapDetected);
//    singleTap.numberOfTapsRequired = 1;
//    _imageAtt.userInteractionEnabled = YES;
//    
//    [_imageAtt addGestureRecognizer:singleTap];

}
-(void)tapDetected{
    NSLog(@"single Tap on imageview");
    
}
- (void)toggleLike:(UIButton *)sender {
    
    sender.backgroundColor =  RGB(255,80,80);
    [sender setTitleColor:WHITE forState:UIControlStateNormal];
}
- (void) setAllColor:(UIColor *)color {
    [_buttonLike setTitleColor:color forState:UIControlStateNormal];
    [_buttonReply setTitleColor:color forState:UIControlStateNormal];
    [_buttonFolk setTitleColor:color forState:UIControlStateNormal];

    _labelWriter.textColor = color;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}



@end
