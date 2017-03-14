//
//  ViewController.m
//  ZYPickerView
//
//  Created by 赵岩 on 2017/3/14.
//  Copyright © 2017年 赵岩. All rights reserved.
//

#import "ViewController.h"

#import "ZYPickerView.h"
@interface ViewController ()<ZYPickerViewDelegate>
@end

@implementation ViewController{
    /**
     *  温度pickerView
     */
    ZYPickerView *temperature;
    /**
     *  档位pickerView
     */
    ZYPickerView *airConditionerlevel;
    /**
     显示结果按钮
     */
    UIButton *resultButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景图片
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:self.view.frame];
    [backImage setImage:[UIImage imageNamed:@"背景图片"]];
    backImage.userInteractionEnabled = true;
    self.view = backImage;
    /**
     *  初始化 UI
     */
    [self showZYPickerView];
}

/**
 *  初始化 UI
 */
-(void)showZYPickerView{
    /**
     *  温度pickerView
     */
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSInteger idx = 0; idx != 20; idx++) {
        [dataArray addObject:[NSString stringWithFormat:@"%ld℃",idx-10]];
    }
    temperature = [[ZYPickerView alloc]initWithFrame:CGRectMake(0, 180, 375, 40)];
    temperature.delegate = self;
    temperature.dataModel = dataArray;
    temperature.leftImage = [UIImage imageNamed:@"温度减"];
    temperature.rightImage = [UIImage imageNamed:@"温度加"];
    [temperature scrollToIndex:[dataArray count]/2];
    [self.view addSubview:temperature];
    
    /**
     *  档位pickerView
     */
    NSMutableArray *levelArray = [NSMutableArray array];
    for (NSInteger idx = 1; idx != 10; idx++) {
        [levelArray addObject:[NSString stringWithFormat:@"%ld档",idx]];
    }
    airConditionerlevel = [[ZYPickerView alloc]initWithFrame:CGRectMake(0, 280, 375, 40)];
    airConditionerlevel.delegate = self;
    airConditionerlevel.dataModel = levelArray;
    airConditionerlevel.leftImage = [UIImage imageNamed:@"风速减"];
    airConditionerlevel.rightImage = [UIImage imageNamed:@"风速加"];
    [airConditionerlevel scrollToIndex:levelArray.count/2];
    [self.view addSubview:airConditionerlevel];
    
    /**
     显示结果按钮
     */
    resultButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 380, 175, 40)];
    resultButton.layer.borderColor = [UIColor whiteColor].CGColor;
    resultButton.layer.borderWidth = 1;
    [resultButton addTarget:self action:@selector(resultButtonTap) forControlEvents:UIControlEventTouchUpInside];
    [resultButton setTitle:@"结果" forState:UIControlStateNormal];
    [resultButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:resultButton];
}


#pragma mark -- UIControlEventAction
/**
 *  查询结果按钮点击事件
 */
-(void)resultButtonTap{
    UIAlertController *alert = [[UIAlertController alloc]init];
    UIAlertAction *temp = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"当前选择温度：%@",[temperature.selectedItem valueForKey:@"name"]] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *airCond = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"当前选择档位：%@",[airConditionerlevel.selectedItem valueForKey:@"name"]] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:temp];
    [alert addAction:airCond];
    [alert addAction:cancle];
    
    [self presentViewController:alert animated:true completion:nil];
    
}

#pragma mark -- ZYPickerViewDelegate

-(void)rightButtonTapAction:(ZYPickerView *)ZYPicker{
    NSDictionary *result = ZYPicker.selectedItem;
    NSInteger currentIndex = [result[@"index"] integerValue];
    if (currentIndex < [ZYPicker.dataModel count]) {
        [ZYPicker scrollToIndex:currentIndex+1];
    }else{
        NSLog(@"不能再往右了！");
    }
}

-(void)leftButtonTapAction:(ZYPickerView *)ZYPicker{
    NSDictionary *result = ZYPicker.selectedItem;
    NSInteger currentIndex = [result[@"index"] integerValue];
    if (currentIndex > 0) {
        [ZYPicker scrollToIndex:currentIndex-1];
    }else{
        NSLog(@"不能再往左了！");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
