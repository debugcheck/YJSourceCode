//
//  HomePageViewController.h
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "PageRefreshTableViewController.h"
#import "EightBannerView244.h"
#import "ShopRecommend244.h"
#import "BrandRecommend244.h"
#import "LianBanZhuanTiViewController.h"
#import "HomePageService244.h"
#import "ZhuanTiService244.h"
#import "HomeFloorTableViewCell.h"
#import "NewHomeTopView.h"
#import "InvitationService.h"
#import "SearchService.h"
#import "HomeSearchController.h"
#import "SearchListViewController.h"
#import "NewSearchViewController.h"
#import "ShopSearchListViewController.h"
#import "FilterRootViewController.h"
#import "FilterNavigationController.h"
#import "JASidePanelController.h"
#import "Floor12View.h"
#import "SecondPageViewController.h"
#import "SNReaderController.h"
#import "SFHFKeychainUtils.h"
#import "GuessYouLikeService.h"
#import "GuessYouLikeCell.h"
#import "QuickRegistFloatingView.h"
#import "NewRegisterViewController.h"


@interface HomePageViewController : PageRefreshTableViewController <EightBannerViewDelegate, HomePageService244Delegate, ZhuanTiServiceDelegate, HomeFloorTableViewCellDelegate, InvitationServiceDelegate, SearchServiceDelegate, HomeSearchControllerDelegate,GuessYouLikeServiceDelegate,GuessYouLikeCellDelegate> {
    
    //存放楼层数据
    NSMutableArray *floorDataArray;
    
    //是否加载底部推荐标签
    BOOL                willLoadRecommendLabel;
    
@private
    NewHomeTopView *_homeView;
    
    QuickRegistFloatingView     *quickRegistView;
}



- (id)init;
@end
