//
//  RadioCell.h
//  CoreDataApp
//
//  Created by Helina Devaraj on 10/9/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButton.h"

@interface RadioCell : UITableViewCell
{
    RadioButton *rb1;
    RadioButton *rb2;
    UILabel *label1;
    UILabel *label2;
}
@property (weak, nonatomic) IBOutlet UILabel *radioQuest_Lbl;
@property (weak, nonatomic) IBOutlet UIButton *radioBtn1;
@property (weak, nonatomic) IBOutlet UIButton *radioBtn2;
@property (weak, nonatomic) IBOutlet UILabel *radioLbl1;
@property (weak, nonatomic) IBOutlet UILabel *radioLbl2;
@property (weak, nonatomic) IBOutlet UILabel *radioQuestID;

@end
