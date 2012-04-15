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
    
    //水平方向＿どのくらい減速するか制御する。
    float x_ocDeceleration = 0.1f;
    float x_ocShadowDeceleration = 0.1f;
    float x_bgDeceleration = 0.7f;
    float x_b2Deceleration = 0.3f;
    float x_b1Deceleration = 0.3f;
    float spDeceleration = 1.0f;
    
    //垂直方向＿どのくらい減速するか制御する。
    float y_ocDeceleration = 0.1f;
    float y_ocShadowDeceleration = 0.1f;
    float y_bgDeceleration = 0.4f;
    float y_b2Deceleration = 0.1f;
    float y_b1Deceleration = 0.1f;
    
    //水平方向＿加速度センサーの感度
    float x_ocSensitivity = 0.5f;
    float x_ocShadowSensitivity = 0.5f;
    float x_bgSensitivity = 7.0f;
    float x_b2Sensitivity = 3.0f;
    float x_b1Sensitivity = 2.0f;
    float spSensitivity = 10.0f;
    
    //垂直方向＿加速度センサーの感度
    float y_ocSensitivity = 0.5f;
    float y_ocShadowSensitivity = 0.5f;
    float y_bgSensitivity = 0.5f;
    float y_b2Sensitivity = 0.7f;
    float y_b1Sensitivity = 0.5f;

    //水平方向＿最大速度
    float x_ocMaxVelocity = 1.0;
    float x_ocShadowMaxVelocity = 1.0;
    float x_bgMaxVelocity = 10.0;
    float x_b2MaxVelocity = 5.0;
    float x_b1MaxVelocity = 4.0;
    float spMaxVelocity = 15.0;
    
    //垂直方向＿最大速度
    float y_ocMaxVelocity = 1.0;
    float y_ocShadowMaxVelocity = 1.0;
    float y_bgMaxVelocity = 2.0;
    float y_b2MaxVelocity = 2.0;
    float y_b1MaxVelocity = 2.0;


    
    //現在の加速度センサーの加速に基づいて速度を調整する。
    octocatVelocity_.x = (octocatVelocity_.x * x_ocDeceleration) + (acceleration.y * x_ocSensitivity);
    ocShadowVelocity_.x = (ocShadowVelocity_.x * x_ocShadowDeceleration) + (acceleration.y * x_ocShadowSensitivity);
    bgVelocity_.x = (bgVelocity_.x * x_bgDeceleration) + (acceleration.y * x_bgSensitivity);
    b1Velocity_.x = (b1Velocity_.x * x_b1Deceleration) + (acceleration.y * x_b1Sensitivity);
    b2Velocity_.x = (b2Velocity_.x * x_b2Deceleration) + (acceleration.y * x_b2Sensitivity);
    
    speederVelocity_.x = (speederVelocity_.x * spDeceleration) + (acceleration.y * spSensitivity);
    
    octocatVelocity_.y = (octocatVelocity_.y * y_ocDeceleration) + (acceleration.x * y_ocSensitivity);
    ocShadowVelocity_.y = (ocShadowVelocity_.y * y_ocShadowDeceleration) + (acceleration.x * y_ocShadowSensitivity);
    bgVelocity_.y = (bgVelocity_.y * y_bgDeceleration) + (acceleration.x * y_bgSensitivity);
    b1Velocity_.y = (b1Velocity_.y * y_b1Deceleration) + (acceleration.x * y_b1Sensitivity);
    b2Velocity_.y = (b2Velocity_.y * y_b2Deceleration) + (acceleration.x * y_b2Sensitivity);

    
    //水平方向＿オクトキャットの最大速度の制限
    if (octocatVelocity_.x > x_ocMaxVelocity) 
    {
        octocatVelocity_.x = x_ocMaxVelocity;
    }
    else if (octocatVelocity_.x < -x_ocMaxVelocity) 
    {
        octocatVelocity_.x = -x_ocMaxVelocity;
    }
    
    //垂直方向＿オクトキャットの最大速度の制限
    if (octocatVelocity_.y > y_ocMaxVelocity) 
    {
        octocatVelocity_.y = y_ocMaxVelocity;
    }
    else if (octocatVelocity_.y < -y_ocMaxVelocity) 
    {
        octocatVelocity_.y = -y_ocMaxVelocity;
    }
    
    //（影）水平方向＿オクトキャットの最大速度の制限
    if (ocShadowVelocity_.x > x_ocShadowMaxVelocity) 
    {
        ocShadowVelocity_.x = x_ocShadowMaxVelocity;
    }
    else if (ocShadowVelocity_.x < -x_ocShadowMaxVelocity) 
    {
        ocShadowVelocity_.x = -x_ocShadowMaxVelocity;
    }
    
    //（影）垂直方向＿オクトキャットの最大速度の制限
    if (ocShadowVelocity_.y > y_ocShadowMaxVelocity) 
    {
        ocShadowVelocity_.y = y_ocShadowMaxVelocity;
    }
    else if (ocShadowVelocity_.y < -y_ocShadowMaxVelocity) 
    {
        ocShadowVelocity_.y = -y_ocShadowMaxVelocity;
    }
    
    //水平方向＿背景の最大速度の制限
    if (bgVelocity_.x > x_bgMaxVelocity) 
    {
        bgVelocity_.x = x_bgMaxVelocity;
    }
    else if (bgVelocity_.x < -x_bgMaxVelocity)
    {
        bgVelocity_.x = -x_bgMaxVelocity;
    }
    
    //垂直方向＿背景の最大速度の制限
    if (bgVelocity_.y > y_bgMaxVelocity) 
    {
        bgVelocity_.y = y_bgMaxVelocity;
    }
    else if (bgVelocity_.y < -y_bgMaxVelocity)
    {
        bgVelocity_.y = -y_bgMaxVelocity;
    }
    
    //水平方向＿buil1の最大速度の制限
    if (b1Velocity_.x > x_b1MaxVelocity) 
    {
        b1Velocity_.x = x_b1MaxVelocity;
    }
    else if (b1Velocity_.x < -x_b1MaxVelocity)
    {
        b1Velocity_.x = -x_b1MaxVelocity;
    }
    
    //垂直方向＿buil1の最大速度の制限
    if (b1Velocity_.y > y_b1MaxVelocity) 
    {
        b1Velocity_.y = y_b1MaxVelocity;
    }
    else if (b1Velocity_.y < -y_b1MaxVelocity)
    {
        b1Velocity_.y = -y_b1MaxVelocity;
    }

    //水平方向＿buil2の最大速度の制限
    if (b2Velocity_.x > x_b2MaxVelocity) 
    {
        b2Velocity_.x = x_b2MaxVelocity;
    }
    else if (b2Velocity_.x < -x_b2MaxVelocity)
    {
        b2Velocity_.x = -x_b2MaxVelocity;
    }
    
    //垂直方向＿buil2の最大速度の制限
    if (b2Velocity_.y > y_b2MaxVelocity) 
    {
        b2Velocity_.y = y_b2MaxVelocity;
    }
    else if (b2Velocity_.y < -y_b2MaxVelocity)
    {
        b2Velocity_.y = -y_b2MaxVelocity;
    }
    
    //水平方向＿speederの最大速度の制限
    if (speederVelocity_.x > spMaxVelocity) 
    {
        speederVelocity_.x = spMaxVelocity;
    }
    else if (speederVelocity_.x < spMaxVelocity)
    {
        speederVelocity_.x = -spMaxVelocity;
    }

}

- (void)update:(ccTime)delta
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    float octocatHeight = [octocat_ texture].contentSize.height;
    shadowY_ = (screenSize.height / 2 - octocatHeight /2);
    
    //フレームごとにoctocatVelocityをオクトキャットの影の位置に追加する
    CGPoint octocatPos = octocat_.position;
    CGPoint octocatShadowPos = octocatShadow_.position;
    octocatPos.x += octocatVelocity_.x;
    octocatPos.y += octocatVelocity_.y;
    octocatShadowPos.x = octocatShadowPos.x + ocShadowVelocity_.x;
    octocatShadowPos.y = octocatShadowPos.y + ocShadowVelocity_.y;
    
    //フレームごとにbgVelocityを背景の位置にマイナスで追加する。
    CGPoint bgPos = background_.position;
    bgPos.x = bgPos.x - bgVelocity_.x;
    bgPos.y = bgPos.y - bgVelocity_.y;
    
    //フレームごとにb1Velocityをビル１（大きい方）にマイナスで追加する
    CGPoint b1Pos = buil1_.position;
    b1Pos.x = b1Pos.x - b1Velocity_.x;
    b1Pos.y = b1Pos.y - b1Velocity_.y;
    
    //フレームごとにb2Velocityをビル２（小さい方）にマイナスで追加する
    CGPoint b2Pos = buil2_.position;
    b2Pos.x = b2Pos.x - b2Velocity_.x;
    b2Pos.y = b2Pos.y - b2Velocity_.y;
    
    //フレームごとにspeederVelocityをspeederに追加する
    CGPoint speederPos = speeder_.position;
    CGPoint spShadowPos = speederShadow_.position;
    speederPos.x = speederPos.x + speederVelocity_.x;
    spShadowPos.x = spShadowPos.x + speederVelocity_.x;
    
    //オクトキャットの影の動作境界。
    float octocatWidthHalved = [octocat_ texture].contentSize.width * 0.05f;
    float octocatHeightHalved = [octocat_ texture].contentSize.height * 0.05f;
    float ocLeftBoarderLimit = center_.x - octocatWidthHalved;
    float ocRightBoarderLimit = center_.x + octocatWidthHalved;
    float ocTopBoarderLimit = center_.y + octocatHeightHalved;
    float ocBottomBoarderLimit = center_.y - octocatHeightHalved;
    
    float ocShadowLeftLimit = center_.x - octocatWidthHalved;
    float ocShadowRightLimit = center_.x + octocatWidthHalved;
    //float ocShadowTopLimit = ocTopBoarderLimit - shadowY_;
    //float ocShadowBottomLimit = ocBottomBoarderLimit - shadowY_;

    
    //背景の動作境界。
    float bgLeftLimit =  10.0f;
    float bgRightLimit = screenSize.width - 10.0f;
    float bgTopLimit = screenSize.height/2 + 40.0f;
    float bgBottomLimit = screenSize.height/2 - 40.0f;

    //ビル１の動作境界。
    float b1LeftLimit = - [buil1_ texture].contentSize.width * 0.5f;
    float b1RightLimit = screenSize.width + [buil1_ texture].contentSize.width * 0.5f;
    float b1TopLimit = screenSize.height *3 / 4;
    float b1BottomLimit = screenSize.height / 2;

    //ビル２の動作境界。
    float b2LeftLimit = - [buil1_ texture].contentSize.width * 0.5f;
    float b2RightLimit = screenSize.width + [buil1_ texture].contentSize.width * 0.5f;
    float b2TopLimit = screenSize.height *5 / 6;
    float b2BottomLimit = screenSize.height / 2;
    
    //octocatが境界を超えたら止める。
    if (octocatPos.x < ocLeftBoarderLimit) 
    {
        octocatPos.x = ocLeftBoarderLimit;
        octocatShadowPos.x = ocShadowLeftLimit;
        octocatVelocity_.x = 0.0f;
    }
    else if (octocatPos.x > ocRightBoarderLimit)
    {
        octocatPos.x = ocRightBoarderLimit;
        octocatShadowPos.x = ocShadowRightLimit;
        octocatVelocity_.x = 0.0f;
    }
    
    if (octocatPos.y < ocBottomBoarderLimit) 
    {
        octocatPos.y = ocBottomBoarderLimit;
        octocatShadowPos.y = ocBottomBoarderLimit - octocatHeight /2;
        octocatVelocity_.y = 0.0f;
        ocShadowVelocity_.y = 0.0f;
    }
    else if (octocatPos.y > ocTopBoarderLimit)
    {
        octocatPos.y = ocTopBoarderLimit;
        octocatShadowPos.y = ocTopBoarderLimit - octocatHeight /2;
        octocatVelocity_.y = 0.0f;
        ocShadowVelocity_.y = 0.0f;
    }

    //背景が境界を超えたら止める。
    if (bgPos.x < bgLeftLimit) 
    {
        bgPos.x = bgLeftLimit;
        bgVelocity_.x = 0.0f;
    }
    else if (bgPos.x > bgRightLimit)
    {
        bgPos.x = bgRightLimit;
        bgVelocity_.x = 0.0f;
    }

    if (bgPos.y < bgBottomLimit) 
    {
        bgPos.y = bgBottomLimit;
        bgVelocity_.y = 0.0f;
    }
    else if (bgPos.y > bgTopLimit)
    {
        bgPos.y = bgTopLimit;
        bgVelocity_.y = 0.0f;
    }
    
    //ビル１が境界を超えたら止める。
    if (b1Pos.x < b1LeftLimit) 
    {
        b1Pos.x = b1LeftLimit;
        b1Velocity_.x = 0.0f;
    }
    else if (b1Pos.x > b1RightLimit)
    {
        b1Pos.x = b1RightLimit;
        b1Velocity_.x = 0.0f;
    }
    
    if (b1Pos.y < b1BottomLimit) 
    {
        b1Pos.y = b1BottomLimit;
        b1Velocity_.y = 0.0f;
    }
    else if (b1Pos.y > b1TopLimit)
    {
        b1Pos.y = b1TopLimit;
        b1Velocity_.y = 0.0f;
    }
    
    //ビル２が境界を超えたら止める。
    if (b2Pos.x < b2LeftLimit) 
    {
        b2Pos.x = b2LeftLimit;
        b2Velocity_.x = 0.0f;
    }
    else if (b2Pos.x > b2RightLimit)
    {
        b2Pos.x = b2RightLimit;
        b2Velocity_.x = 0.0f;
    }
    
    if (b2Pos.y < b2BottomLimit) 
    {
        b2Pos.y = b2BottomLimit;
        b2Velocity_.y = 0.0f;
    }
    else if (b2Pos.y > b2TopLimit)
    {
        b2Pos.y = b2TopLimit;
        b2Velocity_.y = 0.0f;
    }

    octocat_.position = octocatPos;
    octocatShadow_.position = octocatShadowPos;
    background_.position = bgPos;
    buil1_.position = b1Pos;
    buil2_.position = b2Pos;
    speeder_.position = speederPos;
    speederShadow_.position = spShadowPos;
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
        
        speeder_ = [CCSprite spriteWithFile:@"parallax_speeder.png"];
        [self addChild:speeder_ z:60 tag:4];
        
        speederShadow_ = [CCSprite spriteWithFile:@"parallax_speedershadow.png"];
        float speederHeight = [speeder_ texture].contentSize.height;
        float speederWidth = [speeder_ texture].contentSize.width;
        [self addChild:speederShadow_ z:50 tag:5];
        
        octocat_ = [CCSprite spriteWithFile:@"parallax_octocat.png"];
        [self addChild:octocat_ z:120 tag:2];
        
        octocatShadow_ = [CCSprite spriteWithFile:@"parallax_octocatshadow.png"];
        float octocatHeight = [octocat_ texture].contentSize.height;
        [self addChild:octocatShadow_ z:50 tag:2];
        
		// ask director the the window size
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
        center_ = CGPointMake(screenSize.width / 2, screenSize.height / 2);
        shadowY_ = (screenSize.height / 2 - octocatHeight /2);
        background_.position = center_;
        octocat_.position = center_;
        speeder_.position = CGPointMake(-speederWidth / 2, screenSize.height / 2);
        speederShadow_.position = CGPointMake(-speederWidth / 2, screenSize.height / 2 - speederHeight /2);
        buil1_.position = CGPointMake(screenSize.width / 2, screenSize.height *2 / 3);
        buil2_.position = CGPointMake(screenSize.width / 2, screenSize.height *2 / 3);
        
        octocatShadow_.position = CGPointMake(screenSize.width / 2, shadowY_);
    
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
