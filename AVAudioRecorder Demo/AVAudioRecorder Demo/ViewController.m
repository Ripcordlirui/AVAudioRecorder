//
//  ViewController.m
//  AVAudioRecorder Demo
//
//  Created by TopSage on 16/3/9.
//  Copyright © 2016年 TopSage. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    AVAudioRecorder *_avaudioRecorder;
    AVAudioPlayer *_avaudioPlayer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.recordBtn setTitle:@"录制" forState:(UIControlStateNormal)];
    [self.recordBtn addTarget:self action:@selector(clicked) forControlEvents:(UIControlEventTouchUpInside)];
    [self.recordplay addTarget:self action:@selector(play) forControlEvents:(UIControlEventTouchUpInside)];
    //获取当前应用的音频会话
    AVAudioSession  * audioSession = [AVAudioSession sharedInstance];
    //设置音频类型 PlayAndrecord说明即可播放也可录制
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    //激活当前应用的音频会话
    [audioSession setActive:YES error:nil];

}

//获取Documentpath路径
-(NSString *)documentsPath
{
    if (!_documentsPath) {
        NSArray * searchpaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _documentsPath=[searchpaths objectAtIndex:0];
    }
    return _documentsPath;
}
-(void)clicked

{
    
    if (_avaudioRecorder !=nil&&_avaudioRecorder.isRecording) {
        
        [_avaudioRecorder stop];
        
    }else{
        //获取音频文件保存路径
        NSString * destinationString = [[self documentsPath] stringByAppendingPathComponent:@"sound.wav"];
        NSURL *destinationURL = [NSURL fileURLWithPath:destinationString];
        
        //创建一个字典， 用于保存录制属性
        NSMutableDictionary * recordSetting = [NSMutableDictionary dictionary];
        //设置录制音频的格式
        [recordSetting setObject:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
        NSString * sampleRate = [self.sampleRateSeg titleForSegmentAtIndex:self.sampleRateSeg.selectedSegmentIndex];
        //设置录制音频的采样率
        [recordSetting setObject:[NSNumber numberWithFloat:sampleRate.floatValue] forKey:AVSampleRateKey];
        
        //设置音频的通道数
        [recordSetting setObject:[NSNumber numberWithInt:(self.stereoSwitch.on ? 2:1)] forKey:AVNumberOfChannelsKey];
        NSString * bitDepth = [self.bitDeptSeg titleForSegmentAtIndex:self.bitDeptSeg.selectedSegmentIndex];
        //设置录制音频的每个样点的位数
        [recordSetting setObject:[NSNumber numberWithInt:bitDepth.intValue] forKey:AVLinearPCMBitDepthKey];
        //设置录制音频采用高位优先的记录格式
        [recordSetting setObject:[NSNumber numberWithBool:YES] forKey:AVLinearPCMIsBigEndianKey];
        
        //设置采样信号的浮点数
        [recordSetting setObject:[NSNumber numberWithBool:YES] forKey:AVLinearPCMIsFloatKey];
        
        NSError * recorderSetupError = nil;
        
        //初始化AVAUdioRecorder
        
        _avaudioRecorder = [[AVAudioRecorder alloc] initWithURL:destinationURL settings:recordSetting error:&recorderSetupError];
        _avaudioRecorder.delegate=self;
        [_avaudioRecorder record];
       }
}
-(void)play
{
    //获取音频文件保存路径
    NSString * destinationString = [[self documentsPath] stringByAppendingPathComponent:@"sound.wav"];
    NSURL *url = [NSURL fileURLWithPath:destinationString];
   //创建AVAudioPlayer对象
    _avaudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //开始播放
    [_avaudioPlayer play];
}
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    if (flag) {
        NSLog(@"录制完成");
    }
    
}
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError * __nullable)error{
    NSLog(@"被中断");
}
@end
