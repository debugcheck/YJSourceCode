//
//  MyEbuyViewController.m
//  SuningEBuy
//
//  Created by shasha on 12-8-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "MyEbuyViewController.h"
#import "UserCenter.h"
#import "InterestProductsView.h"
#import "UserInfoView.h"
#import "EditNicknameViewController.h"
#import "AuthManagerNavViewController.h"
#import "LoginViewController.h"
#import "MYEfubaoViewController.h"
//#import "EfubaoUnActiveViewController.h"
//#import "EfubaoUnBoundEmailViewController.h"
//#import "EfubaoUnboundPhoneViewController.h"
//#import "MyFavoriteViewController.h"
#import "ProductDetailViewController.h"
#import "ActiveMyIntegerViewController.h"

#import "BussinessTravelOrderCenterViewController.h"

#import "MyTicketListViewController.h"
#import "MyIntegerUnActiveViewController.h"

#import "LogOutCommand.h"
#import "GBOrderListViewController.h"

#import "AddressInfoListViewController.h"

#import "EvaluationListViewController.h"
#import "LotteryDealsViewController.h"

#import "ServiceTrackListViewController.h"
#import "UserFeedBackPreViewController.h"
//#import "ActiveEfubaoViewController.h"
//#import "OrderListViewController.h"
#import "NOrderListViewController.h"
#import "SNSwitch.h"
#import "SNWebViewController.h"
#import "SNSwitch.h"

#import "UITableViewCell+BgView.h"

#import "JASidePanelController.h"

#import "HotelOrderListViewController.h"
#import "UIImage-Extensions.h"

#import "InvitationService.h"

#define LoginTitle  L(@"LoginTitle")
#define LogoutTitle L(@"LogoutTitle")
#define SIZEFONT     20
#define KSPACE 50
#define KY     39.5
#import <SSA_IOS/SSAIOSSNDataCollection.h>
#import "SuNingSellDao.h"

@interface MyEbuyViewController()


@end


@implementation MyEbuyViewController


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    LotteryDealsViewController *listCtrl = [[LotteryDealsViewController alloc]init];
    
    listCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:listCtrl animated:NO];
    
    
//    AddressInfoListViewController *vc = [AddressInfoListViewController controller];
//    //    vc.isFromAddressInfo = FromEbuy;
//    vc.cellType = FromEbuy;
//    [self.navigationController pushViewController:vc animated:YES];
    
//    BussinessTravelOrderCenterViewController *TV = [[BussinessTravelOrderCenterViewController alloc] init];
//    
//    [self.navigationController pushViewController:TV animated:YES];
    
    
//    
//    ServiceTrackListViewController *nextViewController = [[ServiceTrackListViewController alloc] init];
//    [self.navigationController pushViewController:nextViewController animated:YES];


    //    ConsultationViewController *consult = [[ConsultationViewController alloc] init];
    //    consult.ismyconsult=YES;
    //    [self.navigationController pushViewController:consult animated:YES];
    
    
    
//    EditNicknameViewController *edit = [[EditNicknameViewController alloc] init];
//    
//    AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:edit];
//    
//    [self presentModalViewController:nav animated:YES];
    
    
//    MyTicketListViewController *TV = [[MyTicketListViewController alloc] init];
//    TV.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:TV animated:YES];

    // 酒店订单
//    HotelOrderListViewController *TV = [[HotelOrderListViewController alloc] init];
//    TV.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:TV animated:YES];


  
    

}

@end
