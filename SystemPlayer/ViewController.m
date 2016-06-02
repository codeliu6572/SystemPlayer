//
//  ViewController.m
//  SystemPlayer
//
//  Created by 刘浩浩 on 16/6/2.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
@interface ViewController ()
{
    MPMoviePlayerViewController *_playerController;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(100, 100, 100, 40);
    [btn setTitle:@"Play" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)btnAction
{
    [self playMedia];

}
//#pragma mark - 播放视频调用的方法
- (void)playMedia
{
    [self playMediaWithUrlString:@"http://flv.bn.netease.com/videolib3/1605/19/inorj0799/HD/inorj0799-mobile.mp4"];
    
}

- (void)playMediaWithUrlString:(NSString *)urlString
{
    _playerController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:urlString]];
    _playerController.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    _playerController.moviePlayer.currentPlaybackTime=20;
    [self presentViewController:_playerController animated:YES completion:^{
        [_playerController.moviePlayer play];

    }];

    
    // 点击Done 发送一条广播
    // 通过通知中心, 注册self为这条广播的观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DoneButtonClicked) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}
- (void)DoneButtonClicked
{
    // remove观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    if (_playerController) {
        [_playerController.moviePlayer stop];
        _playerController = nil;
        [_playerController.view removeFromSuperview];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
