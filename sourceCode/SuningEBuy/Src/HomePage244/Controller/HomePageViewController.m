//
//  HomePageViewController.m
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomeFloorDTO.h"
#import "SNWebViewController.h"
#import "PruductList244ViewController.h"
#import "SalePromotionViewController.h"
#import "AutoLoginCommand.h"
#import "ServiceTrackListViewController.h"
#import "NewGetRedPackViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "GuessYouLikeCell.h"
#import "ZhuanTiDTO.h"


@interface HomePageViewController () {
    NSString            *getredpackstr;
    //是否请求推荐数据
    BOOL                willRequestRecommendData;
}

@property (nonatomic,strong) ZhuanTiDTO         *cuXiaoDto;
@property (nonatomic,strong) UIImageView        *recommendImageView;
@property (nonatomic,strong) UIImageView        *recommendIconUpImageView;
@property (nonatomic,strong) UIImageView        *recommendIconDownImageView;

@end

@implementation HomePageViewController



-(void)loginOK{
    NewGetRedPackViewController *getredpack = [[NewGetRedPackViewController alloc] init];
    getredpack.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:getredpack animated:YES];
}

#pragma mark - scroll delagate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //gjf 
    [super scrollViewDidScroll:scrollView];
    
    float contentHeight = scrollView.contentSize.height;
    float tableViewHeight = scrollView.bounds.size.height;
    float originY = MAX(contentHeight, tableViewHeight);
    CGFloat showHeight = scrollView.contentOffset.y + scrollView.size.height - originY - _initScrollViewInset.bottom;
    

    //箭头方向改变
    if (scrollView.tag == 0) {
        if(showHeight >= 30){
            self.recommendIconUpImageView.transform = CGAffineTransformMakeRotation(M_PI);
        }else if(showHeight < 30 && showHeight > 0){
            CGFloat radians = showHeight * M_PI / 30.0;
            self.recommendIconUpImageView.transform = CGAffineTransformMakeRotation(radians);
        }else if(showHeight <= 0){
            self.recommendIconUpImageView.transform = CGAffineTransformMakeRotation(0.0);
        }
    }
    if(scrollView.tag == 1){
        if(scrollView.contentOffset.y <= -30){
            self.recommendIconDownImageView.transform = CGAffineTransformMakeRotation(-M_PI);
        }else if(scrollView.contentOffset.y<0 && scrollView.contentOffset.y>-30){
            CGFloat radians = scrollView.contentOffset.y * M_PI / 30.0;
            self.recommendIconDownImageView.transform = CGAffineTransformMakeRotation(radians);
        }else if(scrollView.contentOffset.y >= 0){
            self.recommendIconDownImageView.transform = CGAffineTransformMakeRotation(0.0);
        }
    }
    
    NSInteger cellCount = [self.tableView numberOfRowsInSection:0];
    //倒数第二个楼层
    NSInteger destCell = cellCount>3 ? (cellCount-3) : 0;
    //可见cell数组
    NSArray *indexes = [self.tableView indexPathsForVisibleRows];
    if ([indexes count]>0) {
        NSIndexPath *visibleIndex = [indexes objectAtIndex:([indexes count]-1)];
        //当可见cell达到倒数第二个楼层时可以请求
        if (scrollView.tag == 0 && visibleIndex.row >= destCell) {
            if (willRequestRecommendData) {
                // 请求你喜欢的数据
                willRequestRecommendData = NO;
            }
        }
    }
}

@end
