//
//  DropdownCell.h
//  CoreDataApp
//
//  Created by Helina Devaraj on 10/9/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropdownCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dropdownQuest_Lbl;
@property (weak, nonatomic) IBOutlet UIButton *dropdownAnswer_btn;

@property (weak, nonatomic) IBOutlet UILabel *dropdownID;
@end
