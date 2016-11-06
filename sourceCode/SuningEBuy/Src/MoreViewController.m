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
    TT_RELEASE_SAFELY(_selectMark);
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
        
        [self initialNotifications];
        quailtyType = [[Config currentConfig].imageQuailty intValue];
        
       // self.navigationController.navigationBar
    }
    return self;
}

- (void)initialNotifications{
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter addObserver:self
                      selector:@selector(defaultCityDidChange:)
                          name:DEFAULT_CITY_CHANGE_NOTIFICATION
                        object:nil];
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
#pragma mark address picker view method

- (void)addressPickerLoadDataOkWithSelectInfo:(AddressInfoDTO *)addressInfo
{
    _moreView.cityLabel.text = addressInfo.cityContent;
//    [_moreView.addressBtn setTitle:addressInfo.cityContent forState:UIControlStateNormal];
    
}


#pragma mark -
#pragma mark tool bar cell delegate
//doneClicked   //doneButtonClicked
- (void)doneClicked:(ToolBarCell *)sender
{
    AddressInfoDTO *selectInfo = _moreView.addressPickerView.selectAddressInfo;
    if (selectInfo.province == nil ||
        selectInfo.city == nil) {
        return;
    }
    [Config currentConfig].defaultProvince = _moreView.addressPickerView.selectAddressInfo.province;
    [Config currentConfig].defaultCity = _moreView.addressPickerView.selectAddressInfo.city;
    NSNotification *notification = 
    [NSNotification notificationWithName:DEFAULT_CITY_CHANGE_NOTIFICATION
                                  object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    _moreView.cityLabel.text = _moreView.addressPickerView.selectAddressInfo.cityContent;
    [_moreView.addressBtn setTitle:_moreView.addressPickerView.selectAddressInfo.cityContent forState:UIControlStateNormal];
    [_moreView.groupTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
    [sender resignFirstResponder];
}

- (void)cancelButtonClicked:(id)sender{
    
}

#pragma mark -
#pragma mark table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 0)
    {
        switch (section) {
            case 0:
                return 1;
                break;
            case 1:
                return 3;
            default:
                break;
        }
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 0) {
        return 10;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 0) {
        static NSString *moreCellIdentifier = @"moreCellIdentifier";
        
        ToolBarCell *cell = [tableView dequeueReusableCellWithIdentifier:moreCellIdentifier];
        if (cell == nil) {
            cell = [[ToolBarCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:moreCellIdentifier];
            cell.toolBarDelegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.canBecomeFirstRes = NO;
            //cell.backgroundColor = [UIColor cellBackViewColor];
            cell.textLabel.textColor = [UIColor light_Black_Color];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        }
        else
        {
            cell.textLabel.text = @"";
            cell.detailTextLabel.text = @"";
            cell.accessoryView = nil;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.canBecomeFirstRes = NO;
            cell.inputView = nil;
            
            [cell.contentView removeAllSubviews];
        }
        
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellDetail.png"]];
        //arrow.frame = CGRectMake(0, 0, 18/2, 29/2);
        
        
        switch (indexPath.section) {
            case 0:
            {
                if (indexPath.row == 0) {
                    
                    cell.textLabel.text = L(@"Delivery City");
                    //cell.accessoryView = _moreView.addressBtn;
                    // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.accessoryView = arrow;
                    cell.canBecomeFirstRes = YES;
                    cell.inputView = _moreView.addressPickerView;
                    [cell.contentView addSubview:_moreView.cityLabel];
                    // _moreView.addressBtn.inputView = _moreView.addressPickerView;
                }
                
                break;
            }
            case 1:{
                
                switch (indexPath.row) {
                    case 0:
                    {
                        cell.textLabel.text = L(@"Intelligent model");
                        if (AUTO_QUAILTY == quailtyType) {
                            
                            cell.accessoryView = self.selectMark;
                        }
                    }
                        break;
                    case 1:
                    {
                        cell.textLabel.text = L(@"High quality (for Wifi)");
                        if (HEIGHT_QUAILTY == quailtyType) {
                            
                            cell.accessoryView = self.selectMark;
                        }
                    }
                        break;
                    case 2:
                    {
                        cell.textLabel.text = L(@"Ordinary (for 3G or 2G environment)");
                        if (LOW_QUAILTY == quailtyType) {
                            
                            cell.accessoryView = self.selectMark;
                        }
                    }
                        break;
                    default:
                        break;
                }
                
            }
                break;
            default:
                break;
        }
        return cell;
    }
    return nil;
}


- (void)singleSelectCell:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [_moreView.groupTableView indexPathForCell:cell];
    
    switch (indexPath.section) {
        case 0:
            
            break;
        case 1:{
            
            quailtyType = indexPath.row;
            [Config currentConfig].imageQuailty = [NSNumber numberWithInt:quailtyType];
            [_moreView.groupTableView reloadData];
        }
            break;
        default:
            break;
    }
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

- (void)defaultCityDidChange:(NSNotification *)notification
{
    NSNumber *isNeedRefresh = [notification object];
    if (isNeedRefresh && 
        [isNeedRefresh isKindOfClass:[NSNumber class]] &&
        ![isNeedRefresh boolValue]) {
        //do nothing
    }else{
        //刷新默认地址
        AddressInfoDTO *dto = [[AddressInfoDTO alloc] init];
        dto.province = [Config currentConfig].defaultProvince;
        dto.city = [Config currentConfig].defaultCity;
        _moreView.addressPickerView.baseAddressInfo = dto;
        TT_RELEASE_SAFELY(dto);
        //[_moreView.addressPickerView reloadAddressData];
    }
    
}

- (UIImageView *)selectMark{
    if (_selectMark == nil) {
        _selectMark = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 12, 9)];
        
        _selectMark.image = [UIImage imageNamed:@"cellMark.png"];
    }
    return  _selectMark;
}

#pragma mark - Tapped Action Methods
#pragma mark   点击事件的相应处理

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
