//
//  TinyPixDocument.m
//  TinyPix
//
//  Created by 赖显波 on 9/1/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "TinyPixDocument.h"

@interface TinyPixDocument ()

@property (strong, nonatomic) NSMutableData *bitmap;

@end

@implementation TinyPixDocument

- (id)initWithFileURL:(NSURL *)url {
    self = [super initWithFileURL:url];
    
    if (self) {
        unsigned char startPattern[] = {
            0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80
        };
        
        self.bitmap = [NSMutableData dataWithBytes:startPattern length:8];
    }
    
    return self;
}

- (BOOL)stateAtRow:(NSUInteger)row column:(NSUInteger)column {
    const char *bitmapBytes = [self.bitmap bytes];
    char rowByte = bitmapBytes[row];
    char result = (1 << column) & rowByte;
    if (result != 0) {
        return YES;
    } else {
        return NO;
    }
}

- (void)setState:(BOOL)state atRow:(NSInteger)row column:(NSUInteger)column {
    char *bitmapBytes = [self.bitmap mutableBytes];
    char *rowByte = &bitmapBytes[row];
    if (state) {
        *rowByte = *rowByte | (1 << column);
    } else {
        *rowByte = *rowByte & ~(1 << column);
    }
}

- (void)toggleStateAtRow:(NSUInteger)row column:(NSUInteger)column {
    BOOL state = [self stateAtRow:row column:column];
    [self setState:!state atRow:row column:column];
}

- (id)contentsForType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    NSLog(@"saving document to URL:%@", self.fileURL);
    return [self.bitmap copy];
}

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    NSLog(@"loading document from URL:%@", self.fileURL);
    self.bitmap = [contents mutableCopy];
    return true;
}

@end
