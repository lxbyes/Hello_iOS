//
//  TinyPixDocument.h
//  TinyPix
//
//  Created by 赖显波 on 9/1/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TinyPixDocument : UIDocument

- (BOOL)stateAtRow:(NSUInteger)row column:(NSUInteger)column;
- (void)setState:(BOOL)state atRow:(NSInteger)row column:(NSUInteger)column;
- (void)toggleStateAtRow:(NSUInteger)row column:(NSUInteger)column;

@end
