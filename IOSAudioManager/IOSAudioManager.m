//
//  IOSAudioManager.m
//  IOSAudioManager
//
//  Created by Steven Woo on 11/11/13.
//  Copyright (c) 2013 Steven Woo. All rights reserved.
//

#import "IOSAudioManager.h"

NSString * const kSettingsSoundEffects = @"audio_settings";

@interface IOSAudioManager()
@property NSMutableArray *arrayAudio;
@property NSMutableArray *arraySFXMapping;
@end

@implementation IOSAudioManager
- (void)initSFXMapping
{
    _arraySFXMapping= [NSMutableArray arrayWithObjects:
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
                 nil] ;
}
-(id) init {
    self = [super init];
    if( self != nil ){
        _arrayAudio = [[NSMutableArray alloc]init];
    }
    return self;
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
        if( sfxID < 0 || sfxID > [_arraySFXMapping count]-1 ){
            return;
        }
        
        NSURL *fileURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], [ _arraySFXMapping objectAtIndex:sfxID]]];
        NSError *Error = nil;
        AVAudioPlayer *playerTemp = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                                                           error: &Error];
        [playerTemp setDelegate: self];
        
        [playerTemp play];
        [_arrayAudio addObject:playerTemp];
        playerTemp = nil;
    }
    
}
- (void)removeObject:(AVAudioPlayer*)player {
    for( AVAudioPlayer *avPlayer in _arrayAudio ){
        if( player == avPlayer ){
            [_arrayAudio removeObject:avPlayer];
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
