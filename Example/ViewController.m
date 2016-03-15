//
//  ViewController.m
//  Example
//
//  Created by Karsa wang on 3/15/16.
//  Copyright © 2016 Karsa wang. All rights reserved.
//

#import "ViewController.h"
#import "LoopScrollView.h"
#import "UIViewAdditions.h"

@interface ViewController ()
@property IBOutlet LoopScrollView *loopScrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loopScrollView.backgroundColor = [UIColor grayColor];
    self.loopScrollView.showsHorizontalScrollIndicator = NO;
    self.loopScrollView.pagingEnabled = YES;
    self.loopScrollView.clipsToBounds = NO;
    self.loopScrollView.itemSpace = 10;
    self.loopScrollView.scrollDirection = LoopScrollDirectionVertical;
    [self.view addSubview:self.loopScrollView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
}

@end
