//
//  RadioCell.h
//  CoreDataApp
//
//  Created by Helina Devaraj on 10/9/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadioCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *radioQuest_Lbl;
@property (weak, nonatomic) IBOutlet UIButton *radioBtn1;
@property (weak, nonatomic) IBOutlet UIButton *radioBtn2;
@property (weak, nonatomic) IBOutlet UILabel *radioLbl1;
@property (weak, nonatomic) IBOutlet UILabel *radioLbl2;
@property (weak, nonatomic) IBOutlet UILabel *radioQuestID;

@end
