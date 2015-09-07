//
//  PhysicsCategories.h
//  TextShooter
//
//  Created by 赖显波 on 9/6/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#ifndef TextShooter_PhysicsCategories_h
#define TextShooter_PhysicsCategories_h

typedef NS_OPTIONS(uint32_t, PhysicsCategory) {
    PlayerCategory = 1 << 1,
    EnemyCategory = 1 << 2,
    PlayerMissileCategory = 1 << 3
};

#endif
