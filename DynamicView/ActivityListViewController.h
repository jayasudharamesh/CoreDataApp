//
//  ActivityListViewController.h
//  CoreDataApp
//
//  Created by Helina Devaraj on 10/9/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *title_Lbl;
@property (weak, nonatomic) IBOutlet UITableView *activityListTableview;

@end
