//
//  TextboxCell.m
//  CoreDataApp
//
//  Created by Helina Devaraj on 10/9/18.
//  Copyright © 2018 Helina Devaraj. All rights reserved.
//

#import "TextboxCell.h"

@implementation TextboxCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 10)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    self.textAnswer_txt.inputAccessoryView = numberToolbar;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
    
}

-(void)doneWithNumberPad{
    NSString *numberFromTheKeyboard =  self.textAnswer_txt.text;
    [ self.textAnswer_txt resignFirstResponder];
    
}
@end
