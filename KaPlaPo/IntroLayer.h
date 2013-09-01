//
//  IntroLayer.h
//  KaPlaPo
//
//  Created by Yuta Mizushima on 2013/08/30.
//  Copyright (c) 2013年 Yuta Mizushima. All rights reserved.
//

#import "cocos2d.h"

#define BLOCK_SIZE 30
#define BS 30

@interface IntroLayer : CCLayer {}
@property(nonatomic, retain)CCSprite* displaySprite;
@property(nonatomic)NSInteger touchCount;
@property(nonatomic, retain)CCDrawNode* controlPanelNode;
@property(nonatomic, retain)CCDrawNode* targetPanelNode;
@property(nonatomic)CGPoint startTouchPoint;

+(CCScene *) scene;

@end