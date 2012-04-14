//
//  HelloWorldLayer.m
//  ParallaxOctocat
//
//  Created by so matsuda on 12/04/14.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void)accelerometer:(UIAccelerometer *)acel didAccelerate:(UIAcceleration *)acceleration {
    
    //どのくらい減速するか制御する。
    float ocDeceleration = 0.1f;
    float bgDeceleration = 0.7f;
    float b2Deceleration = 0.6f;
    float b1Deceleration = 0.5f;
    
    //加速度センサーの感度
    float ocSensitivity = 0.5f;
    float bgSensitivity = 10.0f;
    float b2Sensitivity = 9.0f;
    float b1Sensitivity = 8.0f;
    
    //最大速度
    float ocMaxVelocity = 1.0;
    float bgMaxVelocity = 10.0;
    float b2MaxVelocity = 10.0;
    float b1MaxVelocity = 10.0;

    
    //現在の加速度センサーの加速に基づいて速度を調整する。
    octocatVelocity_.x = (octocatVelocity_.x * ocDeceleration) + (acceleration.y * ocSensitivity);
    bgVelocity_.x = (bgVelocity_.x * bgDeceleration) + (acceleration.y * bgSensitivity);
    b1Velocity_.x = (b1Velocity_.x * b1Deceleration) + (acceleration.y * b1Sensitivity);
    b2Velocity_.x = (b2Velocity_.x * b2Deceleration) + (acceleration.y * b2Sensitivity);
    
    //オクトキャットの最大速度の制限
    if (octocatVelocity_.x > ocMaxVelocity) 
    {
        octocatVelocity_.x = ocMaxVelocity;
    }
    else if (octocatVelocity_.x < -ocMaxVelocity) 
    {
        octocatVelocity_.x = -ocMaxVelocity;
    }
    
    //背景の最大速度の制限
    if (bgVelocity_.x > bgMaxVelocity) 
    {
        bgVelocity_.x = bgMaxVelocity;
    }
    else if (bgVelocity_.x < -bgMaxVelocity)
    {
        bgVelocity_.x = -bgMaxVelocity;
    }
    
    //buil1の最大速度の制限
    if (b1Velocity_.x > b1MaxVelocity) 
    {
        b1Velocity_.x = b1MaxVelocity;
    }
    else if (b1Velocity_.x < -b1MaxVelocity)
    {
        b1Velocity_.x = -b1MaxVelocity;
    }

    //buil2の最大速度の制限
    if (b2Velocity_.x > b2MaxVelocity) 
    {
        b2Velocity_.x = b2MaxVelocity;
    }
    else if (b2Velocity_.x < -b2MaxVelocity)
    {
        b2Velocity_.x = -b2MaxVelocity;
    }

    
}

- (void)update:(ccTime)delta
{
    //フレームごとにoctocatVelocityをオクトキャットの位置に追加する
    CGPoint octocatPos = octocat_.position;
    CGPoint octocatShadowPos = octocatShadow_.position;
    //octocatPos.x += octocatVelocity_.x;
    octocatShadowPos.x += octocatVelocity_.x;
    
    //フレームごとにbgVelocityを背景の位置にマイナスで追加する。
    CGPoint bgPos = background_.position;
    bgPos.x = bgPos.x - bgVelocity_.x;
    
    //フレームごとにb1Velocityをビル１（大きい方）にマイナスで追加する
    CGPoint b1Pos = buil1_.position;
    b1Pos.x = b1Pos.x - b1Velocity_.x;
    
    //フレームごとにb2Velocityをビル２（小さい方）にマイナスで追加する
    CGPoint b2Pos = buil2_.position;
    b2Pos.x = b2Pos.x - b2Velocity_.x;
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    //オクトキャットの影の動作範囲を制御する。
    float octocatWidthHalved = [octocat_ texture].contentSize.width * 0.1f;
    float ocLeftBoarderLimit = center_.x - octocatWidthHalved;
    float ocRightBoarderLimit = center_.x + octocatWidthHalved;
    
    //背景を止めてスクリーンの外に出ないようにする。
    float bgLeftLimit =  10.0f;
    float bgRightLimit = screenSize.width - 10.0f;

    //ビル１を止めてスクリーンの外に出ないようにする。
    float b1LeftLimit = - [buil1_ texture].contentSize.width * 0.5f;
    float b1RightLimit = screenSize.width + [buil1_ texture].contentSize.width * 0.5f;

    //ビル２を止めてスクリーンの外に出ないようにする。
    float b2LeftLimit = - [buil1_ texture].contentSize.width * 0.5f;
    float b2RightLimit = screenSize.width + [buil1_ texture].contentSize.width * 0.5f;
    
    //影が境界を超えたら止める。
    if (octocatShadowPos.x < ocLeftBoarderLimit) 
    {
        octocatPos.x = ocLeftBoarderLimit;
        octocatShadowPos.x = ocLeftBoarderLimit;
        octocatVelocity_ = CGPointZero;
    }
    else if (octocatShadowPos.x > ocRightBoarderLimit)
    {
        octocatPos.x = ocRightBoarderLimit;
        octocatShadowPos.x = ocRightBoarderLimit;
        octocatVelocity_ = CGPointZero;
    }
    
    //背景が境界を超えたら止める。
    if (bgPos.x < bgLeftLimit) 
    {
        bgPos.x = bgLeftLimit;
        bgVelocity_ = CGPointZero;
    }
    else if (bgPos.x > bgRightLimit)
    {
        bgPos.x = bgRightLimit;
        bgVelocity_ = CGPointZero;
    }
    
    //ビル１が境界を超えたら止める。
    if (b1Pos.x < b1LeftLimit) 
    {
        b1Pos.x = b1LeftLimit;
        b1Velocity_ = CGPointZero;
    }
    else if (b1Pos.x > b1RightLimit)
    {
        b1Pos.x = b1RightLimit;
        b1Velocity_ = CGPointZero;
    }
    
    //ビル2が境界を超えたら止める。
    if (b2Pos.x < b2LeftLimit) 
    {
        b2Pos.x = b2LeftLimit;
        b2Velocity_ = CGPointZero;
    }
    else if (b2Pos.x > b2RightLimit)
    {
        b2Pos.x = b2RightLimit;
        b2Velocity_ = CGPointZero;
    }

    //octocat_.position = octocatPos;
    octocatShadow_.position = octocatShadowPos;
    background_.position = bgPos;
    buil1_.position = b1Pos;
    buil2_.position = b2Pos;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        // enable accelerometer
        self.isAccelerometerEnabled = YES;
        [[UIAccelerometer sharedAccelerometer] setUpdateInterval:(6.0/60.0)];
        
		background_ = [CCSprite spriteWithFile:@"parallax_bg.jpeg"];
        [self addChild:background_ z:0 tag:1];
        
        buil2_ = [CCSprite spriteWithFile:@"parallax_building_2.png"];
        [self addChild:buil2_ z:10 tag:2];
        
        buil1_ = [CCSprite spriteWithFile:@"parallax_building_1.png"];
        [self addChild:buil1_ z:20 tag:3];
        
        octocat_ = [CCSprite spriteWithFile:@"parallax_octocat.png"];
        [self addChild:octocat_ z:120 tag:2];
        
        octocatShadow_ = [CCSprite spriteWithFile:@"parallax_octocatshadow.png"];
        float octocatHeight = [octocat_ texture].contentSize.height;
        [self addChild:octocatShadow_ z:100 tag:2];
                
		// ask director the the window size
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
        center_ = CGPointMake(screenSize.width / 2, screenSize.height / 2);
        float shadowY = (screenSize.height / 2 - octocatHeight /2);
        background_.position = center_;
        octocat_.position = center_;
        buil1_.position = CGPointMake(screenSize.width *3 / 8, screenSize.height *2 / 3);
        buil2_.position = CGPointMake(screenSize.width *5 / 8, screenSize.height *2 / 3);
        octocatShadow_.position = CGPointMake(screenSize.width / 2, shadowY);
    
        //一定間隔で位置がアップデートされるようにセットアップする。
        [self scheduleUpdate];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
