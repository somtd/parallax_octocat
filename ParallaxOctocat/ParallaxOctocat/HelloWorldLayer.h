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
    
    CCLabelTTF *label_;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
