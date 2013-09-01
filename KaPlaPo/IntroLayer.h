//
//  IntroLayer.h
//  KaPlaPo
//
//  Created by Yuta Mizushima on 2013/08/30.
//  Copyright (c) 2013年 Yuta Mizushima. All rights reserved.
//

#import "cocos2d.h"

@interface IntroLayer : CCLayer {}
@property(nonatomic, retain)CCSprite* displaySprite;
@property(nonatomic)NSInteger touchCount;

+(CCScene *) scene;

@end