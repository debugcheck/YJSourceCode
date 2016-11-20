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

    
    

}

@end
