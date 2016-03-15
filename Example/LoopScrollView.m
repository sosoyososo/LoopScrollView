//
//  LoopScrollView.m
//  jinke4iphone
//
//  Created by Karsa wang on 3/15/16.
//  Copyright © 2016 Karsa wang. All rights reserved.
//

#import "LoopScrollView.h"
#import "UIViewAdditions.h"
#import <objc/runtime.h>


@interface LoopScrollView()
@property (nonatomic, strong) NSMutableArray *contentViews;
@end

@implementation LoopScrollView

- (void)setContentViewList:(NSArray *)views {
    if ([views isKindOfClass:[NSArray class]]) {
        self.contentViews = [NSMutableArray arrayWithArray:views];
    }
}

- (CGFloat)minContentSize {
    if (LoopScrollDirectionHorizontal ==  self.scrollDirection) {
        CGFloat width = self.itemSpace;
        for (UIView *view in self.contentViews) {
            width += view.width+self.itemSpace;
        }
        return width;
    } else {
        CGFloat height = self.itemSpace;
        for (UIView *view in self.contentViews) {
            height += view.height+self.itemSpace;
        }
        return height;
    }
}

- (BOOL)shouldCircleLayout {
    if (LoopScrollDirectionHorizontal ==  self.scrollDirection) {
        return [self minContentSize] > self.width;
    } else {
        return [self minContentSize] > self.height;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (![self shouldCircleLayout]) {
        return;
    }
    
    CGFloat threshold = 50;
    if (LoopScrollDirectionHorizontal ==  self.scrollDirection) {
        if (self.contentSize.width < [self minContentSize]) {
            self.contentSize = CGSizeMake([self minContentSize], self.contentSize.height);
        }
        if (self.contentOffset.x > (self.contentSize.width - self.width - threshold)) {
            //first move to last
            UIView  *view = [self.contentViews firstObject];
            [self.contentViews removeObject:view];
            CGFloat left = self.itemSpace;
            for (UIView *subView in self.contentViews) {
                subView.left = left;
                left += (subView.width+self.itemSpace);
            }
            view.left = [(UIView *)[self.contentViews lastObject] right] + self.itemSpace;
            [self.contentViews addObject:view];
            self.contentOffset = CGPointMake(self.contentOffset.x-(view.width+self.itemSpace) , self.contentOffset.y);
        } else if (self.contentOffset.x < threshold) {
            //last move to first
            UIView *view = [self.contentViews lastObject];
            [self.contentViews removeObject:view];
            view.left = self.itemSpace;
            CGFloat left = view.right + self.itemSpace;
            for (UIView *subview in self.contentViews) {
                subview.left = left;
                left += (subview.width+self.itemSpace);
            }
            [self.contentViews insertObject:view atIndex:0];
            self.contentOffset = CGPointMake(self.contentOffset.x+(view.width+self.itemSpace) , self.contentOffset.y);
        }
    } else {
        if (self.contentSize.height < [self minContentSize]) {
            self.contentSize = CGSizeMake(self.contentSize.width, [self minContentSize]);
        }
        if (self.contentOffset.y > (self.contentSize.height - self.height - threshold)) {
            //first move to last
            UIView  *view = [self.contentViews firstObject];
            [self.contentViews removeObject:view];
            CGFloat top = self.itemSpace;
            for (UIView *subView in self.contentViews) {
                subView.top = top;
                top += (subView.height+self.itemSpace);
            }
            view.top = [(UIView *)[self.contentViews lastObject] bottom] + self.itemSpace;
            [self.contentViews addObject:view];
            self.contentOffset = CGPointMake(self.contentOffset.x, self.contentOffset.y-(view.height+self.itemSpace));
        } else if (self.contentOffset.y < threshold) {
            //last move to first
            UIView *view = [self.contentViews lastObject];
            [self.contentViews removeObject:view];
            view.top = self.itemSpace;
            CGFloat top = view.bottom + self.itemSpace;
            for (UIView *subview in self.contentViews) {
                subview.top = top;
                top += (subview.height+self.itemSpace);
            }
            [self.contentViews insertObject:view atIndex:0];
            self.contentOffset = CGPointMake(self.contentOffset.x, self.contentOffset.y+(view.width+self.itemSpace));
        }
    }
}

@end
