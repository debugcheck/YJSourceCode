//
//  MembershipInfoViewController.m
//  SuningEBuy
//
//  Created by zl on 14-11-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "MembershipInfoViewController.h"
//#import "EfubaoUnboundPhoneViewController.h"
//#import "EfubaoUnActiveViewController.h"
//#import "EfubaoUnBoundEmailViewController.h"
@interface MembershipInfoViewController ()

@end

@implementation MembershipInfoViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"会员资料";
        self.pageTitle = @"会员资料";
        iswdy = 0;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    MyIntegralExchangeViewController *nextViewController = [[MyIntegralExchangeViewController alloc] init];
    
    [self.navigationController pushViewController:nextViewController animated:YES];

}


@end
