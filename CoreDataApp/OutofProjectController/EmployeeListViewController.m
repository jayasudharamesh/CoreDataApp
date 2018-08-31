//
//  EmployeeListViewController.m
//  CoreDataApp
//
//  Created by Helina Devaraj on 7/31/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import "EmployeeListViewController.h"

@interface EmployeeListViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation EmployeeListViewController
@synthesize tableViewObj,arr_employeeNameList;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    tableViewObj.delegate=self;
    tableViewObj.dataSource=self;
//    arr_employeeNameList=[[NSMutableArray alloc]init];
    
    NSLog(@"Employee List%@",arr_employeeNameList);
    
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [arr_employeeNameList count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    cell.textLabel.text=[arr_employeeNameList objectAtIndex:indexPath.row];
    return cell;
    
}
@end
