//
//  ZYPickerView.h
//  ZYPickerView
//
//  Created by 赵岩 on 2017/3/14.
//  Copyright © 2017年 赵岩. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZYPickerViewDelegate <NSObject>
@optional
//左侧按钮点击事件
-(void)leftButtonTapAction:(UIView *)ZYPicker;
//右侧按钮点击事件
-(void)rightButtonTapAction:(UIView *)ZYPicker;
@end

@interface ZYPickerView : UIView

//PickerView 数据源
@property (nonatomic,strong) NSArray *dataModel;
//当前选择器选择的元素 （NSDictionary 类型， name：选择元素名称  index：选择元素位置）
@property (nonatomic,strong,readonly) NSDictionary *selectedItem;
//滑动到指定位置
@property (nonatomic,assign,setter=scrollToIndex:) NSInteger scrollToIndex;
//设置左侧点击按钮图片
@property (nonatomic,strong) UIImage *leftImage;
//设置右侧点击按钮图片
@property (nonatomic,strong) UIImage *rightImage;
//代理
@property (nonatomic,assign) id <ZYPickerViewDelegate> delegate;

@end
