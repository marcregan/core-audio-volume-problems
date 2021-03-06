//
//  ViewController.m
//  AudioVolumeProblems
//
//  Created by MARC W REGAN on 5/15/13.
//  Copyright (c) 2013 MARC W REGAN. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "ViewController.h"

@interface ViewController () {
    AVAudioPlayer* _player;
    NSTimer* _playTimer;
    BOOL _playYeeeaaah;
}

@end

#pragma mark -
@implementation ViewController


// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self _playAudio:nil];
    
    _playTimer = [NSTimer scheduledTimerWithTimeInterval:10.0
                                                  target:self
                                                selector:@selector(_playAudio:)
                                                userInfo:nil
                                                 repeats:YES];
}


// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
- (void)_setActive {
    UInt32 mix  = 1;
    UInt32 duck = 1;
    NSError* errRet;
    
    AVAudioSession* session = [AVAudioSession sharedInstance];
    [session setActive:NO error:&errRet];
    
    [session setCategory:AVAudioSessionCategoryPlayback error:&errRet];
    NSAssert(errRet == nil, @"setCategory!");
    
    AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryMixWithOthers, sizeof(mix), &mix);
    AudioSessionSetProperty(kAudioSessionProperty_OtherMixableAudioShouldDuck, sizeof(duck), &duck);
    
    [session setActive:YES error:&errRet];
}


// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
- (void)_setIdle {
    NSError* errRet;
    
    AVAudioSession* session = [AVAudioSession sharedInstance];
    [session setActive:NO error:&errRet];
    
    [session setCategory:AVAudioSessionCategoryAmbient error:&errRet];
    NSAssert(errRet == nil, @"setCategory!");
    
    [session setActive:YES error:&errRet];
}


// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
- (void)_playAudio:(NSTimer*)timer
{
    [self _setActive];
    
    NSString* audioClip;
    if (_playYeeeaaah) {
        audioClip = @"umyeah1";
    } else {
        audioClip = @"goahead1";
    }
    _playYeeeaaah = !_playYeeeaaah;
    
    NSString *filename = [[NSBundle mainBundle] pathForResource:audioClip
                                                         ofType:@"wav"];
    NSData* audioData = [NSData dataWithContentsOfFile:filename];

    NSError* errRet;
    _player = [[AVAudioPlayer alloc] initWithData:audioData error:&errRet];
    NSAssert(errRet == nil, @"initWithData!");
    
    _player.delegate = self;
    
    [_player play];
    
    [_textView setText:@"When audio is playing, the volume buttons control the app's volume. Sweet.\n\nDucking and mixing work great."];
}


#pragma mark - AVAudioPlayerDelegate
// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer*)player
                       successfully:(BOOL)flag
{
    [self _setIdle];
    
    [_textView setText:@"When the audio isn't playing, the volume buttons control the ringer.\n\nNo good!"];
}

@end
