//
//  CCAppDelegate.m
//  KaPlaPo
//
//  Created by Yuta Mizushima on 2013/08/30.
//  Copyright (c) 2013年 Yuta Mizushima. All rights reserved.
//

#import "CCAppDelegate.h"

@interface CCAppDelegate ()

@property (weak, nonatomic) CCDirectorIOS *director;
@property (strong, nonatomic) UINavigationController *rootViewController;

@end

@implementation CCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    CCGLView *glView = [CCGLView viewWithFrame:self.window.bounds
                                   pixelFormat:kEAGLColorFormatRGB565
                                   depthFormat:0
                            preserveBackbuffer:NO
                                    sharegroup:nil
                                 multiSampling:NO
                               numberOfSamples:0];
    
    self.director = (CCDirectorIOS *)[CCDirector sharedDirector];
    self.director.wantsFullScreenLayout = YES;
    self.director.displayStats = NO;
    self.director.animationInterval = 1.0/60;
    self.director.view = glView;
    self.director.delegate = self;
    self.director.projection = kCCDirectorProjection2D;
    
    [self.director enableRetinaDisplay:YES];
    
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
    
    CCFileUtils *fileUtils = [CCFileUtils sharedFileUtils];
    [fileUtils setEnableFallbackSuffixes:NO];
    [fileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];
    [fileUtils setiPadSuffix:@"-ipad"];
    [fileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];
    
    [CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
    
    //[self.director pushScene:[IntroLayer scene]];
    
    self.rootViewController = [[UINavigationController alloc] initWithRootViewController:self.director];
    self.rootViewController.navigationBarHidden = YES;
    
    self.window.rootViewController = self.rootViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    if (self.rootViewController.visibleViewController == self.director) {
        [self.director pause];
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    if (self.rootViewController.visibleViewController == self.director) {
        [self.director stopAnimation];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    if (self.rootViewController.visibleViewController == self.director) {
        [self.director startAnimation];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    if (self.rootViewController.visibleViewController == self.director) {
        [self.director resume];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    CC_DIRECTOR_END();
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [self.director purgeCachedData];
}

- (void)applicationSignificantTimeChange:(UIApplication *)application
{
    self.director.nextDeltaTimeZero = YES;
}

@end