//
//  PhotoCell.h
//  CoreDataApp
//
//  Created by Helina Devaraj on 10/9/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *photoQuest_Lbl;
@property (weak, nonatomic) IBOutlet UIButton *photoAnswer_Btn;
@property (weak, nonatomic) IBOutlet UILabel *photoQuesID;

@end
