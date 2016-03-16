# LoopScrollView
UIScrollView 的子类，简单的实现无限循环 

支持横向和纵向

只支持等距离排布

相对UIScrollView，最简单情况下，只多出一个方法调用，即设置需要重新布局的View的list


    LoopScrollView *loopScrollView = [[LoopScrollView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    loopScrollView.showsHorizontalScrollIndicator = NO;
    loopScrollView.pagingEnabled = YES;
    loopScrollView.clipsToBounds = NO;
    loopScrollView.itemSpace = 10;
    loopScrollView.scrollDirection = LoopScrollDirectionVertical;
    
    NSMutableArray *array = [NSMutableArray array];
    NSUInteger count = 10;
    for (int i = 0; i < count; i ++ ) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        [self.loopScrollView addSubview:label];
        label.backgroundColor = [UIColor greenColor];
        label.text = [NSString stringWithFormat:@"%d", i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:30];
        [array addObject:label];
    }
    [self.loopScrollView setContentViewList:array];
    self.loopScrollView.contentSize = CGSizeMake(200, (200+self.loopScrollView.itemSpace)*count + self.loopScrollView.itemSpace);

