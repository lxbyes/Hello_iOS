//
//  ContentCell.h
//  Dialog Viewer
//
//  Created by 赖显波 on 8/27/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *label;

@property (copy, nonatomic) NSString *text;

+ (CGSize)sizeForContentString:(NSString *)str;

@end
