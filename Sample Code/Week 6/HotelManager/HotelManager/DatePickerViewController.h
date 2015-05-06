//
//  DatePickerViewController.h
//  HotelManager
//
//  Created by Bradley Johnson on 5/5/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerViewController : UIViewController

@property (strong,nonatomic) UIDatePicker *datePicker;
@property (strong,nonatomic) UILabel *instructionsLabel;
@property (strong,nonatomic) UIButton *nextButton;

@end
