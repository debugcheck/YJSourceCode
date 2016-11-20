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

@interface MyEbuyViewController()<UINavigationControllerDelegate,UserDiscountServiceDelegate,EGOImageViewDelegate,OrderCenterServiceDelegate,InvitationServiceDelegate,cardServiceDelegate,CardWbSerViceDelegate,OrdersNumberServiceDelegate,NewEvalutionServiceDelegate>
{
    BOOL  isAlertOutDateCoupon;//是否已经提示用户有未使用的易购券
    BOOL isPressedActiveBtn;
    
    BOOL  _isOrderNumLoaded;
    
    BOOL isBackFromLottery;
    InvitationService *_invita;
    //int iswdy;//优惠卷的个数
    //BOOL isGetRedPack;
    BOOL isshowgetredpack;

}

//@property (nonatomic,strong) MyEbuyCenterButtonsView *btnAndLblView;

@property (nonatomic,strong) UILabel *headLbl;

//@property (nonatomic,strong) UIView *headView;

@property (nonatomic,strong) UIView *footView;

@property (nonatomic,strong) UserInfoView   *userInfoView;

@property (nonatomic,strong) UILabel *myIntegralLbl;

@property (nonatomic,strong) UILabel *myIntegralValLbl;

@property (nonatomic,strong) UILabel *advanceLbl;

@property (nonatomic,strong) UILabel *advanceValLbl;

@property (nonatomic,strong) UILabel *userNameLbl;//这个未使用

@property (nonatomic,strong) UILabel *userNameValLbl;//用户名字

@property (nonatomic,strong) UIImageView *userImageView;//头像
@property (nonatomic,strong) UIImageView *userImageView1;//头像

@property (nonatomic,strong) UILabel *jifenValLbl;//云钻显示

@property (nonatomic,strong) UIButton *jifenValBt;//云钻显示
//@property (nonatomic,strong) UILabel *dengjiValLbl;//等级显示

@property (nonatomic,strong) UIImageView *dengjiImageView;//会员等级图片

@property (nonatomic,strong) EGOImageView *userInfoImageView;//背景图片

@property (nonatomic,strong) CALayer* arrowImage;

//@property (nonatomic,strong) UIButton *activeBtn;

@property (nonatomic,strong) UIButton *waitePayBtn;//待支付

@property (nonatomic,strong) UIButton *waiteReceiveBtn;//待收货


@property (nonatomic,strong) UIButton *returnBtn;

@property (nonatomic,strong) UILabel *unLoginLab;//欢迎来到苏宁提示语

@property (nonatomic,strong) UIButton *loginBtn;//登录按钮

@property (nonatomic,strong) UIButton *changeUserImageBtn;//改变头像按钮

@property (nonatomic, strong) CardDTO *cardDto;

@property (nonatomic, strong) CardService *cardService;

@property (nonatomic, strong) CardWbSerVice         *service;

@property (nonatomic, strong) CardDetailBaseDTO     *cardDetailBaseDto;

@property (nonatomic, strong) UIImage       *userImage;

@property (nonatomic, strong) OrdersNumberDTO *orderNumber;

@property (nonatomic, strong) UIView     *tableHeaderView;//头像区域
@property (nonatomic, strong) UIImageView *payNumber;//待支付
@property (nonatomic, strong) UILabel     *payNumberLabel;//待支付

@property (nonatomic, strong) UIImageView *ReceiptNumber;//待收货
@property (nonatomic, strong) UILabel     *receiptNumberLabel;//待收货

@property (nonatomic, strong) UILabel     *returnNumberLabel;//待退货
@property (nonatomic, strong) UIImageView *returnNumber;//待退货

@property (nonatomic, strong) NSString    *YuELab;//易付宝
@property (nonatomic, strong) NSString    *jifengLab;//云钻
@property (nonatomic, strong) NSString    *quanLab;//云钻

@property (nonatomic, assign)BOOL isLogined;//待评价数量

@property (nonatomic,strong) UIButton *userImageBtn;//按钮

- (void)initialNotifications;

- (void)updateUserDiscountView;


@end


@implementation MyEbuyViewController
//@synthesize btnAndLblView = _btnAndLblView;
@synthesize headLbl = _headLbl;
//@synthesize headView = _headView;
@synthesize footView = _footView;
@synthesize userDiscountService = _userDiscountService;
@synthesize userInfoView = _userInfoView;
@synthesize myIntegralLbl = _myIntegralLbl;
@synthesize myIntegralValLbl = _myIntegralValLbl;
@synthesize advanceLbl = _advanceLbl;
@synthesize advanceValLbl = _advanceValLbl;

@synthesize userNameLbl = _userNameLbl;
@synthesize userNameValLbl = _userNameValLbl;

@synthesize changeUserImageBtn = _changeUserImageBtn;

@synthesize userImage = _userImage;
@synthesize userImageView = _userImageView;

@synthesize payNumber = _payNumber;
@synthesize ReceiptNumber = _ReceiptNumber;
@synthesize payNumberLabel = _payNumberLabel;
@synthesize receiptNumberLabel = _receiptNumberLabel;

@synthesize returnNumberLabel =_returnNumberLabel;
@synthesize returnNumber = _returnNumber;
@synthesize jifenValLbl = _jifenValLbl;
@synthesize dengjiImageView = _dengjiImageView;
@synthesize YuELab = _YuELab;
@synthesize jifengLab = _jifengLab;
@synthesize quanLab = _quanLab;
@synthesize jifenValBt = _jifenValBt;

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        isPressedActiveBtn = NO;
        
        self.isNeedBackItem = NO;
        
        isshowgetredpack = NO;
        
        self.isLoadOrderNumber = YES;
        
        self.isLoadUserImage = YES;
        
        self.title = L(@"myEbuy");
        
        self.pageTitle = L(@"member_myEbuy");
        
        self.hasNav = YES;   //隐藏nav

        _orderStatInfo = nil;
        
        self.isLogined = NO;
        [self initialNotifications];
        
        [self setIOS7FullScreenLayout:YES];
        
        [self view];
        
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)loadView{
    
    [super loadView];
    
    CGRect frame = [self visibleBoundsShowNav:self.hasNav showTabBar:!self.hidesBottomBarWhenPushed];
    
    //frame.origin.y = 0;
//    if (IOS7_OR_LATER)
//    {
//        frame.size.height -= 44;
//    }
    self.tpTableView = (id)self.groupTableView;
    
    self.tpTableView.frame = frame;
    self.tpTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tpTableView.delegate = self;
    self.tpTableView.showsVerticalScrollIndicator = NO;
    self.tpTableView.dataSource = self;
    
    [self.view addSubview:self.tpTableView];
    
    //self.tpTableView.tableHeaderView = [self tableHeaderView];
    //[self.userInfoImageView removeAllSubviews];
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setHidden:YES];
//    self.hasNav = NO;
//    [self setIOS7FullScreenLayout:YES];
    if (KPerformance)
    {
        [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];
        [PerformanceStatistics sharePerformanceStatistics].startTimeStatus = [NSDate date];
        [PerformanceStatistics sharePerformanceStatistics].countStatus = 0;
    }
    [self loadAndRefreshViews];
}

- (void)loadAndRefreshViews
{
    self.orderNumber.waitDeliveryCounts = @"";
    self.orderNumber.waitPayCounts = @"";
    self.orderNumber.ordersInReturnCounts = @"";
    
    isPressedActiveBtn = NO;
    
    [self getUserInfoImageView];
    
    [self initWithLoginState:[self isLogin]];
    
    //iswdy = (int)(([SNSwitch yaoqinghaoyou244])?1:0)+(int)([UserCenter defaultCenter].isGetRedPack?1:0);
    
    //isGetRedPack = [UserCenter defaultCenter].isGetRedPack;
    [self.tpTableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.1];
    
    if([self isLogin])
    {
        
        //if(self.isLoadUserImage)
        {
            [self queryUserImage];
        }
        [self ordersNumber];
    }

    if (self.userImageView1.image == nil)
    {
        self.userImageView1.image = [UIImage imageNamed:@"New_UserPhoto.png"];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.orderNumber.waitDeliveryCounts = @"";
    self.orderNumber.waitPayCounts = @"";
    self.orderNumber.ordersInReturnCounts = @"";

    [self.tpTableView reloadData];
}

- (UILabel *)returnNumberLabel
{
    if (!_returnNumberLabel) {
        _returnNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        _returnNumberLabel.backgroundColor = [UIColor clearColor];
        _returnNumberLabel.textColor = [UIColor whiteColor];
        _returnNumberLabel.textAlignment = NSTextAlignmentCenter;
        _returnNumberLabel.text = @"";
        _returnNumberLabel.adjustsFontSizeToFitWidth = YES;
        _returnNumberLabel.font = [UIFont boldSystemFontOfSize:10.0f];
    }
    return  _returnNumberLabel;
}

- (UILabel *)payNumberLabel
{
    if (!_payNumberLabel) {
        _payNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        _payNumberLabel.backgroundColor = [UIColor clearColor];
        _payNumberLabel.textColor = [UIColor whiteColor];
        _payNumberLabel.textAlignment = NSTextAlignmentCenter;
        _payNumberLabel.text = @"";
        _payNumberLabel.adjustsFontSizeToFitWidth = YES;
        _payNumberLabel.font = [UIFont boldSystemFontOfSize:10.0f];
    }
    return  _payNumberLabel;
}

- (UILabel *)receiptNumberLabel
{
    if (!_receiptNumberLabel) {
        _receiptNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        _receiptNumberLabel.backgroundColor = [UIColor clearColor];
        _receiptNumberLabel.textColor = [UIColor whiteColor];
        _receiptNumberLabel.textAlignment = NSTextAlignmentCenter;
        _receiptNumberLabel.text = @"";
        _receiptNumberLabel.adjustsFontSizeToFitWidth = YES;
        _receiptNumberLabel.font = [UIFont boldSystemFontOfSize:10.0f];
    }
    return  _receiptNumberLabel;
}

- (UIImageView *)payNumber
{//待支付
    if (!_payNumber) {
        _payNumber = [[UIImageView alloc] initWithFrame:CGRectMake(45, 5, 15, 15)];
        _payNumber.backgroundColor = [UIColor clearColor];
        [_payNumber setImage:[UIImage imageNamed:@"productDetail_carNumber.png"]];
    }
    return _payNumber;
}

- (UIImageView *)ReceiptNumber
{//待收货
    if (!_ReceiptNumber) {
        _ReceiptNumber = [[UIImageView alloc] initWithFrame:CGRectMake(45, 5, 15, 15)];
        _ReceiptNumber.backgroundColor = [UIColor clearColor];
        [_ReceiptNumber setImage:[UIImage imageNamed:@"productDetail_carNumber.png"]];
    }
    return _ReceiptNumber;
}

//待支付
-(UIButton*)waitePayBtn{
    
    if (!_waitePayBtn) {
        
       _waitePayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _waitePayBtn.backgroundColor = [UIColor whiteColor];
        
        
        [_waitePayBtn addTarget:self action:@selector(waitePayBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
//        _waitePayBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
//        
//        [_waitePayBtn setTitle:L(@"MyEBuy_WaitingForPay") forState:UIControlStateNormal];
        
        [_waitePayBtn setTitleColor:[UIColor light_Black_Color] forState:UIControlStateNormal];
        
        _waitePayBtn.frame = CGRectMake(0, 0, 80, 48.5);
        
        _waitePayBtn.tag = 1000;//dingdan-icon-daizhifu.png
        
        UIImageView* v = [[UIImageView alloc] initWithFrame:CGRectMake(25,5, 30, 30)];
        v.image = [UIImage imageNamed:@"dingdan-icon-daizhifu.png"];
        UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 25, 40, 23.4)];
        lab.text = L(@"MyEBuy_WaitingForPay");
        lab.backgroundColor = [UIColor clearColor];
        lab.font = [UIFont boldSystemFontOfSize:12];
        [_waitePayBtn addSubview:lab];
        [_waitePayBtn addSubview:v];
    }
    
    return _waitePayBtn;
}

//待收货
-(UIButton*)waiteReceiveBtn{
    
    if (!_waiteReceiveBtn) {
        
        _waiteReceiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // UIImage *settingImage = [UIImage imageNamed:@"New_SettingBtn.png"];
        
        _waiteReceiveBtn.backgroundColor = [UIColor whiteColor];
         [_waiteReceiveBtn addTarget:self action:@selector(waiteReceiveBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
//        _waiteReceiveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
//        
//        [_waiteReceiveBtn setTitle:L(@"MyEBuy_WaitingForReceive") forState:UIControlStateNormal];
        
        [_waiteReceiveBtn setTitleColor:[UIColor light_Black_Color] forState:UIControlStateNormal];
        
        _waiteReceiveBtn.frame = CGRectMake(81, 0, 79, 48.5);
        
        _waiteReceiveBtn.tag = 1001;
        UIImageView* v = [[UIImageView alloc] initWithFrame:CGRectMake(25,5, 30, 30)];
        v.image = [UIImage imageNamed:@"dingdan-icon-daishouhuo.png"];
        UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 25, 40, 23.4)];
        lab.text = L(@"MyEBuy_WaitingForReceive");
        lab.backgroundColor = [UIColor clearColor];
        lab.font = [UIFont boldSystemFontOfSize:12];
        [_waiteReceiveBtn addSubview:lab];
        [_waiteReceiveBtn addSubview:v];
    }
    
    return _waiteReceiveBtn;
}

//注册监听中心
/*
 监听内容包括：
 1.shouldGoToTicketList:机票购买流程结束，进入机票订单中心。
 2.shouldGoToHotelOrderList:酒店预订流程结束，进入酒店预订订单中心。
 3.shouldGoToOrderCenter：商品购买流程结束，进入订单中心。
 4.shouldGoToFavorite
 5.REQUEST_LOGIN_MESSAGE：登录流程结束，我的易购标签的navigationControllers回到我的易购页面。
 (刘坤废弃于12-11-6)
 6.GET_USERACCOUNTINFO_SUCCESS_NOTIFICATION：用户优惠金额变动，更新我的易购中的用户优惠信息。
 7.LOGIN_OK_MESSAGE：登录成功，我的易购标签的navigationControllers回到我的易购页面。
 */
#pragma mark -通知
- (void)initialNotifications{
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [ defaultCenter addObserver:self selector:@selector(goToLottertOrderCenter)  name:@"GoLotteryOrderDetailFormOrder" object:nil];
    
    
    [ defaultCenter addObserver:self selector:@selector(goToPlaneOrderCenter)  name:@"shouldGoToTicketList" object:nil];
    
    [ defaultCenter addObserver:self selector:@selector(goToHotelOrderCenter)name:@"shouldGoToHotelOrderList" object:nil];
    
    [ defaultCenter addObserver:self selector:@selector(gotoFavorite) name:@"shouldGoToFavorite" object:nil];
    
    //[ defaultCenter addObserver:self selector:@selector(backToMyEbuy:) name:LOGIN_OK_MESSAGE object:nil];
        
    [defaultCenter addObserver:self selector:@selector(goToPlaneOrderCenter) name:SHOULD_GO_TO_PLANE_ORDERCENTER object:nil];
    
    [defaultCenter addObserver:self selector:@selector(autoLoginOk) name:AUTOLOGIN_OK_MESSAGE object:nil];
    [defaultCenter addObserver:self selector:@selector(autoLoginFailed) name:AUTOLOGIN_Failed_MESSAGE object:nil];
    [defaultCenter addObserver:self selector:@selector(autoLoginDidBegin) name:AUTOLOGIN_BEGIN object:nil];
    [defaultCenter addObserver:self selector:@selector(lgoutOK) name:@"lgoutOK" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(sendOrderHttpRequest)
//                                                 name:CANCEL_ORDER_OK_MESSAGE
//                                               object:nil];

}

#pragma mark - 自动登录结果处理
- (void)autoLoginOk
{
    //[self initWithLoginState:[self isLogin]];
    self.loginBtn.hidden = YES;
    [self loadAndRefreshViews];
}

- (void)autoLoginFailed
{
    self.loginBtn.hidden = NO;
    //[self initWithLoginState:[self isLogin]];
    [self loadAndRefreshViews];
}

- (void)autoLoginDidBegin
{
    self.loginBtn.hidden = YES;
}

#pragma mark - 易付宝的通知
//请求查询头像
- (void)queryUserImage
{
    [self displayOverFlowActivityView];
    if (KPerformance)
    {
        if (self.isLogined)
        {
            self.isLogined = NO;
        }
        else
        {
            PerformanceStatisticsData* temp = [[PerformanceStatisticsData alloc] init];
            temp.startTime = [NSDate date];
            temp.functionId = @"4";
            temp.interfaceId = @"406";
            temp.taskId = @"1004";
            temp.count = 1;
            [[PerformanceStatistics sharePerformanceStatistics].arrayData addObject:temp];
        }

    }
    [self.cardService beginGetCardInfo:[UserCenter defaultCenter].userInfoDTO.custNum WithName:nil];
}

//获取待支付数量和待收货共用一个
- (void)ordersNumber
{
    //发请求
    if (KPerformance)
    {
        PerformanceStatisticsData* temp = [[PerformanceStatisticsData alloc] init];
        temp.startTime = [NSDate date];
        temp.functionId = @"4";
        temp.interfaceId = @"403";
        temp.taskId = @"1004";
        temp.count = 2;
        [[PerformanceStatistics sharePerformanceStatistics].arrayData addObject:temp];
    }
    [self.orderNumberService beginGetOrdersNumberInfo:@"" catalogId:@""];
}

//是否登录
- (BOOL)isLogin{
    
    return  [UserCenter defaultCenter].isLogined;
    
}

//登录按钮事件
-(void)loginBtnAction{
    
    self.payNumberLabel.text = @"";
    self.receiptNumberLabel.text = @"";
    self.returnNumberLabel.text = @"";
    LoginViewController *loginViewController = [[LoginViewController alloc] init];

    loginViewController.loginDelegate = self;
    loginViewController.loginDidOkSelector = @selector(loginDidOk);
//    loginViewController.loginDidCancelSelector = @selector(loginDidCancel);

    AuthManagerNavViewController *userNav = [[AuthManagerNavViewController alloc]
                                             initWithRootViewController:loginViewController];

    [self presentModalViewController:userNav animated:YES];

    TT_RELEASE_SAFELY(loginViewController);
    TT_RELEASE_SAFELY(userNav);
    
}

//登录成功
-(void)loginDidOk{
    
    [self initWithLoginState:YES];
    self.isLogined = YES;
    [self queryUserImage];

}

//Hi,欢迎来到苏宁易购标签
-(UILabel *)unLoginLab{
    
    if (!_unLoginLab) {
        
        _unLoginLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 320, 20)];
        
        _unLoginLab.textAlignment = NSTextAlignmentCenter;
        
        _unLoginLab.textColor = [UIColor whiteColor];//[UIColor colorWithWhite:1 alpha:1];
        
        _unLoginLab.font = [UIFont boldSystemFontOfSize:12];
        
        _unLoginLab.backgroundColor = [UIColor clearColor];
        
        _unLoginLab.text = L(@"MyEBuy_WelcomeToSuningEBuy");
        
        [self.userInfoImageView addSubview:_unLoginLab];
    }
    
    return _unLoginLab;
}

//登录按钮
-(UIButton*)loginBtn{
    
    if (!_loginBtn) {
        
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // UIImage *settingImage = [UIImage imageNamed:@"New_SettingBtn.png"];
        _loginBtn.userInteractionEnabled = YES;
        _loginBtn.backgroundColor = [UIColor whiteColor];
        [_loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        _loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        
        _loginBtn.layer.borderColor = [UIColor colorWithString:@"#bcbcbc"].CGColor;
        
        _loginBtn.layer.borderWidth = 1.0;
        
        [_loginBtn setTitle:L(@"MyEBuy_LoginOrRegistration") forState:UIControlStateNormal];
        
        [_loginBtn setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];
        
        // [_loginBtn setTitleColor:[UIColor light_Black_Color] forState:UIControlStateNormal];
        _loginBtn.frame = CGRectMake(100, 65, 120, 35);
        
        
        [self.userImageBtn addSubview:_loginBtn];
        
    }
    
    return _loginBtn;
}

//初始化登录状态
-(void)initWithLoginState:(BOOL)login{
    
    if (login) {
        
        //self.btnAndLblView.hidden = NO;
        //self.userInfoView.hidden = NO;
        self.userNameValLbl.hidden = NO;
        self.userImageView.hidden = NO;
        
        self.unLoginLab.hidden = YES;
        self.loginBtn.hidden = YES;
        self.changeUserImageBtn.enabled = YES;
        self.jifenValLbl.hidden = NO;
        self.dengjiImageView.hidden = NO;
        
        [self.userDiscountService beginGetUserDiscountInfo];
        
        if (isBackFromLottery)
        {
            AuthManagerNavViewController *auth = (AuthManagerNavViewController *)self.parentViewController;
            
            [auth setNavigationBackground:NO];
            
            isBackFromLottery = NO;
        }
        
//        if(!_isOrderNumLoaded)
//        {
//            [self sendOrderHttpRequest];
//        }
    }
    else{
        self.userNameValLbl.hidden = YES;
        self.userImageView.hidden = YES;
        self.jifenValLbl.hidden = YES;
        self.dengjiImageView.hidden = YES;
        
        self.unLoginLab.hidden = NO;
        self.loginBtn.hidden = NO;
        self.changeUserImageBtn.enabled = NO;
    }
}

- (void)lgoutOK
{
    self.userImageView.image= nil;
    self.userImageView1.image= nil;
    self.orderNumber.waitDeliveryCounts = @"";
    self.orderNumber.waitPayCounts = @"";
    self.orderNumber.ordersInReturnCounts = @"";
    [self.tpTableView reloadData];
}

//获取用户数据信息
- (void)getUserInfoImageView
{
    if ([self isLogin])
    {
        UserInfoDTO         *usrBean = [UserCenter defaultCenter].userInfoDTO;
        
        if (IsStrEmpty(usrBean.nickName))
        {
            if ([FormattersValidators isValidEmail:usrBean.logonId])
            {
                NSString* str = [NSString stringWithFormat:@"%@",usrBean.logonId];
                CGSize sizeToFit;
                if ([usrBean.logonId length] > 15)
                {
                    str = [str substringWithRange:NSMakeRange(0,15)];
                    sizeToFit = [str sizeWithFont:[UIFont systemFontOfSize:SIZEFONT-3] constrainedToSize:CGSizeMake(CGFLOAT_MAX, 30) lineBreakMode:UILineBreakModeWordWrap];
                }
                else
                {
                    sizeToFit = [usrBean.logonId sizeWithFont:[UIFont systemFontOfSize:SIZEFONT-3] constrainedToSize:CGSizeMake(CGFLOAT_MAX, 30) lineBreakMode:UILineBreakModeWordWrap];
                }
                
                CGRect rect = self.userNameValLbl.frame;
                rect.size.width = sizeToFit.width+5;
                self.userNameValLbl.frame = rect;
                self.userNameValLbl.text = IsStrEmpty(usrBean.logonId)?@"":usrBean.logonId;
            }
            else
            {
                CGSize sizeToFit = [usrBean.logonId sizeWithFont:[UIFont systemFontOfSize:SIZEFONT-3] constrainedToSize:CGSizeMake(CGFLOAT_MAX, 30) lineBreakMode:UILineBreakModeWordWrap];
                CGRect rect = self.userNameValLbl.frame;
                rect.size.width = sizeToFit.width+5;
                self.userNameValLbl.frame = rect;
                self.userNameValLbl.text = IsStrEmpty(usrBean.logonId)?@"":usrBean.logonId;
            }

        }
        else if (IsStrEmpty(usrBean.logonId))
        {
            CGSize sizeToFit = [usrBean.nickName sizeWithFont:[UIFont systemFontOfSize:SIZEFONT-3] constrainedToSize:CGSizeMake(CGFLOAT_MAX, 30) lineBreakMode:UILineBreakModeWordWrap];
            CGRect rect = self.userNameValLbl.frame;
            rect.size.width = sizeToFit.width + 5;
            self.userNameValLbl.frame = rect;
            self.userNameValLbl.text = usrBean.nickName;
        }
        
        if (!IsStrEmpty(usrBean.nickName)&&!IsStrEmpty(usrBean.logonId))
        {
            NSString* str1 = [NSString stringWithFormat:@"%@",usrBean.nickName];
            CGSize sizeToFit1;
            if ([usrBean.nickName length] > 8)
            {
                str1 = [str1 substringWithRange:NSMakeRange(0,8)];
                sizeToFit1 = [str1 sizeWithFont:[UIFont systemFontOfSize:SIZEFONT-3] constrainedToSize:CGSizeMake(CGFLOAT_MAX, 30) lineBreakMode:UILineBreakModeWordWrap];
            }
            else
            {
                sizeToFit1 = [str1 sizeWithFont:[UIFont systemFontOfSize:SIZEFONT-3] constrainedToSize:CGSizeMake(CGFLOAT_MAX, 30) lineBreakMode:UILineBreakModeWordWrap];
            }
            CGRect rect = self.userNameValLbl.frame;
            rect.size.width = sizeToFit1.width + 5;
            self.userNameValLbl.frame = rect;
            self.userNameValLbl.text = usrBean.nickName;
        }
        
        if (IsStrEmpty(usrBean.custLevelCN))
        {
            self.dengjiImageView.image = nil;
        }
        else
        {
            if ([usrBean.custLevelCN isEqualToString:L(@"MyEBuy_OrdinaryMember")])
            {
                self.dengjiImageView.image = [UIImage imageNamed:@"myEbuy_pu.png"];
            }
            else if ([usrBean.custLevelCN isEqualToString:L(@"MyEBuy_SilverMember")])
            {
                self.dengjiImageView.image = [UIImage imageNamed:@"myEbuy_ying.png"];
            }
            else if ([usrBean.custLevelCN isEqualToString:L(@"MyEBuy_GoldMember")])
            {
                self.dengjiImageView.image = [UIImage imageNamed:@"myEbuy_jin.png"];
            }
            else if ([usrBean.custLevelCN isEqualToString:L(@"MyEBuy_PlatinumMember")])
            {
                self.dengjiImageView.image = [UIImage imageNamed:@"myEbuy_bo.png"];
            }

            CGRect rect = self.dengjiImageView.frame;
            rect.origin.y = self.userNameValLbl.frame.origin.y+3;
            rect.origin.x = self.userNameValLbl.frame.origin.x + self.userNameValLbl.frame.size.width;
            self.dengjiImageView.frame = rect;
        }
        
        if(![self isEppActive])
        {
            // self.btnAndLblView.YuELab.hidden = YES;没有激活时显示￥0.00
            //        self.btnAndLblView.YuELab.text = @"￥0.00";
            //        self.activeBtn.hidden = NO;
            self.YuELab = L(@"MyEBuy_Unactivated");
            
        }else{
            //self.btnAndLblView.YuELab.hidden = NO;
            //self.activeBtn.hidden = YES;
            
            NSString *_efubao =  [UserCenter defaultCenter].userDiscountInfoDTO.advance;
            
            
            if (_efubao == nil) {
                self.YuELab = @"";
                //self.btnAndLblView.YuELab.text = @"";
            }else{
                //self.btnAndLblView.YuELab.text = [NSString stringWithFormat:@"￥%@",_efubao?_efubao:@""];
                self.YuELab = [NSString stringWithFormat:@"￥%@",_efubao?_efubao:@""];
            }
        }
        
        NSString *_achieve =  [UserCenter defaultCenter].userDiscountInfoDTO.achievement;
        
        if (_achieve == nil)
        {
            self.jifengLab = @"";
            self.jifenValLbl.text = [NSString stringWithFormat:@"%@:0",L(@"CloudDiamond")];
            
        }else{
            //self.btnAndLblView.jifengLab.text = [NSString stringWithFormat:@"%@",_achieve];
            self.jifengLab = [NSString stringWithFormat:@"%@",_achieve];
            if ([self.jifengLab isEqualToString:L(@"MyEBuy_Unactivated")])
            {
                self.jifenValLbl.text = [NSString stringWithFormat:L(@"MyEBuy_Unactivated")];
            }
            else
            {
                self.jifenValLbl.text = [NSString stringWithFormat:@"%@:%@",L(@"CloudDiamond"),self.jifengLab];
            }
            
        }
        
        NSString *quan = [UserCenter defaultCenter].userDiscountInfoDTO.coupon;
        
        if (quan == nil) {
            //self.btnAndLblView.quanLab.text = @"";
            self.quanLab = @"";
        }else{
            //self.btnAndLblView.quanLab.text = [NSString stringWithFormat:@"%@",quan];
            self.quanLab = [NSString stringWithFormat:@"%@%@",quan,L(@"Constant_RMB")];
        }

    }
    
}

#pragma mark -   Notification Action Methods
#pragma mark     各种通知的相应事件

//更新用户优惠信息-我的易购卷
- (void)updateUserDiscountView
{
    
    [self getUserInfoImageView];
    [self.tpTableView reloadData];
    
}

- (void)didGetUserDiscountCompleted:(BOOL)isSuccess errorMsg:(NSString *)errorMsg{
    
    [self updateUserDiscountView];
    
}

//去酒店订单
- (void)goToHotelOrderCenter
{
    if ([[self.navigationController viewControllers] count] > 1)
    {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    
    HotelOrderListViewController *TV = [[HotelOrderListViewController alloc] init];
    
    TV.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:TV animated:YES];
    
    TT_RELEASE_SAFELY(TV);
}

//机票订单
- (void)goToPlaneOrderCenter
{
    if ([[self.navigationController viewControllers] count] > 1)
    {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    
    MyTicketListViewController *TV = [[MyTicketListViewController alloc] init];
    
    TV.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:TV animated:YES];
    
    TT_RELEASE_SAFELY(TV);
}



#pragma mark - Tapped Action Methods
#pragma mark   点击事件的相应处理

- (void)goToEditMyNicknameView:(id)sender
{
    EditNicknameViewController *edit = [[EditNicknameViewController alloc] init];
    
    AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:edit];
    
    [self presentModalViewController:nav animated:YES];
    
}

/*
//设置订单数量提示信息
- (void)setOrderNumberImage:(id)sender
{
    UIButton *btn = (UIButton*)sender;

    if(btn.tag == 1000)
    {
        NSString *numStr =[self getOrderNumByRowIndex:btn.tag];
        
        if([numStr intValue] > 0)
        {
            UIButton *orderNumImgBtn = [[UIButton alloc] init];
            
            orderNumImgBtn.backgroundColor = [UIColor clearColor];
            
            [orderNumImgBtn setBackgroundImage:[UIImage streImageNamed:@"OrderNum.png"] forState:UIControlStateNormal];
            
            orderNumImgBtn.frame = CGRectMake(79-16, -8, 13, 13);
            
            int length = [numStr length];
            
            CGSize strSize = [@"9" sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(64,13)];
            
            CGRect rect = orderNumImgBtn.frame;
            
            rect.size.width = strSize.width * (length + 2)>13?strSize.width*(length+2):13;
            rect.size.height = strSize.height> 13 ?strSize.height:13;
            rect.origin.x = 79-13 - (double)(rect.size.width/2);
            
            rect.origin.y = 7;
            
            orderNumImgBtn.frame = rect;
            
            [orderNumImgBtn setTitle:[NSString stringWithFormat:@"%@",numStr] forState:UIControlStateNormal];
            
            [orderNumImgBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
            
            [btn addSubview:orderNumImgBtn];

        }
        else
        {
            
        }
        
       
    }
    else
    {
        
    }
}


//订单数量请求
- (void)sendOrderHttpRequest
{
//    [self displayOverFlowActivityView];
    
    [self.orderService beginSendOrderHttpRequest];
    
}

#pragma mark --- 订单数量
//获取各类订单数量后刷新
- (void)orderCenterHttpRequestCompletedWithResult:(OrderStatInfo *)orderStatInfo
                                       isSucccess:(BOOL)isSucess
                                        errorCode:(NSString *)errorCode
{
//    [self removeOverFlowActivityView];
    
    if (isSucess == YES) {
        
        self.orderStatInfo = orderStatInfo;
        _isOrderNumLoaded = YES;
    }
    else
    {
        [self presentSheet:errorCode?errorCode:@"获取订单信息失败"];
    }
    
    [self.tpTableView reloadData];
    
    [self setOrderNumberImage:self.waitePayBtn];
    
}

//设置每行的订单类型
- (NSString*)getOrderNumByRowIndex:(NSInteger)index
{
    if(!_orderStatInfo){
		
		return @"0";
	}

	if(index==1000){
		
		return self.orderStatInfo.waitingNum;
	}

	return @"";
}
- (OrderCenterService*)orderService
{
    if(!_orderService)
    {
        _orderService = [[OrderCenterService alloc] init];
        
        _orderService.delegate = self;
    }
    
    return _orderService;
}
*/
#pragma mark - Delegate Methods
#pragma mark   代理对应的方法



//我的咨询
-(void)myConsultation{
    
//    ConsultationViewController *consult = [[ConsultationViewController alloc] init];
//    consult.ismyconsult=YES;
//    [self.navigationController pushViewController:consult animated:YES];

}

//物流查询
- (void)gotoServiceTrack
{
    ServiceTrackListViewController *nextViewController = [[ServiceTrackListViewController alloc] init];
    [self.navigationController pushViewController:nextViewController animated:YES];
    TT_RELEASE_SAFELY(nextViewController);
}

//激活易付宝
//- (void)gotoActiveEfubao
//{
//    NSString *logonName = [UserCenter defaultCenter].userInfoDTO.logonId;
//    
//    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    
//    if ([emailTest evaluateWithObject:logonName]) {
//        [self presentSheet:@"邮箱账号请至网站进行激活"];
//        
//        return;
//    }
//    
////    UserCenter *defaultCenter=[UserCenter defaultCenter];
//    switch (eLoginByEmailUnActive) { //defaultCenter.efubaoStatus
//            
//        case eLoginByPhoneUnBound:{
//            //手机登录、易付宝激活
//            EfubaoUnboundPhoneViewController *efubaoController = [[EfubaoUnboundPhoneViewController alloc] init];
//            
//            [self.navigationController pushViewController:efubaoController animated:YES];
//            
//            TT_RELEASE_SAFELY(efubaoController);
//
//        }
//            break;
//
//        case eLoginByPhoneActive:{
//            
//            //modify by liukun, user switch judge if need go to web epp
//            if (![SNSwitch isOpenWebEppMyEpp])
//            {
//                [self checkLoginWithLoginedBlock:^{
//                    SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeEfubao attributes:nil];
//                    [self.navigationController pushViewController:vc animated:YES];
//                } loginCancelBlock:nil];
//                
//            }else{
//                MYEfubaoViewController *efubaoController = [[MYEfubaoViewController alloc] init];
//                
//                [self.navigationController pushViewController:efubaoController animated:YES];
//                
//                TT_RELEASE_SAFELY(efubaoController);
//            }
//            
//        }
//
//            break;
//            
//        case eLoginByPhoneUnActive:{
//            
//            
//            EfubaoUnActiveViewController *efubaoController = [[EfubaoUnActiveViewController alloc] init];
//            
//            [self.navigationController pushViewController:efubaoController animated:YES];
//            
//            TT_RELEASE_SAFELY(efubaoController);
//            
//        }
//            
//            break;
//
//        case eLoginByEmailUnBound:{
//            
//            EfubaoUnBoundEmailViewController *efubaoController = [[EfubaoUnBoundEmailViewController alloc] init];
//            
//            [self.navigationController pushViewController:efubaoController animated:YES];
//            
//            TT_RELEASE_SAFELY(efubaoController);
//        }
//            break;
//        case eLoginByEmailPhoneUnBound:{
//            EfubaoUnActiveViewController *efubaoController = [[EfubaoUnActiveViewController alloc] init];
//            
//            [self.navigationController pushViewController:efubaoController animated:YES];
//            
//            TT_RELEASE_SAFELY(efubaoController);
//        }
//            break;
//
//        case eLoginByEmailUnActive:{
//            
//            EfubaoUnActiveViewController *efubaoController = [[EfubaoUnActiveViewController alloc] init];
//            
//            [self.navigationController pushViewController:efubaoController animated:YES];
//            
//            TT_RELEASE_SAFELY(efubaoController);
//        }
//            break;
//
//        case eLoginByEmailActive:{
//
//            //modify by liukun, user switch judge if need go to web epp
//            if ([SNSwitch isOpenWebEppMyEpp])
//            {
//                [self checkLoginWithLoginedBlock:^{
//                    SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeEfubao attributes:nil];
//                    [self.navigationController pushViewController:vc animated:YES];
//                } loginCancelBlock:nil];
//                
//            }else{
//                MYEfubaoViewController *efubaoController = [[MYEfubaoViewController alloc] init];
//
//                [self.navigationController pushViewController:efubaoController animated:YES];
//                
//                TT_RELEASE_SAFELY(efubaoController);
//            }
//            
//        }
//            break;
//            
//        default:{
//            
//        }
//            break;
//    }
//
//}



//我的云钻
- (void)gotoIntegral{
    
}




//电子会员卡
- (void)gotoMyCard
{

}

//我的商旅
- (void)gotoTicketList{
    if ([[self.navigationController viewControllers] count] > 1)
    {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    BussinessTravelOrderCenterViewController *TV = [[BussinessTravelOrderCenterViewController alloc] init];
    
    [self.navigationController pushViewController:TV animated:YES];
    
    TT_RELEASE_SAFELY(TV);
}

//查看奖励－邀请好友奖励
-(void)gotoinviteFriend{
    

}

//地址管理
- (void)gotoAddressInfo{
    
    if ([[self.navigationController viewControllers] count] > 1)
    {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    AddressInfoListViewController *vc = [AddressInfoListViewController controller];
//    vc.isFromAddressInfo = FromEbuy;
    vc.cellType = FromEbuy;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//我的彩票
- (void)gotoLotteryTicket
{
    isBackFromLottery = YES;
    
    LotteryDealsViewController *listCtrl = [[LotteryDealsViewController alloc]init];
    
    listCtrl.isFormLotteryHall = NO;
    
    listCtrl.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:listCtrl animated:YES];
    
}

- (void)goToLottertOrderCenter
{
    
    LotteryDealsViewController *listCtrl = [[LotteryDealsViewController alloc]init];
    
    listCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:listCtrl animated:NO];
    
    
}

//我的互联
-(void)goToMycount{

    if ([SNSwitch isShowMyHulianAccount])
    {
        if ([UserCenter defaultCenter].isLogined)
        {
            SNWebViewController *v = [[SNWebViewController alloc] initWithRequestUrl:[SNSwitch getHulianUrl]];
            [self.navigationController pushViewController:v animated:YES];
        }
        else{
            
            SNWebViewController *v = [[SNWebViewController alloc] initWithRequestUrl:[SNSwitch getHulianUrl]];
            
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            loginVC.loginDelegate = self;
            loginVC.loginDidOkSelector = @selector(loginSel);
            loginVC.nextController = v;
            loginVC.nextNavigationController = self.navigationController;
            loginVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            AuthManagerNavViewController *navController = [[AuthManagerNavViewController alloc] initWithRootViewController:loginVC];
            [self presentModalViewController:navController animated:YES];
        }
    }
}

- (void)loginSel
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            return 120;
        }
    }
    return 40;
}

/*@"New_DaiZF_Up",@"我的易付宝",
 @"New_MyYFB_Up",@"我的云钻",
 @"New_MyEgq_Up",@"我的易购券",
 @"New_MyCard_UP",@"电子会员卡",*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {//头像
            static NSString *cellIndentifier = @"headerIndentifier";
            
            SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            
            if (nil == cell)
            {
                cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor cellBackViewColor];
            }
            if ([UserCenter defaultCenter].isLogined)
            {
                UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button-youla.png"]];
                cell.accessoryView = arrow;
            }
            else
            {
                cell.accessoryView = nil;
            }
            [cell.contentView addSubview:[self tableHeaderView]];
            [cell.contentView addSubview:self.userImageBtn];
            return cell;
        }
        else if (indexPath.row == 1)
        {
            static NSString *cellIndentifier = @"otherIndentifier";
            
            SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            
            if (nil == cell)
            {
                cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line.png"]];
                line.frame = CGRectMake(0, cell.frame.size.height-0.5, cell.frame.size.width, 0.5);
                [cell.contentView addSubview:line];
                cell.backgroundColor = [UIColor clearColor];
            }
            [cell.contentView addSubview:[self functionOther]];
            return cell;

        }
    }
    return [UITableViewCell new];
}



- (UIView *)tableHeaderView
{
    if (!_tableHeaderView)
    {
        _tableHeaderView = [[UIView alloc] init];
        _tableHeaderView.userInteractionEnabled = YES;
        _tableHeaderView.backgroundColor = [UIColor clearColor];
        
        _tableHeaderView.frame = CGRectMake(0, 0, 320, 120);
        
        //UIButton *settingBtn = [self createSettingBtn];
        
        [_tableHeaderView addSubview:self.userInfoImageView];
        
        //[_tableHeaderView addSubview:settingBtn] ;
        
        [_tableHeaderView addSubview:self.userNameValLbl];
        
        [_tableHeaderView addSubview:self.jifenValLbl];
        
        [_tableHeaderView addSubview:self.dengjiImageView];
        
        [_tableHeaderView addSubview:self.userImageView];
        
        //[_tableHeaderView addSubview:self.changeUserImageBtn];
        
        self.userInfoImageView.image = [UIImage imageNamed:@"banner-bg-ios.png"];
        
//        NSURL *url = [SNSwitch myEbuyUrl];
//        if (!url) {
//            self.userInfoImageView.image = [UIImage imageNamed:@"ebuyhead.png"];
//            
//        }else{
//            self.userInfoImageView.imageURL = url;
//        }

    }
    
    return _tableHeaderView;
}

- (CALayer*)arrowImage
{
    if(_arrowImage == nil)
    {
        _arrowImage = [[CALayer alloc] init];
    }
    return _arrowImage;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section < 2)
    {
        return 36;
    }
    else if (section == 2||section == 3)
    {
        return 0.01;
    }
    return 5;
}
- (UIView *)functionOther
{
    CGFloat height = 49.5;
    if (IOS7_OR_LATER)
    {
        height = 48.5;
    }

    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, height)];
    
    [v addSubview:self.waitePayBtn];
    
    [v addSubview:self.waiteReceiveBtn];
    
    [v addSubview:self.returnBtn];
    
    [self.payNumber addSubview:self.payNumberLabel];
    
    [self.waiteReceiveBtn addSubview:self.ReceiptNumber];
    
    [self.ReceiptNumber addSubview:self.receiptNumberLabel];
    
    
    [self.returnNumber addSubview:self.returnNumberLabel];
    
    if([self isLogin])
    {
        if (IsStrEmpty(self.orderNumber.waitDeliveryCounts) || [self.orderNumber.waitDeliveryCounts isEqualToString:@"0"]) {
            self.ReceiptNumber.hidden = YES;
            self.receiptNumberLabel.hidden = YES;
        }
        else
        {
            self.ReceiptNumber.hidden = NO;
            self.receiptNumberLabel.hidden = NO;
            self.receiptNumberLabel.text = self.orderNumber.waitDeliveryCounts;
        }
        if (IsStrEmpty(self.orderNumber.waitPayCounts) || [self.orderNumber.waitPayCounts isEqualToString:@"0"]) {
            self.payNumber.hidden = YES;
            self.payNumberLabel.hidden = YES;
        }
        else
        {
            self.payNumber.hidden = NO;
            self.payNumberLabel.hidden = NO;
            self.payNumberLabel.text = self.orderNumber.waitPayCounts;
        }
        
        
        if (IsStrEmpty(self.orderNumber.ordersInReturnCounts)||[self.orderNumber.ordersInReturnCounts isEqualToString:@"0"])
        {
            self.returnNumber.hidden = YES;
            self.returnNumberLabel.hidden = YES;
        }
        else
        {
            self.returnNumber.hidden = NO;
            self.returnNumberLabel.hidden = NO;
            self.returnNumberLabel.text = self.orderNumber.ordersInReturnCounts;
        }
    }
    else
    {
        self.ReceiptNumber.hidden = YES;
        self.receiptNumberLabel.hidden = YES;
        self.payNumber.hidden = YES;
        self.payNumberLabel.hidden = YES;
        self.returnNumber.hidden = YES;
        self.returnNumberLabel.hidden = YES;
        
    }
    return v;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0)
    {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
        v.backgroundColor = [UIColor clearColor];
        
        return v;
    }
    else
    {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
#pragma --
#pragma mark -- cardServiceDelegate
//头像回调函数
-(void)getCardInfoCompletedWithResult:(BOOL)isSuccess infoDto:(CardDTO *)dto errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (isSuccess)
    {
        if (KPerformance)
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
        self.isLoadUserImage = NO;
        self.cardDto = dto;
        NSString *urlStr = [NSString stringWithFormat:@"%@?version=%@",WBHeadUrlString(dto.sysHeadPicFlag, dto.sysHeadPicNum, CGSizeMake(640, 640),dto.custNum),dto.sysHeadPicNum];
        if (![urlStr isEqualToString:@""]) {
            NSURL *url = [NSURL URLWithString:urlStr];
            if ([url.scheme hasPrefix:@"http"]) {
                
                UIImageView *__weak i_portraitView = self.userImageView1;
                
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    NSData *imageData    = [NSData dataWithContentsOfURL:url];
                    UIImage *portraitImg = [UIImage imageWithData:imageData];
                    if (nil != portraitImg) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            i_portraitView.image = portraitImg;
                        });
                    }
                });
            }
        }
    }
}
    
#pragma --
#pragma mark -- OrdersNumberServiceDelegate
//待支付和待收货返回、退货中的数据
//SNiPhoneAppGetTabCountView?flag=MB_C&storeId=10052&catalogId=10051
- (void)getOrderNumberCompletedWithResult:(OrdersNumberDTO *)dto
                                 errorMsg:(NSString *)errorMsg
{
    if ([self isLogin])
    {
        if ([dto.isSuccess isEqualToString:@"1"])
        {
            if (KPerformance)
            {
                if ([PerformanceStatistics sharePerformanceStatistics].arrayData.count > 0)
                {
                    [PerformanceStatistics sharePerformanceStatistics].countStatus += 1;
                    if ([PerformanceStatistics sharePerformanceStatistics].countStatus == [PerformanceStatistics sharePerformanceStatistics].arrayData.count)
                    {
                        PerformanceStatisticsData* temp = [[PerformanceStatistics sharePerformanceStatistics].arrayData safeObjectAtIndex:1];
                        temp.endTime = [NSDate date];
                        [[PerformanceStatistics sharePerformanceStatistics]sendData:temp];
                        [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];
                    }
                }
                
            }
            self.orderNumber = dto;
            if (IsStrEmpty(self.orderNumber.waitDeliveryCounts) || [self.orderNumber.waitDeliveryCounts isEqualToString:@"0"])
            {
                self.ReceiptNumber.hidden = YES;
                self.receiptNumberLabel.hidden = YES;
            }
            else
            {
                self.ReceiptNumber.hidden = NO;
                self.receiptNumberLabel.hidden = NO;
                self.receiptNumberLabel.text = self.orderNumber.waitDeliveryCounts;
            }
            if (IsStrEmpty(self.orderNumber.waitPayCounts) || [self.orderNumber.waitPayCounts isEqualToString:@"0"])
            {
                self.payNumber.hidden = YES;
                self.payNumberLabel.hidden = YES;
            }
            else
            {
                self.payNumber.hidden = NO;
                self.payNumberLabel.hidden = NO;
                self.payNumberLabel.text = self.orderNumber.waitPayCounts;
            }
            if (IsStrEmpty(self.orderNumber.ordersInReturnCounts) || [self.orderNumber.ordersInReturnCounts isEqualToString:@"0"])
            {
                self.returnNumberLabel.hidden = YES;
                self.returnNumber.hidden = YES;
            }
            else
            {
                self.returnNumberLabel.hidden = NO;
                self.returnNumber.hidden = NO;
                self.returnNumberLabel.text = self.orderNumber.ordersInReturnCounts;
            }
        }

    }
    [self.tpTableView reloadData];
}

#pragma mark - CardServiceDelegate
//保存头像返回提示
- (void)savePersonDetailComplete:(BOOL)isSuccess ErrorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    if (isSuccess)
    {
        self.userImageView1.image = self.userImage;
        self.isLoadUserImage = NO;
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:L(@"AlertTips")
                                                         message:L(@"AlertSaveSuccess")
                                                        delegate:self
                                               cancelButtonTitle:L(@"Ok")
                                               otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else
    {
        [self presentSheet:errorMsg posY:60];
    }
}

#pragma mark -
#pragma mark Properties Initialization Methods

- (NewEvalutionService *)evalutionNumberService
{
    if (!_evalutionNumberService) {
        
        _evalutionNumberService = [[NewEvalutionService alloc] init];
        
        _evalutionNumberService.delegate = self;
        
    }
    return _evalutionNumberService;
    
}

- (OrdersNumberService *)orderNumberService
{
    if (!_orderNumberService) {
        
        _orderNumberService = [[OrdersNumberService alloc] init];
        
        _orderNumberService.delegate = self;
        
    }
    return _orderNumberService;

}

-(UserDiscountService *)userDiscountService{
    
    if (!_userDiscountService) {
        
        _userDiscountService = [[UserDiscountService alloc] init];
        
        _userDiscountService.delegate = self;
        
    }
    return _userDiscountService;
}


//您好！欢迎进入我的易购提示语
- (UILabel *)headLbl{
    if (_headLbl == nil) {
        _headLbl = [[UILabel alloc]initWithFrame:CGRectMake(23, 6.5, 290, 20)];
        _headLbl.backgroundColor = [UIColor clearColor];
        _headLbl.text = L(@"MyEBuy_WelcomeToMyEBuy");
        _headLbl.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        _headLbl.font = [UIFont systemFontOfSize:18.0];
    }
    return _headLbl;
}

- (UserInfoView *)userInfoView
{
    if (!_userInfoView)
    {
        _userInfoView = [[UserInfoView alloc] initWithFrame:CGRectMake(0, 10, 320, 70)];
    }
    
    [self setUserInfo];
    
    return _userInfoView;
}

- (void)setUserInfo
{
    NSString *_coupon =  [UserCenter defaultCenter].userDiscountInfoDTO.coupon;
    NSString *_advance =  [UserCenter defaultCenter].userDiscountInfoDTO.advance;
    
    [_userInfoView setItem:[UserCenter defaultCenter].userInfoDTO withCoupon: _coupon andAdvance:_advance];
    
    if (_userInfoView.myNickNameValBtn.superview) {
        
        [_userInfoView.myNickNameValBtn addTarget:self action:@selector(goToEditMyNicknameView:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

-(UILabel *)myIntegralLbl{
    if (_myIntegralLbl == nil) {
        _myIntegralLbl = [[UILabel alloc]initWithFrame:CGRectMake(110, 55, 61, 30)];
        _myIntegralLbl.backgroundColor = [UIColor clearColor];
        _myIntegralLbl.shadowColor = [UIColor darkGrayColor];
        _myIntegralLbl.shadowOffset = CGSizeMake(0.5, 0.5);
        _myIntegralLbl.text = [NSString stringWithFormat:@"%@:",L(@"CloudDiamond")];
        _myIntegralLbl.font = [UIFont systemFontOfSize:15.0];
        _myIntegralLbl.textColor = [UIColor whiteColor];
        _myIntegralLbl.hidden = YES;
    }
    return _myIntegralLbl;
}

-(UILabel *)myIntegralValLbl{
    if (_myIntegralValLbl == nil) {
        _myIntegralValLbl = [[UILabel alloc]initWithFrame:CGRectMake(self.myIntegralLbl.right, 55, 175, 30)];
        _myIntegralValLbl.backgroundColor = [UIColor clearColor];
        _myIntegralValLbl.shadowColor = [UIColor darkGrayColor];
        _myIntegralValLbl.shadowOffset = CGSizeMake(0.5, 0.5);
        _myIntegralValLbl.text = @"--";
        _myIntegralValLbl.font = [UIFont systemFontOfSize:15.0];
        _myIntegralValLbl.textColor = [UIColor whiteColor];
        _myIntegralValLbl.hidden = YES;
    }
    return _myIntegralValLbl;
}
-(UILabel *)advanceLbl{
    if (_advanceLbl == nil) {
        _advanceLbl = [[UILabel alloc]initWithFrame:CGRectMake(110, 36, 61, 30)];
        _advanceLbl.backgroundColor = [UIColor clearColor];
        _advanceLbl.shadowColor = [UIColor darkGrayColor];
        _advanceLbl.shadowOffset = CGSizeMake(0.5, 0.5);
        _advanceLbl.text = [NSString stringWithFormat:@"%@:",L(@"MyEBuy_Efubao")];
        _advanceLbl.font = [UIFont systemFontOfSize:15.0];
        _advanceLbl.textColor = [UIColor whiteColor];
        _advanceLbl.hidden = YES;
    }
    return _advanceLbl;
}

-(UILabel *)advanceValLbl{
    if (_advanceValLbl == nil) {
        _advanceValLbl = [[UILabel alloc]initWithFrame:CGRectMake(self.advanceLbl.right, 36, 175, 30)];
        _advanceValLbl.backgroundColor = [UIColor clearColor];
        _advanceValLbl.shadowColor = [UIColor darkGrayColor];
        _advanceValLbl.shadowOffset = CGSizeMake(0.5, 0.5);
        _advanceValLbl.font = [UIFont systemFontOfSize:15.0];
        _advanceValLbl.textColor = [UIColor whiteColor];
        _advanceValLbl.hidden = YES;
    }
    return _advanceValLbl;
}
-(UILabel *)userNameLbl{
    if (_userNameLbl == nil) {
        _userNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(43, 5, 61, 30)];
        _userNameLbl.backgroundColor = [UIColor clearColor];
        _userNameLbl.shadowColor = [UIColor darkGrayColor];
        _userNameLbl.shadowOffset = CGSizeMake(0.5, 0.5);
        _userNameLbl.text = L(@"MyEBuy_Account2");
        _userNameLbl.textColor = [UIColor whiteColor];
        _userNameLbl.font = [UIFont systemFontOfSize:15.0];
    }
    return _userNameLbl;
}

//会员等级图片
-(UIImageView*)dengjiImageView
{
    if (!_dengjiImageView)
    {
        _dengjiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,24, 24)];
        _dengjiImageView.backgroundColor = [UIColor clearColor];
        _dengjiImageView.userInteractionEnabled = YES;
    }
    return _dengjiImageView;
}

//云钻
-(void)jifenValClick:(id)sender
{
    [self gotoIntegral];
}

//云钻
//-(UIButton*)jifenValBt
//{
//    if (!_jifenValBt)
//    {
//        _jifenValBt = [[UIButton alloc]initWithFrame:CGRectMake(80, 55, 175, 30)];
//        _jifenValBt.backgroundColor = [UIColor clearColor];
//        [_jifenValBt addTarget:self action:@selector(jifenValClick:) forControlEvents:UIControlEventTouchUpInside];
//        [_jifenValBt addSubview:self.jifenValLbl];
//    }
//    return _jifenValBt;
//}

//云钻
-(UILabel *)jifenValLbl
{
    if (!_jifenValLbl)
    {
        
        _jifenValLbl = [[UILabel alloc]initWithFrame:CGRectMake(90, 55+15-10.5, 175, 30)];
        _jifenValLbl.backgroundColor = [UIColor clearColor];
        _jifenValLbl.shadowColor = [UIColor darkGrayColor];
        _jifenValLbl.shadowOffset = CGSizeMake(0.5, 0.5);
        _jifenValLbl.userInteractionEnabled = YES;
        _jifenValLbl.text = [NSString stringWithFormat:@"%@:",L(@"CloudDiamond")];
        _jifenValLbl.font = [UIFont systemFontOfSize:SIZEFONT-5];
        _jifenValLbl.textColor = [UIColor whiteColor];
        _jifenValLbl.textAlignment = UITextAlignmentLeft;
    }
    return _jifenValLbl;
}

//用户名
-(UILabel *)userNameValLbl{
    if (_userNameValLbl == nil) {
        _userNameValLbl = [[UILabel alloc]initWithFrame:CGRectMake(90, 20+25-10.5, 175, 30)];
        _userNameValLbl.backgroundColor = [UIColor clearColor];
        _userNameValLbl.userInteractionEnabled = YES;
        _userNameValLbl.shadowColor = [UIColor darkGrayColor];
        _userNameValLbl.shadowOffset = CGSizeMake(0.5, 0.5);
        _userNameValLbl.text = @"--";
        _userNameValLbl.font = [UIFont systemFontOfSize:SIZEFONT-3];
        _userNameValLbl.textColor = [UIColor whiteColor];
        _userNameValLbl.textAlignment = UITextAlignmentLeft;
    }
    return _userNameValLbl;
}

////改变头像按钮
//- (UIButton *)changeUserImageBtn
//{
//    if (_changeUserImageBtn == nil) {
//        
//        CGRect frame = CGRectMake(15, 8, 64, 64);//CGRectMake(50, 50, 60, 60);
//        _changeUserImageBtn = [[UIButton alloc] init];
//        _changeUserImageBtn.backgroundColor = [UIColor clearColor];
//        _changeUserImageBtn.frame = frame;
//        [_changeUserImageBtn addTarget:self action:@selector(changeUserImage:) forControlEvents:UIControlEventTouchUpInside];
//        
//    }
//    return _changeUserImageBtn;
//}

//头像图片
- (UIImageView*)userImageView1
{
    if (!_userImageView1)
    {
        _userImageView1 = [[UIImageView alloc] init];
        _userImageView1.userInteractionEnabled = YES;
        _userImageView1.backgroundColor = [UIColor clearColor];
        _userImageView1.frame = CGRectMake(0, 0, 64, 64);
        [_userImageView1 setImage:[UIImage imageNamed:@"New_UserPhoto.png"]];
        [_userImageView1.layer setCornerRadius:32.0];
        
        _userImageView1.layer.borderWidth = 0.0;
        
        _userImageView1.layer.borderColor = [UIColor clearColor].CGColor;
        [_userImageView1.layer setMasksToBounds:YES];

    }
    return _userImageView1;
}
- (UIImageView*)userImageView
{
    
    if(_userImageView == nil)
    {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.userInteractionEnabled = YES;
        _userImageView.backgroundColor = [UIColor clearColor];
        _userImageView.frame = CGRectMake(15, 20+8, 64, 64);
        //[_userImageView setImage:[UIImage imageNamed:@"New_UserPhoto.png"]];
        [_userImageView setImage:[UIImage imageNamed:@"touxiang.png"]];
        [_userImageView.layer setCornerRadius:32.0];
        _userImageView.layer.shadowColor=[UIColor clearColor].CGColor;
        _userImageView.layer.shadowOffset=CGSizeMake(2, 1);
        _userImageView.layer.shadowOpacity=1;
        _userImageView.layer.borderWidth = 2.0;
        
        _userImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        //[_userImageView.layer setMasksToBounds:YES];
        [_userImageView addSubview:self.userImageView1];
        
    }
    
    return _userImageView;
}

-(void)userImageClick:(UIButton*)sender
{//进入会员资料
    if ([self isLogin])
    {
       
    }
    
}

-(UIButton*)userImageBtn
{//进入会员资料
    if (!_userImageBtn)
    {
        _userImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,120)];
        _userImageBtn.backgroundColor = [UIColor clearColor];
        [_userImageBtn addTarget:self action:@selector(userImageClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userImageBtn;
}
//背景图片
- (EGOImageView *)userInfoImageView
{
    if(_userInfoImageView == nil)
    {
        _userInfoImageView = [[EGOImageView alloc] init];
        _userInfoImageView.userInteractionEnabled = YES;
        _userInfoImageView.contentMode = UIViewContentModeScaleToFill;
        _userInfoImageView.frame = CGRectMake(0, 0, self.view.frame.size.width,120);
        _userInfoImageView.image =  [UIImage imageNamed:@"ebuyhead.png"];
        //_userInfoImageView.delegate = self;
        _userInfoImageView.backgroundColor = [UIColor clearColor];
    }
    
    return _userInfoImageView;
}

-(CardService*)cardService
{
    if (nil == _cardService)
    {
        _cardService = [[CardService alloc] init];
        
        _cardService.delegate = self;
    }
    
    return _cardService;
}

- (CardWbSerVice *)service
{
    if (!_service)
    {
        _service = [[CardWbSerVice alloc] init];
        
        _service.delegate = self;
    }
    
    return _service;
}

- (void)imageViewFailedToLoadImage:(EGOImageView *)imageView error:(NSError *)error
{
    //    imageView.placeholderImage = [UIImage imageNamed:@"New_UserInfo_Background.png"];
    imageView.image = [UIImage imageNamed:@"ebuyhead.png"];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(InvitationService *)invita
{
    if (!_invita) {
        _invita=[[InvitationService alloc]init];
        _invita.delegate=self;
    }
    return _invita;
}

- (void) GetRedPackServiceEntryComplete:(GetRedPackEntryDTO *)service isSuccess:(BOOL) isSuccess{
//    [self removeOverFlowActivityView];
//    isshowgetredpack = NO;
//    if (isSuccess) {
//        if ([service.canGetRedPack isEqualToString:@"1"]) {
//            _activerule=service.redPackRule;
//            isshowgetredpack = YES;
//        }
//    }
//    if ([SNSwitch ISwdyglqxs]) {
//        if (isshowgetredpack) {
//           iswdy = (int)(([SNSwitch ISwdygyqxs]!=nil&&isshowgetredpack)?1:0)+(int)([SNSwitch ISwdyglqxs]?1:0);
//        }
//    }
//    [self.tpTableView reloadData];
}


// xzoscar 2014-07-24 add
// Desc : 退出登录后 要求进入登录界面
- (void)delegate_moreViewController_logout { // 退出登录
    [self loginBtnAction];
    SuNingSellDao* dao = [[SuNingSellDao alloc] init];
    [dao deleteAllSuNingSellDAOFromDB];
}

@end
