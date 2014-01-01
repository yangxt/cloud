//
//  ListViewController.m
//  makefigure
//
//  Created by younkue on 2013. 11. 29..
//  Copyright (c) 2013년 daybrush. All rights reserved.
//

#import "ListViewController.h"
#import "DAYDataModel.h"
#import "PostViewController.h"
#import "ListMyCell.h"
#import "ListFirstViewCell.h"

#import "DAYBoardData.h"
#import <MobileCoreServices/MobileCoreServices.h>


@interface ListViewController ()
{
    NSArray *board_lists;
}
@end

@implementation ListViewController
{
    DAYDataModel* _dataModel;
    UIColor *color;
    DAYBoardData* _boardData;
    int goPostNum;
    BOOL is_readyGo;
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
    

    
    _dataModel = [[DAYDataModel alloc] init];
    _boardData = [[DAYBoardData alloc] init:self];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
//    
//    NSArray *familyNames = [UIFont familyNames];
//    for( NSString *familyName in familyNames ){
//        printf( "Family: %s \n", [familyName UTF8String] );
//        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
//        for( NSString *fontName in fontNames ){
//            printf( "\tFont: %s \n", [fontName UTF8String] );
//        }
//    }
//    
//
    color = RGB(63, 150, 219);
    UIColor* color_alpha = [color colorWithAlphaComponent:0.5];
    
    _viewBackground.backgroundColor = color;
    _viewTitleBar.backgroundColor = color_alpha;
    is_readyGo = false;
    
}
- (void)setReadyGo {
    is_readyGo = true;
    NSLog(@"isReady");
}
- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"isReady CHECK");
    if(is_readyGo) {
        [self performSegueWithIdentifier:@"readPost" sender:self.view];
        is_readyGo = false;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) saveBoardArray:(NSArray *)array {
    board_lists = array;
    [self.tableView reloadData];
    //NSLog(@"result json = %@", board_lists);
}

- (IBAction)newPost:(id)sender {
}

#pragma mark - DataSource
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 206;
}

- (NSInteger)tableView : (UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return board_lists.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Hello %d", indexPath.row);

    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    
    NSDictionary* item = [board_lists objectAtIndex:path.row ];
    NSLog(@"%@", item);
    [self setGoPostNum:[item[@"id"] intValue]];
    [self performSegueWithIdentifier:@"readPost" sender:self.view];

}
- (void)setGoPostNum:(int)postNum {
    goPostNum = postNum;
    
    NSLog(@"readyPostnum = %d",goPostNum);
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Assume self.view is the table view
    if(compare([segue identifier], @"readPost")) {
        //[nextView setPost:[_dataModel objectAtIndex:path.row]];

        PostViewController* nextView = (PostViewController *)segue.destinationViewController;
        [nextView setPostId:(NSInteger)goPostNum];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //NSLog(@"Scroll %f", scrollView.contentOffset.y);
    CGRect bound = [[UIScreen mainScreen] bounds];
    CGFloat height = 60 - scrollView.contentOffset.y / 2;
    int y = scrollView.contentOffset.y;
    if(y < 0)
    {
        height = 60;
    }
    else if(0 <= y && y < 60 * 2)
    {
        //_viewTitle.frame = CGRectMake(0, 0, 320, height);
    }
    else
    {
        height = 0;
       // _viewTitle.frame = CGRectMake(0, 0, 320, height);

    }
    //height = 60;
    _tableView.frame = CGRectMake(0, height, 320, bound.size.height - height);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    NSDictionary* item = [board_lists objectAtIndex:indexPath.row ];
    ListMyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    [cell init:item];
    
    
    return cell;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 미디어 선택이 끝나고 난 이후
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(__bridge id)kUTTypeImage])
    {
        UIImage* aImage = [info
                           objectForKey:UIImagePickerControllerOriginalImage];
        //
        UIAlertView *alertView1 = [[UIAlertView alloc] initWithTitle:@"이미지" message:@"골랐어요" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        alertView1.alertViewStyle = UIAlertViewStyleDefault;
        [picker dismissViewControllerAnimated:true completion:^{}];
        
        [alertView1 show];
    }
    NSLog(@"End select");
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController
                                        *)picker
{
        [picker dismissViewControllerAnimated:true completion:^{}];
    // 선택을 취소한 이후
    NSLog(@"Cancel select");
}

@end




