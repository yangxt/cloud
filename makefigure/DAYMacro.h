//
//  DAYMacro.h
//  glpaint
//
//  Created by younkue on 2013. 12. 5..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#ifndef glpaint_DAYMacro_h
#define glpaint_DAYMacro_h

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define WHITE [UIColor whiteColor]
#define EMPTY @""
#define compare(a, b) [a isEqualToString:b]
#define ISEMPTY(a) [a isEqualToString:@""]
#define POSITION_RIGHT(a) a.frame.origin.x + a.frame.size.width
#define POSITION_BOTTOM(a) a.frame.origin.y + a.frame.size.height
#define POSITION_TOP(a) a.frame.origin.y
#define FIT_SIZE(label) [label sizeThatFits:CGSizeMake(200,200)]
#define GestureTap(s, func) [[UITapGestureRecognizer alloc] initWithTarget:s action:@selector(func)]
#define IMAGE(img) [UIImage imageNamed:img]
#define FONT(f, s) [UIFont fontWithName:f size: s];

#define TapGesture(s, obj, act){ UITapGestureRecognizer *singleTap = GestureTap(s, act);\
singleTap.numberOfTapsRequired = 1;\
obj.userInteractionEnabled = YES;\
[obj addGestureRecognizer:singleTap];}


#endif
