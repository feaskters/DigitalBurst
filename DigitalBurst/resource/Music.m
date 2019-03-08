//
//  Music.m
//  TenLock
//
//  Created by iOS123 on 2019/2/21.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "Music.h"
#import <AVFoundation/AVFoundation.h>

@interface Music()

@property AVAudioPlayer *BGM;
@property AVAudioPlayer *musiceffective;
@property AVAudioPlayer *mergeEffectice;
@end

@implementation Music

static Music *_instance;

+(void)load{
    
    //初始化
    _instance = [[Music alloc]init];
    
    //初始化音效播放器
    NSString *effective_path = [[NSBundle mainBundle]pathForResource:@"button_click" ofType:@"mp3"];
    NSURL *effective_url = [NSURL URLWithString:effective_path];
    _instance.musiceffective = [[AVAudioPlayer alloc]initWithContentsOfURL:effective_url error:nil];
    _instance.musiceffective.volume = 0.5;
    
    //初始化融合音效播放器
    NSString *merge_path = [[NSBundle mainBundle]pathForResource:@"merge" ofType:@"mp3"];
    NSURL *merge_url = [NSURL URLWithString:merge_path];
    _instance.mergeEffectice = [[AVAudioPlayer alloc]initWithContentsOfURL:merge_url error:nil];
    _instance.mergeEffectice.volume = 0.5;
    _instance.mergeEffectice.rate = 2;
    
    //初始化BGM播放器
    NSString *BGM_path = [[NSBundle mainBundle]pathForResource:@"BGM" ofType:@"mp3"];
    NSURL *BGM_url = [NSURL URLWithString:BGM_path];
    _instance.BGM = [[AVAudioPlayer alloc]initWithContentsOfURL:BGM_url error:nil];
    _instance.BGM.volume = 0.5;
    _instance.BGM.numberOfLoops = -1;
    [_instance.BGM play];
}

//共享_instance
+(instancetype)sharedMusic{
    return _instance;
}

//不允许alloc
+(instancetype)alloc{
    if (_instance) {
        NSException *exc = [NSException exceptionWithName:@"NSInternalInconsistencyException" reason:@"There can only be one music instance." userInfo:nil];
        //抛出异常
        [exc raise];
    }
    return [super alloc];
}

//播放音效
-(void)musicPlayEffective{
    [_instance.musiceffective play];
}

//播放融合音效
-(void)musicPlayMergeEffective{
    [_instance.mergeEffectice play];
}

//静音和取消静音
-(void)musicChangeMute{
    if (_instance.BGM.volume > 0.0 ) {
        _instance.BGM.volume = 0;
        _instance.musiceffective.volume = 0;
    }else{
        _instance.BGM.volume = 0.5;
        _instance.musiceffective.volume = 0.5;
    }
}

//获取当前音量
-(float)getMuteVolume{
    return _instance.BGM.volume;
}

@end
