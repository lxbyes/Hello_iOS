//
//  People.h
//  OCDemo
//
//  Created by 赖显波 on 9/4/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

// 类内使用成员变量， 类外部使用属性

#import <Foundation/Foundation.h>

@interface People : NSObject
{
    NSString *_peopleName;
    int _peopleAge;
    int _peopleGender;
}

@end
