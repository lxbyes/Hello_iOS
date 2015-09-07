//
//  FavoritesList.h
//  Fonts
//
//  Created by 赖显波 on 8/26/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoritesList : NSObject

+ (instancetype)sharedFavoritesList;

- (NSArray *)favorites;

- (void)addFavorite:(id)item;

- (void)removeFavorite:(id)item;

- (void)moveItemAtIndex:(NSInteger)from toIndex:(NSInteger)to;

@end
