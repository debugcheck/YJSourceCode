//
//  EmailBoundViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-21.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "EmailBoundViewController.h"
#import "AccountMergerViewController.h"
#import "AccountListViewController.h"
#import "DataValidate.h"
#import "MobileBoundViewController.h"
#import "AccountCertainViewController.h"
#import "AccountMergeSuccessViewController.h"
#import "SNGraphics.h"
#import "UITableViewCell+BgView.h"

@implementation EmailBoundViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    AccountListViewController *list = [[AccountListViewController alloc] init];
    [self.navigationController pushViewController:list animated:YES];
    
//    AccountMergeSuccessViewController *find = [[AccountMergeSuccessViewController alloc] init];
//    find.memberInfoDto = self.checkCodeService.memberInfoDto;
//    [self.navigationController pushViewController:find animated:YES];
    
//    MobileBoundViewController *merge = [[MobileBoundViewController alloc] init];
//    merge.isEmailBind = YES;
//    [self.navigationController pushViewController:merge animated:YES];



}


@end
