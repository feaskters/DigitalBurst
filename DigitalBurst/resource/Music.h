//
//  Music.h
//  TenLock
//
//  Created by iOS123 on 2019/2/21.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Music : NSObject

+(instancetype)sharedMusic;

//播放音效
-(void)musicPlayEffective;

//静音和取消静音
-(void)musicChangeMute;

//获取当前音量
-(float)getMuteVolume;

//播放融合音效
-(void)musicPlayMergeEffective;

@end

NS_ASSUME_NONNULL_END
