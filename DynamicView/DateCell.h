//
//  DateCell.h
//  CoreDataApp
//
//  Created by Helina Devaraj on 10/9/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerAnswer;
@property (weak, nonatomic) IBOutlet UILabel *datePickerQuest_Lbl;

@property (weak, nonatomic) IBOutlet UILabel *dateQuestID;
@end
