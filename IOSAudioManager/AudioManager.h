//
//  AudioManager.h
//  testbed2
//
//  Created by Steven Woo on 5/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#define SFX_BEEP1           (0)
#define SFX_BEEP2           (1)
#define SFX_BEEP3           (2)
#define SFX_CHIRP           (3)
#define SFX_CLAPPING        (4)
#define SFX_CRICKET         (5)
#define SFX_BEEP4           (6)
#define SFX_ELEVATORDING    (7)
#define SFX_FLUTTER         (8)
#define SFX_KACHING         (9)
#define SFX_PAGETURN        (10)
#define SFX_SWISH           (11)
#define SFX_CLICK           (12)
#define SFX_BOTTLEPOP       (13)

@interface AudioManager : NSObject <AVAudioPlayerDelegate> {
    NSMutableArray *arrayAudio;
}
-(void)playSFX:(int)sfxID;
@end
