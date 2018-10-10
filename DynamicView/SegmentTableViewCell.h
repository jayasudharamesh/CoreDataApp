//
//  SegmentTableViewCell.h
//  CoreDataApp
//
//  Created by Helina Devaraj on 10/10/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *segmentQuestLbl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl_seg;
@property (weak, nonatomic) IBOutlet UILabel *segmentQuestID;

@end
