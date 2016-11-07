//
//  MoreViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "MoreViewController.h"
#import "PlaySoundAndShacking.h"

#import "LoginViewController.h"
#import "LogOutCommand.h"
#import "UITableViewCell+BgView.h"
#import "EbuyRuleViewController.h"
#import "CollectDeviceTokenCommand.h"
#define kAppId @"424598114"


@interface MoreViewController()
{
    dispatch_queue_t  _queue;
    
    MessageFilterSelecter  selecteType;
}

@property (nonatomic,strong) NSMutableArray              *cellsArray;


@property (nonatomic,strong) NSMutableArray              *selectedCellArray;


@end

/*********************************************************************/

@implementation MoreViewController



- (void)dealloc {
    TT_RELEASE_SAFELY(_moreView);
    TT_RELEASE_SAFELY(_selectedCellArray);
    
    _moreView.owner = nil;
    _moreView.groupTableView.delegate = nil;
    _moreView.groupTableView.dataSource = nil;
    
    if (_queue) {
//        dispatch_release(_queue); //YJ 4.23
        _queue = 0x00;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init {
    self = [super init];
    if (self) {
        self.title = L(@"Settings");
        
        self.hidesBottomBarWhenPushed = YES;
        
        self.pageTitle = L(@"member_myEbuy_setting");

        _queue = dispatch_queue_create([[NSString stringWithFormat:@"suning.%@", self] UTF8String], NULL);
        
        quailtyType = [[Config currentConfig].imageQuailty intValue];
        
       // self.navigationController.navigationBar
    }
    return self;
}

#pragma mark -
#pragma mark view life cycle

- (void)loadView
{
    [super loadView];
    
    
    _moreView = [[MoreView alloc] initWithOwner:self];
    _moreView.owner = self;
    _moreView.backgroundColor = [UIColor uiviewBackGroundColor];
    self.view = _moreView;
    _moreView.groupTableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:!self.hidesBottomBarWhenPushed];


    _moreView.groupTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    _moreView.groupTableView.tag = 0;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.moreView.groupTableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (![_moreView.addressPickerView isLoadProvincesOk]) {
        [_moreView.addressPickerView reloadAddressData];
    }
}


- (ChooseShareWayView *)chooseShareWayView
{
    if (!_chooseShareWayView) {
        _chooseShareWayView = [[ChooseShareWayView alloc] init];
        _chooseShareWayView.delegate = self;
    }
    return _chooseShareWayView;
}

#pragma mark -

-(void)gotoRuler{
    
    EbuyRuleViewController *v = [[EbuyRuleViewController alloc] init];
    
    [self.navigationController pushViewController:v animated:YES];
}

- (NSString *)getShareContent
{
    
    NSString *content=[NSString stringWithFormat:@"%@",L(@"More_Share_Content")];
    return content;
}

- (void)soundControl:(id)sender
{
    UISwitch *musicSwitch = (UISwitch *)sender;
    
	[Config currentConfig].isSoundOn = [NSNumber numberWithBool:musicSwitch.on];
    
    if (musicSwitch.on)
    {
        [PlaySoundAndShacking playSound];
    }
}

#pragma mark - Tapped Action Methods
- (void)alertView:(BBAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        switch ([_selectedCellArray count]) {
            case 0:
            {
                [Config currentConfig].messageFilter = [NSNumber numberWithInt:MessageFilterSelectNone];
            }
                break;
            case 1:
            {
                int type = [_cellsArray indexOfObject:[_selectedCellArray objectAtIndex:0]];
                
                if (type == 0)
                {
                    selecteType = MessageFilterSelectAll;
                    
                }else if (type == 1)
                {
                    selecteType = MessageFilterSelectSalesPromotion;
                    
                }else if (type == 2)
                {
                    selecteType = MessageFilterSelectPersonality;
                }else{
                    
                    selecteType = MessageFilterSelectLogistic;
                }
                
                [Config currentConfig].messageFilter = [NSNumber numberWithInt:selecteType];
                
                break;
            }
            case 2:
            {
                int type = [_cellsArray indexOfObject:[_selectedCellArray objectAtIndex:0]];
                
                int type1 = [_cellsArray indexOfObject:[_selectedCellArray objectAtIndex:1]];
                
                if ((type == 1&&type1 == 2)||(type == 2&&type1 == 1))
                {
                    selecteType = MessageFilterSelectSalesPromotionAndPersonality;
                    
                }else if ((type == 1&&type1 == 3)||(type == 3&&type1 == 1))
                {
                    selecteType = MessageFilterSelectSalesPromotionAndLogistic;
                    
                }else
                {
                    selecteType = MessageFilterSelectPersonalityAndLogistic;
                }
                
                [Config currentConfig].messageFilter = [NSNumber numberWithInt:selecteType];
                break;
            }
            default:
                [Config currentConfig].messageFilter = [NSNumber numberWithInt:MessageFilterSelectAll];
                break;
        }
        
        CollectDeviceTokenCommand *command = [CollectDeviceTokenCommand command];
        
        [command execute];
    }
    
    NSLog(@"acceptType is %@",[Config currentConfig].messageFilter);
    
    self.cellsArray = nil;
    
    self.selectedCellArray = nil;
    
    
}


@end
