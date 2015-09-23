//
//  ClockFaceViewController.h
//  CoreAnimation
//
//  Created by 赖显波 on 9/18/15.
//  Copyright © 2015 Leckie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClockFace.h"

@interface ClockFaceViewController : UIViewController

@property (strong, nonatomic) ClockFace *clockFace;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
