//
//  SevenLeListViewController.m
//  SuningLottery
//
//  Created by yang yulin on 13-4-8.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "SevenLeListViewController.h"
#import "ChooseSevenLeListCell.h"
#import "SettlementUtil.h"
#import "LotteryPayPageViewController.h"
#import "SubmitLotteryDto.h"
#import "LotteryDataModel.h"
#import "SevenLeSelectViewController.h"
#import "ComputeLotteryNumber.h"
#import "LotteryProtocolViewController.h"
#import "LotteryHallViewController.h"
#import "LotteryPayPlugin.h"

@interface SevenLeListViewController()

@property(nonatomic,strong) SevenLeSelectViewController  *ballSelectViewCotnoller;
@property (nonatomic , strong) NSMutableArray *ballInfoArray;

@end

@implementation SevenLeListViewController


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    LotteryPayPageViewController *ctrl = [[LotteryPayPageViewController alloc]initWithSubmitLotteryDTO:self.submitLotteryDto];
//    
//    [self.navigationController pushViewController:ctrl animated:YES];
    
//    LotteryProtocolViewController *controller = [[LotteryProtocolViewController alloc] initWithNameData:_titleString];
//    
//    [self.navigationController pushViewController:controller animated:YES];
    
    
    
//    LotteryPayPageViewController *ctrl = [[LotteryPayPageViewController alloc]initWithSubmitLotteryDTO:self.submitLotteryDto];
//    
//    [self.navigationController pushViewController:ctrl animated:YES];
    
//    self.ballSelectViewCotnoller.lotteryHallDto = self.lotteryHallDto;
//    
//    self.ballSelectViewCotnoller.isFromOrder = YES;
//    
//    self.ballSelectViewCotnoller.lotteryList = self.lotteryList;
//    
//    self.delegate = self.ballSelectViewCotnoller;
//    
//    [self.navigationController pushViewController:self.ballSelectViewCotnoller animated:YES];





}


-(SevenLeSelectViewController *)ballSelectViewCotnoller{
    
    if (!_ballSelectViewCotnoller) {
        
        _ballSelectViewCotnoller = [[SevenLeSelectViewController alloc] init];
        
    }
    
    return _ballSelectViewCotnoller;
    
}

@end
