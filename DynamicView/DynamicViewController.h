//
//  DynamicViewController.h
//  CoreDataApp
//
//  Created by Helina Devaraj on 10/9/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface DynamicViewController : UIViewController
{
    IBOutlet UILabel *titleLbl;
}

@property(strong,nonatomic)NSString *titleLabel;
@property (strong,nonatomic)NSString *activityId;

@property (weak, nonatomic) IBOutlet UITableView *dynamicViewTable;
- (IBAction)submitButton:(id)sender;

@end
