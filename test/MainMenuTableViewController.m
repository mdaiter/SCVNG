//
//  MainMenuTableViewController.m
//  test
//
//  Created by Matthew Daiter on 8/7/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import "MainMenuTableViewController.h"
#import "SwipeViewController.h"
#import "SearchMapViewController.h"
#import "UserViewController.h"

@interface MainMenuTableViewController ()

@property (nonatomic, strong) UIImageView* image_background;

@property (nonatomic, strong) NSDictionary* screen_dict_classes;


@end

@implementation MainMenuTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSString*)paneViewControllerTypeForIndexPath:(NSIndexPath*)indexPath{
    switch (indexPath.row){
        case 0:
            return @"SearchMapView";
        case 1:
            return @"SwipeViewController";
        case 2:
            return @"UserViewController";
        default:
            return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* paneViewControllerType = [self paneViewControllerTypeForIndexPath:indexPath];
    [self.delegate transitionToViewController:paneViewControllerType withSender:self];
    
    // Prevent visual display bug with cell dividers
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    /*double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.tableView reloadData];
    });*/
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //self.delegate = self;
    [self setup_background];
    self.menu_items = [NSArray arrayWithObjects:@"Map", @"Swipe", @"User", @"Settings", nil];
    
}

-(void)setup_background{
    UIImageView *temp_image_background = [self image_background];
    [temp_image_background setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = temp_image_background;
}

- (UIImageView *)image_background
{
    if (!_image_background) {
        _image_background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Window Background"]];
    }
    return _image_background;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.menu_items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    // Configure the cell...
    
    cell.textLabel.text = self.menu_items[indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:18.0];
    UIView *selectedBackgroundView = [UIView new];
    selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.25];
    cell.selectedBackgroundView = selectedBackgroundView;
    
    CGRect lineFrame = CGRectMake(0,cell.frame.size.height-1,cell.frame.size.width,1);
    UIView *line = [[UIView alloc] initWithFrame:lineFrame];
    line.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [cell.contentView addSubview:line];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
