//
//  AudioManager.m
//
//  Created by Steven Woo on 5/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AudioManager.h"


@implementation AudioManager
+ (NSArray *)arraySFXFiles
{
    static NSArray *data = nil;
    if (!data) {
        data = [[NSArray arrayWithObjects:
                                                @"beep2.aifc",
                                                @"beepstart.aifc",
                                                @"beepstop.aifc",
                                                @"chickchirp.aifc",
                                                @"clapping.aifc",
                                                @"cricket.aifc",
                                                @"ding01.aifc",
                                                @"elevatording.aifc",
                                                @"flutter.aifc",
                                                @"kaching.aifc",
                                                @"pageturn.aifc",
                                                @"swish.aifc",
                                                @"switchclick.aifc", 
                                                @"bottlepop.aifc",
                                                nil] retain];
    }
    return data;
}
-(id) init {
    self = [super init];
    if( self != nil ){
        arrayAudio = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void) dealloc {
    [arrayAudio release];
    [super dealloc];
}
-(void)initPlayer:(AVAudioPlayer ** )pPlayer withFile:(NSString*)strFile {
	NSURL *fileURL = [NSURL fileURLWithPath:strFile];
	NSError *Error = nil;
    *pPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                                      error: &Error];
    [*pPlayer setDelegate: self];	    
}
-(void) playSFX:(int)sfxID {
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:kSettingsSoundEffects]) {
        if( sfxID < 0 || sfxID > [[AudioManager arraySFXFiles] count]-1 ){
            return;
        }
        
        NSURL *fileURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], [[AudioManager arraySFXFiles]objectAtIndex:sfxID]]];
        NSError *Error = nil;
        AVAudioPlayer *playerTemp = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                                                           error: &Error];
        [playerTemp setDelegate: self];	    
        
        [playerTemp play];
        [arrayAudio addObject:playerTemp];
        [playerTemp release];
    }

}
- (void)removeObject:(AVAudioPlayer*)player {
    for( AVAudioPlayer *avPlayer in arrayAudio ){
        if( player == avPlayer ){
            [arrayAudio removeObject:avPlayer];
            return;
        }
    }
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [self removeObject:player];
}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    [self removeObject:player];
}
@end
