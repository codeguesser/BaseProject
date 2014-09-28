//
//  VideoView.h
//  brochure

//  视频View，一个VIew里包着一个播放视频的view

//  Created by wang shuguan on 13-12-15.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//
@protocol VideoViewDelegate <NSObject>

- (void) moviePlayBackDidFinish:(NSNotification*)notification;

@end
#import "CGView.h"

#import <MediaPlayer/MediaPlayer.h>
@interface VideoView : CGView{
    MPMoviePlayerController *player;
    IBOutlet id<VideoViewDelegate>delegate;
}

@end
