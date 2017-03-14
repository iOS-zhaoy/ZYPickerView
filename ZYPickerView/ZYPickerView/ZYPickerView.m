//
//  ZYPickerView.m
//  ZYPickerView
//
//  Created by 赵岩 on 2017/3/14.
//  Copyright © 2017年 赵岩. All rights reserved.
//

#import "ZYPickerView.h"

@interface ZYPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@end

@implementation ZYPickerView{
    UIButton *upButton;
    UIButton *downButton;
    UIPickerView *picker;
    NSArray *dataArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self performSelector:@selector(initPickerView)];
    }
    return self;
}
/**
 *  初始化 选择器
 */
-(void)initPickerView{
    CGAffineTransform rotate = CGAffineTransformMakeRotation(-M_PI/2);
    rotate = CGAffineTransformScale(rotate, 0.1, 1);
    //旋转 -π/2角度
    picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.height*10, self.frame.size.width)];
    [picker setTag: 10086];
    picker.delegate = self;
    picker.dataSource = self;
    picker.showsSelectionIndicator = false;
    [picker setBackgroundColor:[UIColor clearColor]];
    [self addSubview:picker];
    [picker setTransform:rotate];
    [[picker layer] setCornerRadius:5.0];
    picker.clipsToBounds = true;
    picker.frame = CGRectMake(0, 0, picker.frame.size.width, picker.frame.size.height);
    
#define itemHeight 50
    //选择线
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(picker.frame.size.width/2-itemHeight/2, 0, 1, picker.frame.size.height)];
    [line1 setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:.8f]];
    [self addSubview:line1];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(picker.frame.size.width/2+itemHeight/2, 0, 1, picker.frame.size.height)];
    [line2 setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:.8f]];
    [self addSubview:line2];
    
    //左右 加减 按钮
    downButton = [[UIButton alloc]initWithFrame:CGRectMake(20, ((self.frame.size.height-30)/2>0?(self.frame.size.height-30)/2:0), 26, 30)];
    [downButton addTarget:self action:@selector(leftButtonTapAction) forControlEvents:UIControlEventTouchUpInside];
    [self insertSubview:downButton aboveSubview:picker];
    upButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-20-26, downButton.frame.origin.y, 26, 30)];
    [upButton addTarget:self action:@selector(rightButtonTapAction) forControlEvents:UIControlEventTouchUpInside];
    [self insertSubview:upButton aboveSubview:picker];
    
}
/**
 *  pickerView代理方法
 *
 *  @param pickerView
 *  @param component
 *
 *  @return pickerView有多少个元素
 */
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [dataArray count];
}
/**
 *  pickerView代理方法
 *
 *  @param pickerView pickerView
 *
 *  @return pickerView 有多少列
 */
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
/**
 *  pickerView代理方法
 *
 *  @param pickerView
 *  @param row
 *  @param component
 *  @param view
 *
 *  @return 每个 item 显示的 视图
 */
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    CGAffineTransform rotateItem = CGAffineTransformMakeRotation(M_PI/2);
    rotateItem = CGAffineTransformScale(rotateItem, 1, 10);
    UILabel *labelItem = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 240)];
    labelItem.text =   dataArray[row];
    labelItem.backgroundColor = [UIColor clearColor];
    labelItem.shadowColor = [UIColor clearColor];
    labelItem.shadowOffset = CGSizeMake(-1, -1);
    [labelItem setFont:[UIFont boldSystemFontOfSize:17]];
    labelItem.textAlignment = NSTextAlignmentCenter;
    labelItem.textColor = [UIColor whiteColor];
    labelItem.transform = rotateItem;
    return labelItem;
}

/**
 *  pickerVie代理方法
 *
 *  @param pickerView
 *  @param component
 *
 *  @return 每个item的宽度
 */
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component __TVOS_PROHIBITED{
    return self.frame.size.height;
}
/**
 *  pickerView代理方法
 *
 *  @param pickerView
 *  @param component
 *
 *  @return 每个item的高度
 */
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return itemHeight;
}

/**
 *  数据源 Setter 方法
 *
 *  @param dataModel 数据数组
 */
-(void)setDataModel:(NSArray *)dataModel{
    dataArray = dataModel;
    [picker reloadAllComponents];
}

/**
 *  数据源 Getter 方法
 *
 *  @return 数据数组
 */
-(NSArray *)dataModel{
    return dataArray;
}

/**
 *  pickerView滑动到指定位置
 *
 *  @param scrollToIndex 指定位置
 */
-(void)scrollToIndex:(NSInteger)scrollToIndex{
    [picker selectRow:scrollToIndex inComponent:0 animated:true];
}

/**
 *  查询当前选择元素Getter方法
 *
 *  @return pickerView当前选择元素 （index：选择位置  name：元素名称）
 */
-(NSDictionary *)selectedItem{
    NSInteger index = [picker selectedRowInComponent:0];
    NSString *contaxt = dataArray[index];
    return @{@"name":contaxt,@"index":[NSString stringWithFormat:@"%ld",index]};
}
/**
 *  设置左侧按钮照片
 *
 *  @param leftImage 左侧按钮照片
 */

-(void)setLeftImage:(UIImage *)leftImage{
    [downButton setBackgroundImage:leftImage forState:UIControlStateNormal];
}
/**
 *  设置右侧按钮照片
 *
 *  @param rightImage 右侧按钮照片
 */
-(void)setRightImage:(UIImage *)rightImage{
    [upButton setBackgroundImage:rightImage forState:UIControlStateNormal];
}
/**
 *  右侧按钮点击事件
 */
-(void)rightButtonTapAction{
    if ([_delegate respondsToSelector:@selector(rightButtonTapAction:)]) {
        [_delegate performSelector:@selector(rightButtonTapAction:) withObject:self];
    }
}
/**
 *  左侧按钮点击事件
 */
-(void)leftButtonTapAction{
    if ([_delegate respondsToSelector:@selector(leftButtonTapAction:)]) {
        [_delegate performSelector:@selector(leftButtonTapAction:)withObject:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
