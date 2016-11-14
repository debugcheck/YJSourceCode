//
//  HomePageViewController.m
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "HomePageViewController.h"
#import "NewGetRedPackViewController.h"

@interface HomePageViewController () {
    //是否请求推荐数据
    BOOL                willRequestRecommendData;
}

@property (nonatomic,strong) UIImageView        *recommendIconUpImageView;
@property (nonatomic,strong) UIImageView        *recommendIconDownImageView;

@end

@implementation HomePageViewController

-(void)loginOK{
    NewGetRedPackViewController *getredpack = [[NewGetRedPackViewController alloc] init];
    getredpack.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:getredpack animated:YES];
}

@end
