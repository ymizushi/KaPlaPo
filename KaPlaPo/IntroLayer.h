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
#define BEFORE_STATE 0
#define READY_STATE 1
#define AFTER_STATE 2
#define PANEL_HALF 0
#define PANEL_1 1
#define PANEL_2 2
#define PANEL_3 3
#define PANEL_5 4
#define PANEL_8 5
#define PANEL_13 6
#define PANEL_QUESTION 7

@interface IntroLayer : CCLayer {}
@property(nonatomic, retain)CCSprite* displaySprite;
@property(nonatomic)NSInteger touchState;
@property(nonatomic)NSInteger selectedPanel;
@property(nonatomic, retain)CCDrawNode* controlPanelNode;
@property(nonatomic, retain)CCDrawNode* targetPanelNode;
@property(nonatomic)CGPoint startTouchPoint;

+(CCScene *) scene;

@end