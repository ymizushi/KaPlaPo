//
//  PrimitiveLayer.m
//  KaPlaPo
//
//  Created by Yuta Mizushima on 2013/09/01.
//  Copyright (c) 2013年 Yuta Mizushima. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "PrimitiveLayer.h"

#import "cocos2d.h"

@implementation PrimitiveLayer

-(void) draw

{
    glLineWidth(2.0f);
    CGPoint p1,p2;
    p1=CGPointMake(10,10);
    p2=CGPointMake(50,50);
    ccDrawColor4F(0.0f, 0.0f, 0.5f, 1.0f);
    ccDrawLine(p1, p2);
}

@end
