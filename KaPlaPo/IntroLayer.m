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
@synthesize touchState;
@synthesize selectedPanel;

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
        [self addChild:displaySprite];
        self.controlPanelNode = [CCDrawNode node];
        [self initControlPanel];
        
	}
	return self;
}

- (void) onEnter {
	[super onEnter];
}

+ (CCScene *) scene {
	CCScene *scene = [CCScene node];
    
	IntroLayer *layer = [IntroLayer node];
	[scene addChild: layer];
    
    PrimitiveLayer *pLayer = [PrimitiveLayer node];
    [scene addChild:pLayer];
    
	return scene;
}

- (CGPoint)getTouchEventPoint:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch =[touches anyObject];
    CGPoint location =[touch locationInView:[touch view]];
    return [[CCDirector sharedDirector] convertToGL:location];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.startTouchPoint = [self getTouchEventPoint:(NSSet *)touches withEvent:(UIEvent *)event];
    if(self.touchState == BEFORE_STATE) {
        [self drawControlPanelX:self.startTouchPoint.x Y:self.startTouchPoint.y];
    }
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint location = [self getTouchEventPoint:(NSSet *)touches withEvent:(UIEvent *)event];
    int x = location.x;
    int y = location.y;
    int sx = self.startTouchPoint.x;
    int sy = self.startTouchPoint.y;
    
    if(self.touchState == BEFORE_STATE) {
        if(sx-BS < x && x < sx+BS &&
           sy+BS < y ) {
            [self drawControlPanelX:sx Y:sy+2*BS];
            [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"half.png"]];
            self.selectedPanel = PANEL_HALF;
        }
        if(sx+BS < x &&
           sy+BS < y ) {
            [self drawControlPanelX:sx+2*BS Y:sy+2*BS];
            [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"1.png"]];
            self.selectedPanel = PANEL_1;
        }
        if(sx+BS < x &&
           sy-BS < y && y < sy+BS) {
            [self drawControlPanelX:sx+2*BS Y:sy];
            [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"2.png"]];
            self.selectedPanel = PANEL_2;
        }
        if(sx+BS < x &&
           y < sy-BS) {
            [self drawControlPanelX:sx+2*BS Y:sy-2*BS];
            [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"3.png"]];
            self.selectedPanel = PANEL_3;
        }
        if(sx-BS < x && x < sx+BS &&
           y < sy-BS) {
            [self drawControlPanelX:sx Y:sy-2*BS];
            [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"5.png"]];
            self.selectedPanel = PANEL_5;
        }
        if(x < sx-BS &&
           y < sy-BS) {
            [self drawControlPanelX:sx-2*BS Y:sy-2*BS];
            [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"8.png"]];
            self.selectedPanel = PANEL_8;
        }
        if(x < sx-BS &&
           sy-BS < y && y < sy+BS) {
            [self drawControlPanelX:sx-2*BS Y:sy];
            [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"13.png"]];
            self.selectedPanel = PANEL_13;
        }
        if(x < sx-BS &&
           sy+BS < y ) {
            [self drawControlPanelX:sx-2*BS Y:sy+2*BS];
            [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"question.png"]];
            self.selectedPanel = PANEL_QUESTION;
        }
    }
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self drawControlPanelX:-400 Y:-400];
    
    if(self.touchState == BEFORE_STATE) {
        [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"omote_red.png"]];
        self.touchState = READY_STATE;
        return;
    }
    
    if(self.touchState == READY_STATE) {
        switch(self.selectedPanel) {
            case PANEL_HALF:
                [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"half.png"]];
                break;
            case PANEL_1:
                [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"1.png"]];
                break;
            case PANEL_2:
                [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"2.png"]];
                break;
            case PANEL_3:
                [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"3.png"]];
                break;
            case PANEL_5:
                [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"5.png"]];
                break;
            case PANEL_8:
                [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"8.png"]];
                break;
            case PANEL_13:
                [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"13.png"]];
                break;
            case PANEL_QUESTION:
                [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"question.png"]];
                break;
        }
        self.touchState = AFTER_STATE;
        return;
    }
    if(self.touchState == AFTER_STATE) {
        [displaySprite setTexture:[[CCTextureCache sharedTextureCache] addImage: @"omote_blue.png"]];
        self.touchState = BEFORE_STATE;
        return;
    }
}

- (void) initControlPanel {
    CGPoint square[] = {{-BS,-BS}, {BS,-BS}, {BS,BS}, {-BS, BS}};
    ccColor4F green = {0, 1, 0, 1};
    
    [self.controlPanelNode drawPolyWithVerts:square count:4 fillColor:green borderWidth:2 borderColor:green];
    self.controlPanelNode.position = ccp(-200, -200);
    [self addChild:self.controlPanelNode];
}

- (void) drawControlPanelX:(NSInteger)x Y:(NSInteger)y{
    self.controlPanelNode.position = ccp(x, y);
}

@end