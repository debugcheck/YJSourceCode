//
//  HomePageViewController.m
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "HomePageViewController.h"
#import "NewGetRedPackViewController.h"

@implementation HomePageViewController

-(void)loginOK{
    NewGetRedPackViewController *getredpack = [[NewGetRedPackViewController alloc] init];
    getredpack.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:getredpack animated:YES];
}


@end
