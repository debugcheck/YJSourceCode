//
//  MyCardViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "MyCardViewController.h"
#import "AccountListViewController.h"
#import "MobileBoundViewController.h"
#import "EmailBoundViewController.h"

#define DefaultTextColor           [UIColor colorWithRGBHex:0x444444]

@interface MyCardViewController ()
{
    BOOL            isLoadOk;
}

@end

@implementation MyCardViewController


- (id)init
{
    self = [super init];
    if (self) {
        isLoadOk = NO;
        self.title = L(@"Electronic membership card");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"Member_LoginAndRegister"),self.title];
        
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


- (void)loadView{
    [super loadView];
    
    self.hasSuspendButton = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!isLoadOk) {
        [self displayOverFlowActivityView];
        [self.memberMergeService beginSearchMbrCardInfoHttpRequest];
    }
    if ([[UserCenter defaultCenter].userInfoDTO.isBindMobile isEqualToString:@"0"]) {
        
    }else{
        
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

//    MobileBoundViewController *mobile = [[MobileBoundViewController alloc] init];
//    mobile.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:mobile animated:YES];
    
    EmailBoundViewController *email = [[EmailBoundViewController alloc] init];
    email.hidesBottomBarWhenPushed = YES;
    NSRange range = [[UserCenter defaultCenter].userInfoDTO.logonId rangeOfString:@"@"];
    if (range.location != NSNotFound) {
        email.emailAccount = [UserCenter defaultCenter].userInfoDTO.logonId;
    }
    [self.navigationController pushViewController:email animated:YES];
    
    
    ///
    
//    AccountListViewController *list = [[AccountListViewController alloc] init];
//    list.accoutList = service.cardNoList;
//    [self.navigationController pushViewController:list animated:YES];
}


@end
