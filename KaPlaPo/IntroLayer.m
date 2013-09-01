//
//  IntroLayer.m
//  KaPlaPo
//
//  Created by Yuta Mizushima on 2013/08/30.
//  Copyright (c) 2013年 Yuta Mizushima. All rights reserved.
//

#import "IntroLayer.h"

#pragma mark - IntroLayer
@implementation IntroLayer
@synthesize displaySprite;

// Helper class method that creates a Scene with the TilesLayer as the only child.
+ (CCScene *) scene {
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.touchCount++;
    CGPoint location = [self getTouchEventPoint:(NSSet *)touches withEvent:(UIEvent *)event];
    int offX = location.x;
    int offY = location.y;
    [self nextStateX:offX Y:offY];
}

- (void)nextStateX:(NSInteger)offX Y:(NSInteger)offY{
    NSInteger restNum = self.touchCount%3;
    switch(restNum){
        case 0:
            [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"omote_blue.png"]];
            break;
        case 1:
            [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"omote_red.png"]];
            break;
        case 2:
            [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"ura.png"]];
            break;
    }
}

- (CGPoint)getTouchEventPoint:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch =[touches anyObject];
    CGPoint location =[touch locationInView:[touch view]];
    return [[CCDirector sharedDirector] convertToGL:location];
}

- (id) init {
	if( (self=[super init])) {
		CGSize size = [[CCDirector sharedDirector] winSize];
		CCSprite *background;
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			background = [CCSprite spriteWithFile:@"Default.png"];
		} else {
			background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
		}
		background.position = ccp(size.width/2, size.height/2);
		[self addChild: background];

        [CCDirector sharedDirector].displayStats = NO;
        self.touchEnabled = YES;
        
        self.displaySprite = [CCSprite spriteWithFile:@"omote_blue.png"];
        displaySprite.position = ccp(size.width/2, size.height/2);
        NSLog(@"size:%f width:%f", size.width, size.height);
        [self addChild:displaySprite];
	}
	return self;
}


- (void) onEnter {
	[super onEnter];
}

@end