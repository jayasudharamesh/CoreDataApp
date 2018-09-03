//
//  NewTableViewCell.h
//  CoreDataApp
//
//  Created by Helina Devaraj on 9/3/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *days_btn;
@property (weak, nonatomic) IBOutlet UITextField *status_btn;

@property (weak, nonatomic) IBOutlet UILabel *name_Lbl;
@property (weak, nonatomic) IBOutlet UIButton *btn_days;
@property (weak, nonatomic) IBOutlet UIButton *btn_status;

@end
