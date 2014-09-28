//
//  VideoView.m
//  brochure
//
//  Created by wang shuguan on 13-12-15.
//  Copyright (c) 2013年 wang shuguan. All rights reserved.
//

#import "VideoView.h"
@implementation VideoView

-(void)Init{
    [super Init];
    NSURL *myURL = [[NSBundle mainBundle]URLForResource:@"m" withExtension:@"mov"];
    player = [[MPMoviePlayerController alloc] initWithContentURL:myURL];
    player.view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

    [self addSubview:player.view];
    [player prepareToPlay];
}
-(void)awakeFromNib{
    [[NSNotificationCenter defaultCenter] addObserver:delegate
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:player];
    [super awakeFromNib];
    [player play];
}

@end
