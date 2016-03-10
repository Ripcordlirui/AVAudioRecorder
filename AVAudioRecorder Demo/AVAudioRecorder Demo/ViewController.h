//
//  ViewController.h
//  AVAudioRecorder Demo
//
//  Created by TopSage on 16/3/9.
//  Copyright © 2016年 TopSage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController : UIViewController<AVAudioRecorderDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *sampleRateSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *bitDeptSeg;
@property (weak, nonatomic) IBOutlet UISwitch *stereoSwitch;
@property (weak, nonatomic) IBOutlet UIButton *recordBtn;
@property (weak, nonatomic) IBOutlet UIButton *recordplay;

//该属性代表了应用的Documents目录
@property (nonatomic,copy) NSString * documentsPath;



@end

