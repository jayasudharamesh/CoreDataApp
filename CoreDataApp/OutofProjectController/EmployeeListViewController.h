//
//  EmployeeListViewController.h
//  CoreDataApp
//
//  Created by Helina Devaraj on 7/31/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmployeeListViewController : UIViewController
{
   
}
@property (weak, nonatomic) IBOutlet UITableView *tableViewObj;
@property (strong,nonatomic)  NSMutableArray *arr_employeeNameList;
@end
