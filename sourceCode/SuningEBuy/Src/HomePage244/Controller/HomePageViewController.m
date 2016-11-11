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
    NSMutableArray  *tableStructureDictArray;
    int index;
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


- (id)init{
    self = [super init];
    if (self) {
        self.hasNav = NO;
        self.isNeedBackItem = NO;
        self.iOS7FullScreenLayout = YES;
        self.isLastPage = YES;
        
        self.bSupportPanUI = NO;
        
        self.iOS7FullScreenLayout = YES;
        
        index = 1;
        
        tableStructureDictArray = [[NSMutableArray alloc] init];
        
        floorDataArray = [[NSMutableArray alloc] init];
//        edit by gjf，刷新页面
        [self refreshData];

        
    }
    return self;
}

- (void)searchFieldSearchButtonClicked:(UITextField *)searchField
{
    [ChooseSearchTypeView hide];
    NSString *keyword = searchField.text;
    if (keyword == nil || [keyword isEmptyOrWhitespace]) {
        //        if ([_homeView.searchBarView.searchTextField.placeholder isEqualToString:@"搜索商品"]) {
        //            keyword = nil;
        //            return;
        //        }
        //        else
        //        {
        //            keyword = _homeView.searchBarView.searchTextField.placeholder;
        //        }
        
        return;
    }
    
    if (keyword.length > 0) //语音键盘默认占位符 %EF%BF%BC,此时return
    {//efbfbc
        NSString *str = @"%EF%BF%BC";
        NSString *urlKeyword = [keyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSRange range = [urlKeyword rangeOfString:str];
        if ( range.location!= NSNotFound)
        {
            return;
        }
    }
    [searchField resignFirstResponder];
    
    //    NSString *url = [[DefaultKeyWordManager defaultManager] findUrlWithWord:keyword];
    //
    //    if (url && url.length > 0)
    //    {
    
    //        @weakify(self);
    //        [self routeWithUrl:url complete:^(BOOL isSuccess) {
    //
    //            @strongify(self);
    //            if (!isSuccess) {
    //
    //                [self didSelectAssociationalWord:keyword];
    //            }
    
    //        }];
    //    }
    //    else
    //    {
    [self didSelectAssociationalWord:keyword];
    //    }
    
}


- (void)quickRegistButtonClick {
    NewRegisterViewController *registViewController = [[NewRegisterViewController alloc] init];
    registViewController.registerDelegate = self;
    AuthManagerNavViewController *navController = [[AuthManagerNavViewController alloc] initWithRootViewController:registViewController];
    TT_RELEASE_SAFELY(registViewController);
    [self presentModalViewController:navController animated:YES];
    TT_RELEASE_SAFELY(navController);
    
    //点击埋点
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil] valueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"1120017"], nil]];
}


#pragma mark - EightBannerViewDelegate
- (void)eightBannerSelectedDTO:(HomeModuleDTO *)moduleDTO {
    //基类里处理
    [self handleTargetType:moduleDTO.targetType targetURLString:moduleDTO.targetURL];
}

- (void)goToDeliveryInstall:(id)sender
{
    ServiceTrackListViewController *nextViewController = [[ServiceTrackListViewController alloc] init];
    NSString *userName = [SFHFKeychainUtils getPasswordForUsername:kSuningLoginUserNameKey andServiceName:kSNKeychainServiceNameSuffix error:nil];
    NSString *passwd = [SFHFKeychainUtils getPasswordForUsername:kSuningLoginPasswdKey andServiceName:kSNKeychainServiceNameSuffix error:nil];
    
    NSString *password = [PasswdUtil decryptString:passwd
                                            forKey:kLoginPasswdParamEncodeKey
                                              salt:kPBEDefaultSalt];
    
    if (![UserCenter defaultCenter].isLogined && !IsStrEmpty(userName) && !IsStrEmpty(passwd) && !IsStrEmpty(password))
    {
        //自动登录
        AutoLoginCommand *loginCmd = [AutoLoginCommand command];
        [CommandManage excuteCommand:loginCmd observer:nil];
    }
    
    [self.navigationController pushViewController:nextViewController animated:YES];
    TT_RELEASE_SAFELY(nextViewController);
}


#pragma mark getredpackServiceDelegate
- (void) GetRedPackServiceEntryComplete:(GetRedPackEntryDTO *)service isSuccess:(BOOL) isSuccess{
    if (isSuccess) {
        if ([service.canGetRedPack isEqualToString:@"1"]) {
            [UserCenter defaultCenter].actverule = service.redPackRule;
            [UserCenter defaultCenter].ticketRuleUrl = service.ticketRuleUrl;
            
            if ([SNSwitch lingquhongbao244]) {
                [UserCenter defaultCenter].isGetRedPack = YES;
            }
            getredpackstr = [[SNSwitch shouyexinren244] copy];
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            NSString *name = [defaults objectForKey:@"getredpack"];
            
            
            if (name) {
                if ([SNSwitch Isneedupdate]&&![name isEqualToString:@"0"]) {
                    BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:IsStrEmpty(getredpackstr)?L(@"GetYourRedPacketQuick"):getredpackstr
                                                                        message:getredpackstr
                                                                       delegate:nil
                                                              cancelButtonTitle:L(@"GetNextTime")
                                                              otherButtonTitles:L(@"GetNow")];
                    [alertView setCancelBlock:^{
                        //下次领取
                        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                        NSString *name =@"getredpack";
                        [defaults setObject:@"0" forKey:name];
                    } ];
                    [alertView setConfirmBlock:^{
                        //                if ([UserCenter defaultCenter].isLogined) {
                        [self loginOK];
                    }];
                    if (getredpackstr) {
                        [alertView show];
                    }
                    isCanGetRedPack = YES;
                }
            }
            else{
                if ([SNSwitch Isneedupdate]) {
                    BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:IsStrEmpty(getredpackstr)?L(@"GetYourRedPacketQuick"):getredpackstr
                                                                        message:getredpackstr
                                                                       delegate:nil
                                                              cancelButtonTitle:L(@"GetNextTime")
                                                              otherButtonTitles:L(@"GetNow")];
                    [alertView setCancelBlock:^{
                        //下次领取
                        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                        NSString *name =@"getredpack";
                        [defaults setObject:@"0" forKey:name];
                    } ];
                    [alertView setConfirmBlock:^{
                        //                if ([UserCenter defaultCenter].isLogined) {
                        [self loginOK];
                    }];
                    
                    if (getredpackstr) {
                        [alertView show];
                    }
                    isCanGetRedPack = YES;
                }
            }
        }
    }
}


-(void)loginOK{
    NewGetRedPackViewController *getredpack = [[NewGetRedPackViewController alloc] init];
    getredpack.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:getredpack animated:YES];
}


#pragma mark -
#pragma mark scroll delagate

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
