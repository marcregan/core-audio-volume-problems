//
//  ViewController.h
//  AudioVolumeProblems
//
//  Created by MARC W REGAN on 5/15/13.
//  Copyright (c) 2013 MARC W REGAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <AVAudioPlayerDelegate>
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end
