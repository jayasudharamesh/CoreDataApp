//
//  RatingCell.h
//  CoreDataApp
//
//  Created by Helina Devaraj on 10/9/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"

@interface RatingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ratingQues_Lb;

@property (weak, nonatomic) IBOutlet UILabel *ratingQuestID;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *starRatingView;
@end
