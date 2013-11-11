//
//  IOSAudioManager.h
//  IOSAudioManager
//
//  Created by Steven Woo on 11/11/13.
//  Copyright (c) 2013 Steven Woo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#define SFX_BEEP           (0)
extern NSString * const kSettingsSoundEffects;
@interface IOSAudioManager : NSObject <AVAudioPlayerDelegate>
-(void)playSFX:(int)sfxID;
@end
