//
//  PostViewController.m
//  glpaint
//
//  Created by younkue on 2013. 12. 5..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#import "PostViewController.h"
#import "DAYBoardPostData.h"
#import "DAYAlert.h"
#import "UIImageView+WebCache.h"
#import "CommentCell.h"
@interface PostViewController ()

@end

@implementation PostViewController
{
    DAYBoardPostData* data;
    NSDictionary* board;
    NSArray* comments;
    int postNum;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    
    _imageProfile.layer.cornerRadius = 2;
    _imageAtt.layer.cornerRadius = 2;
    _buttonLike.layer.cornerRadius = 3;
    
    //_imageProfile.layer.borderWidth = 2;
    //_imageProfile.layer.borderColor = RGB(255,255,255).CGColor;
    
    _imageAtt.layer.masksToBounds = YES;
    _imageProfile.layer.masksToBounds = YES;
    

    
}
- (void)viewDidAppear:(BOOL)animated {
    if(post == nil) {
        data = [[DAYBoardPostData alloc] init:self withId:postNum];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ClickLike:(id)sender {
        _buttonLike.backgroundColor = RGB(68,189,71);
}
- (void)setPostId:(int)no {
    postNum = no;
}

- (IBAction)buttonBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showReply:(id)sender {
    //[self performSegueWithIdentifier:@"readComment" sender:self.view];
    [DAYAlert showMessage:self withMessage:@"준비중입니다."];
}
- (BOOL) setPost:(NSDictionary *)_post
{
    if([_post objectForKey:@"err"]) {
        [DAYAlert showMessage:self withMessage:[_post objectForKey:@"desc"]];
        [self.navigationController popViewControllerAnimated:YES];
        return FALSE;
    }
    post = _post;
    
    NSLog(@"%@", post);
    [_textSubject setText: [post objectForKey:@"title"]];
    [_textContents setText:[post objectForKey:@"contents"]];
    
    
    comments = [post objectForKey:@"comments"];
    
    NSString* url;
    if([post objectForKey:@"filename"] && [post objectForKey:@"filename"] != [NSNull null]  &&  [post objectForKey:@"filename"] != NULL ) {//IOS상에서는 [NSNull null]. 이게 진짜 널인가 보다. ㅋㅋ
        url = [NSString stringWithFormat:@"%@%@", @"http://localhost:8080/images/", [post objectForKey:@"filename"]];
    } else
        url = @"http://localhost:8080/img/noimage.png";//이미지 파일이 없을 때
    
    [_imageAtt setImageWithURL:url];
    
    [_tableView reloadData];
    
    
    return TRUE;
}


#pragma TABLE


#pragma mark - DataSource
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 52;
}

- (NSInteger)tableView : (UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return comments.count > 4 ? 4 : comments.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Hello %d", indexPath.row);
    
    
    //[self performSegueWithIdentifier:@"readComment" sender:self.view];

    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Assume self.view is the table view
    if(compare([segue identifier], @"readComment")) {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSDictionary* comment = [comments objectAtIndex:indexPath.row ];
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    [cell init:comment];
    
    
    return cell;
}

@end
