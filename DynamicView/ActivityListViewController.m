//
//  ActivityListViewController.m
//  CoreDataApp
//
//  Created by Helina Devaraj on 10/9/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import "ActivityListViewController.h"
#import "DynamicViewController.h"

@interface ActivityListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *activityList_arr;
    NSMutableArray *activityID_arr;
}

@end

@implementation ActivityListViewController
@synthesize activityListTableview;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSError *error;
    NSString *url_string = [NSString stringWithFormat: @"http://52.74.228.143:808/ActivityServices/ActivityService.svc/GetSurveyList?CustomerId=TEST&ActivitySepId=1&EmployeeId=IKYA004"];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSLog(@"json: %@", jsonDic);
    
    activityListTableview.delegate=self;
    activityListTableview.dataSource=self;
    
    activityList_arr=[[NSMutableArray alloc]init];
    activityList_arr=[jsonDic objectForKey:@"lstSurveyNames"];
    activityID_arr=[[NSMutableArray alloc]init];
    activityID_arr=[jsonDic objectForKey:@"lstSurveyIds"];
    
    [activityListTableview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return activityList_arr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    cell.textLabel.text=[activityList_arr objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DynamicViewController *dynamicVC=[self.storyboard instantiateViewControllerWithIdentifier:@"dynamicVC"];
    dynamicVC.activityId=[activityID_arr objectAtIndex:indexPath.row];
    dynamicVC.titleLabel=[activityList_arr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:dynamicVC animated:YES];
}
@end
