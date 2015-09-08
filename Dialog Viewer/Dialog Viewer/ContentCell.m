//
//  ContentCell.m
//  Dialog Viewer
//
//  Created by 赖显波 on 8/27/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "ContentCell.h"

@implementation ContentCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if(self) {
        // init
        self.label = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        self.label.opaque = NO;
        self.label.backgroundColor = [UIColor colorWithRed:0.8 green:0.9 blue:1.0 alpha:1.0];
        self.label.textColor = [UIColor blackColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [[self class] defaultFont];
        [self.contentView addSubview:self.label];
    }
    
    return self;
}

+ (UIFont *)defaultFont {
    return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

+ (CGSize)sizeForContentString:(NSString *)str {
    CGSize maxSize = CGSizeMake(300, 1000);
    
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    NSDictionary *attributes = @{NSFontAttributeName: [self defaultFont], NSParagraphStyleAttributeName: style};
    
    CGRect rect = [str boundingRectWithSize:maxSize options:opts attributes:attributes context:nil];
    
    return rect.size;
}

- (NSString *)text {
    return self.label.text;
}

- (void)setText:(NSString *)text {
    self.label.text = text;
    
    CGRect newLabelFrame = self.label.frame;
    CGRect newContentFrame = self.contentView.frame;
    CGSize textSize = [[self class] sizeForContentString:text];
    
    newLabelFrame.size = textSize;
    newContentFrame.size = textSize;
    
    self.label.frame = newLabelFrame;
    self.contentView.frame = newContentFrame;
}

@end