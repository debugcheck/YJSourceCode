//
//  LotteryDealsViewController.m
//  SuningLottery
//
//  Created by lyywhg on 13-4-12.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "LotteryDealsViewController.h"
#import "LotteryOrderDetailViewController.h"
#import "LotteryHallViewController.h"

#define kDealListObservingKey  @"dealListErrorMsg"
#define kDealSerialNumberListObservingKey   @"dealSerialNumberListErrorMsg"

@interface LotteryDealsViewController ()

//暂存数组  用于暂存请求来的数据
@property (nonatomic, strong)    NSMutableArray         *dealListArray;
@end

@implementation LotteryDealsViewController



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    LotteryOrderDetailViewController *detailViewController = nil;
    detailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
