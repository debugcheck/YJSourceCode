//
//  MyCardViewController.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MemeberMergeService.h"

@interface MyCardViewController : CommonViewController<EGOImageViewDelegate,EGOImageViewExDelegate,MemeberMergeServiceDelegate>

@property (nonatomic, strong) MemeberMergeService   *memberMergeService;

@end
