//
//  LoopScrollView.h
//  jinke4iphone
//
//  Created by Karsa wang on 3/15/16.
//  Copyright © 2016 Karsa wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LoopScrollDirection) {
    LoopScrollDirectionHorizontal,
    LoopScrollDirectionVertical,
};

@interface LoopScrollView : UIScrollView
@property (nonatomic) CGFloat itemSpace;
@property (nonatomic) LoopScrollDirection scrollDirection;
- (void)setContentViewList:(NSArray *)views;
@end
