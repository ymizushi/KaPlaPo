//
//  IntroLayer.m
//  KaPlaPo
//
//  Created by Yuta Mizushima on 2013/08/30.
//  Copyright (c) 2013年 Yuta Mizushima. All rights reserved.
//

#import "IntroLayer.h"

#import "PrimitiveLayer.h"

#pragma mark - IntroLayer
@implementation IntroLayer
@synthesize displaySprite;
@synthesize controlPanelNode;
@synthesize targetPanelNode;
@synthesize startTouchPoint;

// Helper class method that creates a Scene with the TilesLayer as the only child.
+ (CCScene *) scene {
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
    PrimitiveLayer *pLayer = [PrimitiveLayer node];
    [scene addChild:pLayer];
	
	// return the scene
	return scene;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.touchCount++;
    CGPoint location = [self getTouchEventPoint:(NSSet *)touches withEvent:(UIEvent *)event];
    self.startTouchPoint = location;
    int offX = location.x;
    int offY = location.y;
    [self nextStateX:offX Y:offY];
    
    [self drawControlPanelX:offX Y:offY];
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint location = [self getTouchEventPoint:(NSSet *)touches withEvent:(UIEvent *)event];
    int x = location.x;
    int y = location.y;
    int sx = self.startTouchPoint.x;
    int sy = self.startTouchPoint.y;
    // 1
    if(sx-BS < x && x < sx+BS &&
       sy+BS < y ) {
        [self drawControlPanelX:sx Y:sy+2*BS];
        [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"half.png"]];
    }
    // 2
    if(sx+BS < x &&
       sy+BS < y ) {
        [self drawControlPanelX:sx+2*BS Y:sy+2*BS];
        [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"1.png"]];
    }
    // 3
    if(sx+BS < x &&
       sy-BS < y && y < sy+BS) {
        [self drawControlPanelX:sx+2*BS Y:sy];
        [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"2.png"]];
    }
    // 4
    if(sx+BS < x &&
       y < sy-BS) {
        [self drawControlPanelX:sx+2*BS Y:sy-2*BS];
        [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"3.png"]];
    }
    // 5
    if(sx-BS < x && x < sx+BS &&
       y < sy-BS) {
        [self drawControlPanelX:sx Y:sy-2*BS];
        [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"5.png"]];
    }
    // 6
    if(x < sx-BS &&
       y < sy-BS) {
        [self drawControlPanelX:sx-2*BS Y:sy-2*BS];
        [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"8.png"]];
    }
    // 7
    if(x < sx-BS &&
       sy-BS < y && y < sy+BS) {
        [self drawControlPanelX:sx-2*BS Y:sy];
        [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"13.png"]];
    }
    // 8
    if(x < sx-BS &&
       sy+BS < y ) {
        [self drawControlPanelX:sx-2*BS Y:sy+2*BS];
        [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"question.png"]];
    }
}


- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self drawControlPanelX:-200 Y:-200];
}

- (void)nextStateX:(NSInteger)offX Y:(NSInteger)offY{
//    NSInteger restNum = self.touchCount%3;
//    switch(restNum){
//        case 0:
//            [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"omote_blue.png"]];
//            break;
//        case 1:
//            [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"omote_red.png"]];
//            break;
//        case 2:
//            [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"ura.png"]];
//            break;
//    }
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
        self.controlPanelNode = [CCDrawNode node];
        [self initControlPanel];
        
	}
	return self;
}


- (void) onEnter {
	[super onEnter];
}


- (void) initControlPanel {
    CGPoint square[] = {{-30,-30}, {30,-30}, {30,30}, {-30, 30}};
    ccColor4F green = {0, 1, 0, 1};
    
    [self.controlPanelNode drawPolyWithVerts:square count:4 fillColor:green borderWidth:2 borderColor:green];
    self.controlPanelNode.position = ccp(-200, -200);
    [self addChild:self.controlPanelNode];
}

- (void) initTargetPanel {
    CGPoint square[] = {{-BLOCK_SIZE,-BLOCK_SIZE}, {BLOCK_SIZE,-BLOCK_SIZE}, {BLOCK_SIZE,BLOCK_SIZE}, {-BLOCK_SIZE, BLOCK_SIZE}};
    ccColor4F green = {0, 1, 0, 1};
    
    [self.controlPanelNode drawPolyWithVerts:square count:4 fillColor:green borderWidth:2 borderColor:green];
    
    self.targetPanelNode.position = ccp(-200, -200);
    [self addChild:self.targetPanelNode];
}

- (void) drawControlPanelX:(NSInteger)x Y:(NSInteger)y{
    self.controlPanelNode.position = ccp(x, y);
}

- (void) drawTargetPanelX:(NSInteger)x Y:(NSInteger)y{
    self.targetPanelNode.position = ccp(x, y);
}


@end