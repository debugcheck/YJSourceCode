//
//  LotteryOrderDetailViewController.m
//  SuningEBuy
//
//  Created by david on 12-7-3.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "LotteryOrderDetailViewController.h"
#import "LotteryListViewController.h"
#import "LotteryHallDto.h"
#import "BallSelectConstant.h"
#import "Welfare3DListViewController.h"
#import "OrderDetailNumbersView.h"
#import "OrderDetailPeriodsView.h"
#import "OrderDetailView.h"
#import "OrderDetailLotteryNumberView.h"
#import "LotteryDataModel.h"
#import "ArrangeBallViewController.h"
#import "LoginViewController.h"
#import "AuthManagerNavViewController.h"

@interface LotteryOrderDetailViewController() <OrderDetailViewDelegate>{
    
    BOOL                            isLoadOK;
    OrderDetailView                 *_orderDetailView;   //订单明细
    
    OrderDetailNumbersView        *_betNumbersView;     //投注内容视图
    
    OrderDetailPeriodsView        *_buyPeriodsView;     //追号列表视图
    
    OrderDetailLotteryNumberView *_lotteryNumberView; //开奖号码视图
    
    UIView                            *_noDataTipView;      //没有数据时tipview
    
    UIImageView                      *_bottomView;         //底部视图
}

@end


@implementation LotteryOrderDetailViewController


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{    

    
//    ArrangeListViewController *controller = [[ArrangeListViewController alloc] initWithLotteryHallDto:tempDto andLotteryOrderListDto:dto isFromOrder:YES];
//    TT_RELEASE_SAFELY(dto);
//    
//    controller.delegate = self;
//    [self.navigationController pushViewController:controller animated:YES];

    
//    LotteryListViewController *contoller = [[LotteryListViewController alloc] initWIthTitle:tempDto.gname andLotteryTimes:tempDto.nowpid  andEndTime:tempDto.nowendtime];
//    
//    contoller.lotteryList = [self dealWithCodeList];
//    
//    contoller.isFromOrder = YES;
//    
//    contoller.lotteryHallDto = tempDto;
//    
//    [self.navigationController pushViewController:contoller animated:YES];
    
    
//    Welfare3DListViewController *contoller = [[Welfare3DListViewController alloc] initWIthTitle:tempDto.gname andLotteryTimes:tempDto.nowpid  andEndTime:tempDto.nowendtime];
//    
//    contoller.lotteryList = [self dealWith3DCodeList];
//    
//    contoller.isFromOrder = YES;
//    
//    contoller.lotteryHallDto = tempDto;
//    
//    NSString *lastBallString = [contoller.lotteryList objectAtIndex:[contoller.lotteryList count] - 1];
//    
//    NSString *ballTypeString = [lastBallString substringWithRange:NSMakeRange(lastBallString.length - 3, 3)];
//    
//    contoller.selectBallType = [ballTypeString intValue];
//    
//    [self.navigationController pushViewController:contoller animated:YES];



}

@end
