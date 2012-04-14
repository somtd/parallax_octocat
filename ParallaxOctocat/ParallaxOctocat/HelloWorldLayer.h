//
//  HelloWorldLayer.h
//  ParallaxOctocat
//
//  Created by so matsuda on 12/04/14.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    CCSprite *background_;
    CCSprite *octocat_;
    CCSprite *octocatShadow_;
    CCSprite *buil1_;
    CCSprite *buil2_;
 
    CGPoint center_;
    CGPoint bgVelocity_;
    CGPoint octocatVelocity_;
    CGPoint b1Velocity_;
    CGPoint b2Velocity_;
    
    //octocatShadow
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
