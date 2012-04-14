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
    CGPoint delta;
    //NSLog(@"x: %g", acceleration.x);
    //NSLog(@"y: %g", acceleration.y);
    //NSLog(@"z: %g", acceleration.z);
    
    if( acceleration.x > 0.5 ) {
        delta.x = 1.0;
    } else if( acceleration.x < -0.5 ) {
        delta.x = -1.0;
    }
    if( acceleration.y > 0.5 ) {
        delta.y = 1.0;
    } else if( acceleration.y < -0.5 ) {
        delta.y = -1.0;
    }
    
    label_.position = ccp( label_.position.x+delta.x, label_.position.y+delta.y );
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
        
        octocatShadow_ = [CCSprite spriteWithFile:@"parallax_octocatshadow.png"];
        float octocatHeight = [octocat_ texture].contentSize.height;
        [self addChild:octocatShadow_ z:100 tag:2];
        
        octocat_ = [CCSprite spriteWithFile:@"parallax_octocat.png"];
        [self addChild:octocat_ z:120 tag:3];
        
        // create and initialize a Label
		/*
        label_ = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];
        [self addChild: label_];
        */
        
		// ask director the the window size
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
        background_.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
        octocat_.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
        octocatShadow_.position = CGPointMake(screenSize.width / 2, screenSize.height / 2 + octocatHeight / 2);

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
