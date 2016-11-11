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
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceSearchByKeyWord) name:VOICE_SEARCH object:nil];
        
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

#pragma -mark
#pragma HomeSearchControllerdelegate

- (void)didSelectHotUrl:(NSString *)url bFromHomeSearchView:(BOOL)bFromHSView wordOfUrl:(NSString *)word
{
    if (url && url.length > 0)
        
    {
        
        @weakify(self);
        [self routeWithUrl:url complete:^(BOOL isSuccess, NSString *errorMsg) {
            @strongify(self);
            if (!isSuccess) {
                
                [self didSelectAssociationalWord:word];
            }
        }];
        
    }
    else
    {
        [self didSelectAssociationalWord:word];
    }
}

- (void)didSelectAssociationalTypeKeyword:(NSString *)keyword andDirId:(NSString *)dirid andCore:(NSString *)core
{
    //    [AppDelegate currentAppDelegate].tabBarViewController.selectedIndex = 1;
    //    AuthManagerNavViewController *nav = (AuthManagerNavViewController *)[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:1];
    //    [nav popToRootViewControllerAnimated:NO];
    //    NewSearchViewController *search = (NewSearchViewController *)[nav.viewControllers objectAtIndex:0];
    //    [search didSelectAssociationalTypeKeyword:keyword andDirId:dirid andCore:core];
    //    search.homeKeyString = keyword;
    [_homeView.searchBarView.searchTextField resignFirstResponder];
    _homeView.searchBarView.searchTextField.text = nil;
    
    [_homeView hideSearchBar:nil];
    
    if (keyword == nil || [keyword isEmptyOrWhitespace]) {
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
    
    __weak HomePageViewController *weakSelf = self;
    
    
    SearchParamDTO *solrParam = [[SearchParamDTO alloc] initWithSearchType:SearchTypeKeyword set:SearchSetMix];
    //    if ([core isEqualToString:@"electric"])
    //    {
    //        [solrParam resetWithSearchType:SearchTypeKeyword
    //                                              set:SearchSetElec];
    //    }
    //    else if ([core isEqualToString:@"book"])
    //    {
    //        [solrParam resetWithSearchType:SearchTypeKeyword
    //                                              set:SearchSetBook];
    //    }
    //    else
    //        [solrParam resetWithSearchType:SearchTypeKeyword
    //                                              set:SearchSetMix];
    solrParam.categoryId = dirid;
    solrParam.keyword = keyword;
    SearchListViewController *nextController = [[SearchListViewController alloc] initWithSearchCondition:solrParam];
    TT_RELEASE_SAFELY(solrParam);
    
    //chupeng 修改为新的搜索结果界面
    FilterRootViewController *vRightRoot = [[FilterRootViewController alloc] init];
    vRightRoot.isNeedBackItem = NO;
    vRightRoot.delegate = nextController;
    
    FilterNavigationController *navRight = [[FilterNavigationController alloc] initWithRootViewController:vRightRoot];
    //    navRight.view.backgroundColor = [UIColor clearColor];
    //    [navRight.navigationBar setBackgroundImage:[UIImage imageNamed:kNavigationBarBackgroundImage] forBarMetrics:UIBarMetricsDefault];
    
    JASidePanelController *jasideController = [[JASidePanelController alloc] init];
    jasideController.shouldDelegateAutorotateToVisiblePanel = NO;
    jasideController.rightGapPercentage = 0.8;
    jasideController.shouldResizeRightPanel = YES;
    jasideController.bounceOnSidePanelOpen = NO;
    jasideController.allowLeftOverpan = NO;
    jasideController.allowRightOverpan = NO;
    jasideController.centerPanel = nextController;
    jasideController.rightPanel = navRight;
    jasideController.leftPanel = nil;
    jasideController.hidesBottomBarWhenPushed = YES;
    
    //    [jasideController addObserver:nextController forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:"getstate"];
    
    [self.navigationController pushViewController:jasideController animated:YES];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    if (KHomePage)
    {
        [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];
        [PerformanceStatistics sharePerformanceStatistics].countStatus = 0;
        [PerformanceStatistics sharePerformanceStatistics].startTimeStatus = nil;
    }
}


#pragma mark -HomePageServiceDelegate
- (void) homePageServiceComplete:(HomePageService244 *)service isSuccess:(BOOL) isSuccess {
    [self refreshDataComplete];
    if (isSuccess) {
        if (KHomePage)
        {
            if ([PerformanceStatistics sharePerformanceStatistics].arrayData.count > 0)
            {
                
                [PerformanceStatistics sharePerformanceStatistics].countStatus += 1;
                if ([PerformanceStatistics sharePerformanceStatistics].countStatus == [PerformanceStatistics sharePerformanceStatistics].arrayData.count)
                {
                    PerformanceStatisticsData* temp = [[PerformanceStatistics sharePerformanceStatistics].arrayData safeObjectAtIndex:0];
                    temp.endTime = [NSDate date];
                    [[PerformanceStatistics sharePerformanceStatistics]sendData:temp];
                    [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];
                }
            }
            
        }

        [floorDataArray removeAllObjects];
        if (!IsArrEmpty(service.floorArray)) {
            [floorDataArray addObjectsFromArray:service.floorArray];
        }
        //为了防止首页数据没加载时显示底部推荐标签的情况
        willLoadRecommendLabel = NO;
        [self.tableView reloadData];
    }
    else {
        [GlobalDataCenter defaultCenter].homeDataVersion = @"-1";
        [self presentSheet:service.errorMsg];
    }
}

- (void)homeVersionServiceComplete:(HomePageService244 *)service needReGetData:(BOOL )flag {
    if (flag) {
        //需要重新获取首页数据YJ
    }
    else{
        if (KHomePage){
            [PerformanceStatistics sharePerformanceStatistics].countStatus += 1;
            [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];
            
        }
        [self refreshDataComplete];
    }
}


/**
 *  代理返回，是否刷新首页数据
 *
 *  @param service    service
 *  @param dataFlag   是否需要请求楼层数据
 *  @param switchFlag 是否需要请求开关数据
 */
- (void)homeVersionServiceComplete:(HomePageService244 *)service homeDataFlag:(BOOL )dataFlag homeSwitchFlag:(BOOL )switchFlag {
    if (dataFlag) {
        //调用接口，获取首页楼层数据YJ
    }
    
    if (switchFlag) {
        //调用接口，获取开关数据
        [SNSwitch updateWithCallBack:^{
            if([SNSwitch shouyexinren244]!=nil || [SNSwitch lingquhongbao244]!= nil){
                // 开始请求红包的数据
            }
            _homeView.searchBarView.searchTextField.placeholder = @"随机--";
            // 检查版本 YJ
        }];
    }
    
    if (dataFlag == NO) {
        [self refreshDataComplete];
    }
}

#pragma mark - EightBannerViewDelegate
- (void)eightBannerSelectedDTO:(HomeModuleDTO *)moduleDTO {
    //基类里处理
    [self handleTargetType:moduleDTO.targetType targetURLString:moduleDTO.targetURL];
}

- (void)selectModuleDTO:(HomeModuleDTO *)dto {
    [self eightBannerSelectedDTO:dto];
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
