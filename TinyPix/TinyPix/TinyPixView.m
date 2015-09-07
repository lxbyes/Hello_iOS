//
//  TinyPixView.m
//  TinyPix
//
//  Created by 赖显波 on 9/1/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "TinyPixView.h"
#import "TinyPixDocument.h"

typedef struct {
    NSUInteger row;
    NSUInteger column;
} GridIndex;

@interface TinyPixView ()

@property (assign, nonatomic) CGSize blockSize;
@property (assign, nonatomic) CGSize gapSize;
@property (assign, nonatomic) GridIndex selectedBlockIndex;

@end

@implementation TinyPixView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if(self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    _blockSize = CGSizeMake(34, 34);
    _gapSize = CGSizeMake(5, 5);
    _selectedBlockIndex.row = NSNotFound;
    _selectedBlockIndex.column = NSNotFound;
}

- (void)drawRect:(CGRect)rect {
    if(!_document) {
        return;
    }
    
    for (NSUInteger row = 0; row < 8; row++) {
        for (NSUInteger column = 0; column < 8; column++) {
            [self drawBlockAtRow:row column:column];
        }
    }
}

- (void)drawBlockAtRow:(NSUInteger)row column:(NSUInteger)column {
    CGFloat startX = (_blockSize.width + _gapSize.width) * (7 - column) + 1;
    CGFloat startY = (_blockSize.height + _gapSize.height) * row +1;
    
    CGRect blockFrame = CGRectMake(startX, startY, _blockSize.width, _blockSize.height);
    
    UIColor *color = [_document stateAtRow:row column:column] ? [UIColor blackColor] : [UIColor whiteColor];
    [color setFill];
    [self.tintColor setStroke];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:blockFrame];
    [path fill];
    [path stroke];
}

- (GridIndex)touchedGridIndexFromTouches:(NSSet *)touches {
    GridIndex result;
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    result.row = location.y * 8.0 / self.bounds.size.height;
    result.column = 8 - (location.x * 8.0 / self.bounds.size.width);
    return result;
}

- (void)toggleSelectedBlock {
    [_document toggleStateAtRow:_selectedBlockIndex.row column:_selectedBlockIndex.column];
    [[_document.undoManager prepareWithInvocationTarget:_document] toggleStateAtRow:_selectedBlockIndex.row column:_selectedBlockIndex.column];
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.selectedBlockIndex = [self touchedGridIndexFromTouches:touches];
    [self toggleSelectedBlock];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    GridIndex touched = [self touchedGridIndexFromTouches:touches];
    
    if(touched.row != _selectedBlockIndex.row || touched.column != _selectedBlockIndex.column) {
        _selectedBlockIndex = touched;
        [self toggleSelectedBlock];
    }
}

@end
