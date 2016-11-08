//
//  NewGetRedPackViewController.m
//  SuningEBuy
//
//  Created by sn－wahaha on 14-9-23.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NewGetRedPackViewController.h"
#import "LoginViewController.h"
#import "DataValidate.h"
#import "GetRedPackSuccessViewController.h"
//#import "BoundPhoneViewController.h"
@implementation NewGetRedPackViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    GetRedPackSuccessViewController *getred = [[GetRedPackSuccessViewController alloc] init];
    [self.navigationController pushViewController:getred animated:YES];
    
}


@end
