//
//  TextboxCell.h
//  CoreDataApp
//
//  Created by Helina Devaraj on 10/9/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextboxCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *textBoxQuest_Lbl;
@property (weak, nonatomic) IBOutlet UITextField *textAnswer_txt;
@property (weak, nonatomic) IBOutlet UILabel *textquestID;

@end
