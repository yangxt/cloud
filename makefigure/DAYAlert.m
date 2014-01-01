//
//  DAYAlert.m
//  glpaint
//
//  Created by younkue on 2013. 12. 5..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#import "DAYAlert.h"

@implementation DAYAlert

+ (void) showMessage:(id)delegate withMessage:(NSString*)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cloud"
                                                        message:message
                                                       delegate:delegate
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}
@end
