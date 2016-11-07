//
//  NewHomeTopView.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-7-8.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NewHomeTopView.h"

#define ios7width           3

@implementation NewHomeTopView

@synthesize topBannerView           = _topBannerView;
@synthesize searchBarView           = _searchBarView;
@synthesize searchBtn               = _searchBtn;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_topBannerView);
    TT_RELEASE_SAFELY(_searchBtn);
    TT_RELEASE_SAFELY(_searchBarView);
    
}

- (id)initWithOwner:(id)owner {
    self = [super initWithOwner:owner];
    if (self) {
        CGRect frame = [[UIScreen mainScreen] bounds];
        self.frame = frame;
        //        self.backgroundColor = RGBCOLOR(242, 242, 242);
        
        //        self.backgroundColor = [UIColor colorWithRGBHex:0xf5f5f5];
        //八联版
        self.topBannerView.delegate = self.owner;
    
        frame.origin.y = 0;
        frame.size.height -= (kStatusBarHeight + kUITabBarFrameHeight + 44);
        self.tableView.frame = frame;
        [self addSubview:self.tableView];
        
//        [self addSubview:self.searchBarView];
//        [self.topBannerView addSubview:self.searchBarView];
//        [self.searchBarView insertSubview:self.topBannerView aboveSubview:self.topBannerView.scrollView];
        
    }
    return self;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] init];
        _cancelButton.frame = CGRectMake(260, 7, 50, 28);
        //        [_cancelButton setBackgroundImage:[UIImage imageNamed:@"right_item_btn.png"] forState:UIControlStateNormal];
        if (IOS7_OR_LATER)
        {
            _cancelButton.backgroundColor = [UIColor clearColor];
            [_cancelButton setTitleColor:[UIColor colorWithRGBHex:0x313131] forState:UIControlStateNormal];
            [_cancelButton setTitleColor:[UIColor colorWithRGBHex:0xfc7c26] forState:UIControlStateHighlighted];
        }
        else
        {
            _cancelButton.backgroundColor = [UIColor clearColor];
            [_cancelButton setTitleColor:[UIColor colorWithRGBHex:0x707070] forState:UIControlStateNormal];
            [_cancelButton setTitleColor:[UIColor colorWithRGBHex:0xfc7c26] forState:UIControlStateHighlighted];

        }
        
        
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.titleEdgeInsets = UIEdgeInsetsMake(1, 1, 0, 0);
        
        //_cancelButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:16.0];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        //        [_cancelButton setTitleColor:[UIColor colorWithRGBHex:0x825201] forState:UIControlStateNormal];
//        _cancelButton.titleLabel.shadowOffset = CGSizeZero;
        _cancelButton.hidden = YES;
        _cancelButton.tag = 1001;
        [_cancelButton addTarget:self action:@selector(hideSearchBar:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (EightBannerView *)topBannerView
{
    if (!_topBannerView) {
        _topBannerView = [[EightBannerView alloc] init];
        _topBannerView.frame =CGRectMake(0, 0, 320, 148);
    }
    return _topBannerView;
}

- (SearchbarView *)searchBarView{
    if (!_searchBarView) {
        _searchBarView = [[SearchbarView alloc] init];
        _searchBarView.backgroundColor = [UIColor clearColor];
        _searchBarView.frame = CGRectMake(0, 0, 320, 44);
        _searchBarView.delegate = self.owner;
        [_searchBarView addSubview:self.cancelButton];
    }
    return _searchBarView;
}

- (UIButton *)searchBtn
{
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.frame = CGRectMake(267, 5, 50, 30);
        _searchBtn.backgroundColor = [UIColor clearColor];
        [_searchBtn setImage:[UIImage imageNamed:@"home_search.png"]
                    forState:UIControlStateNormal];
        [_searchBtn setImage:[UIImage imageNamed:@"home_search_click.png"]
                    forState:UIControlStateHighlighted];
        [_searchBtn addTarget:self action:@selector(goToSearchView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}


//显示搜索框
- (void)showSearchBar
{
    self.tableView.scrollEnabled = NO;
    self.cancelButton.hidden = NO;
    self.searchBarView.wholeImageView.alpha = 1.0f;
    self.searchBarView.lineView.hidden = YES;
    self.searchBarView.searchTypeBtn.hidden = NO;
    


//    self.searchBarView.searchImgView.layer.borderColor = RGBCOLOR(216, 216, 216).CGColor;
    self.searchBarView.searchImgView.layer.borderColor = [UIColor clearColor].CGColor;
    if (IOS7_OR_LATER) {
        self.searchBarView.searchImgView.frame = CGRectMake(60, 7, 195, 28);

        self.searchBarView.searchTextField.frame = CGRectMake(60 + 7, 11, 195 - 7, 22);
        self.searchBarView.searchImgBtn.hidden = YES;
    }else{
        self.searchBarView.searchImgView.frame = CGRectMake(60 + ios7width, 7, 195, 28);

        self.searchBarView.searchTextField.frame = CGRectMake(60 + ios7width + 7, 11, 195 - 7, 22);
        self.searchBarView.searchImgBtn.hidden = YES;
    }
}

- (void)hideSearchBar:(UIButton *)btn
{
    
    if (btn.tag == 1001) {
        [self.searchBarView.searchTextField resignFirstResponder];
        self.searchBarView.searchTextField.text = @"";
    }
    self.tableView.scrollEnabled = YES;
    self.cancelButton.hidden = YES;
    self.searchBarView.searchTypeBtn.hidden = YES;
    self.searchBarView.wholeImageView.alpha = 0.0f;
  
    self.searchBarView.searchImgView.layer.borderColor = [UIColor light_Gray_Color].CGColor;
    self.searchBarView.lineView.hidden = NO;
    self.searchBarView.searchImgBtn.hidden = NO;
    if (IOS7_OR_LATER) {
        self.searchBarView.searchImgView.frame = CGRectMake(3, 7, 252, 28);
        self.searchBarView.searchTextField.frame = CGRectMake(3 + 30, 11, 243 - 28, 22);
        self.searchBarView.searchImgBtn.frame = CGRectMake(9, 12, 18, 18);
    }else{
        self.searchBarView.searchImgView.frame = CGRectMake(3 + ios7width, 7, 252, 28);
        self.searchBarView.searchTextField.frame = CGRectMake(3 + ios7width + 30, 11, 243 - 28, 22);
        self.searchBarView.searchImgBtn.frame = CGRectMake(9 + ios7width, 12, 18, 18);
    }
}

- (void)showReaderButton
{
    self.cancelButton.hidden = YES;
}

- (void)showCancelButton
{
    self.cancelButton.hidden = NO;
}


- (void)goToSearchView:(id)sender{
    
}


@end
