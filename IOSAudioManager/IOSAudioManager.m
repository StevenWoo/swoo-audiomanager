//
//  IOSAudioManager.m
//  IOSAudioManager
//
//  Created by Steven Woo on 11/11/13.
//
//  The MIT License (MIT)
//
//  Copyright (c)  2013
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
