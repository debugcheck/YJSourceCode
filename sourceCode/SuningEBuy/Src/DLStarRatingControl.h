// 评价用的星星视图

#import <UIKit/UIKit.h>

#define kDefaultNumberOfStars 5

@protocol DLStarRatingDelegate;

@interface DLStarRatingControl : UIControl {
	int numberOfStars;
	int currentIdx;
	UIImage *star;
	UIImage *highlightedStar;
	IBOutlet id<DLStarRatingDelegate> delegate;
}

- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame andStars:(NSUInteger)_numberOfStars;

@property (strong,nonatomic) UIImage *star;
@property (strong,nonatomic) UIImage *highlightedStar;
@property (nonatomic) NSUInteger rating;
@property (strong,nonatomic) id<DLStarRatingDelegate> delegate;

@end

@protocol DLStarRatingDelegate

- (void)newRating:(DLStarRatingControl *)control :(NSUInteger)rating;

@end
