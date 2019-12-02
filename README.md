#文字上下滚动
>项目中可能会用到单条数据需要上下滚动显示，下面是一个非常简单的封装Demo，可以根据自己的项目进行自定义修改。

效果如下：


![效果图.gif](https://upload-images.jianshu.io/upload_images/16734246-34341a968c5a4cf1.gif?imageMogr2/auto-orient/strip)

[Demo](https://github.com/qiuyubude/RollTextView)下载

###项目代码
```
/** 数据 */
@property (nonatomic, copy) NSArray *dataArr;
/** 当前Label */
@property (nonatomic, strong) UILabel *currentLab;
/** 下一个label */
@property (nonatomic, strong) UILabel *nextLab;
/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;
/** 当前下标 */
@property (nonatomic, assign) NSInteger currentIndex;
```

主要实现思路：通过两个Lab进行动画操作实现上下滚动再进行数据赋值操作
```
- (void)refreshData {

    if (self.currentIndex == self.dataArr.count - 1) {
       self.currentIndex = -1;
    }
    self.nextLab.text = self.dataArr[self.currentIndex + 1];
    self.currentIndex ++;
}

- (void)rollLab {
    
    [self refreshData];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.currentLab.frame = CGRectMake(0,  - 24, weakSelf.frame.size.width, 24);
        weakSelf.nextLab.frame = CGRectMake(0, 0, weakSelf.frame.size.width, 24);
    } completion:^(BOOL finished) {
        weakSelf.currentLab.text = weakSelf.nextLab.text;
        weakSelf.currentLab.frame = CGRectMake(0, 0, weakSelf.frame.size.width, 24);
        weakSelf.nextLab.frame = CGRectMake(0, 24, weakSelf.frame.size.width, 24);
    }];
}

```
*可根据实际情况进行自定义界面操作，实现原理不变*

GitHub地址 ：https://github.com/qiuyubude/RollTextView
简书地址：https://www.jianshu.com/p/8744fd855eed
掘金地址：https://juejin.im/post/5de4d1d35188250f9c2472b4
