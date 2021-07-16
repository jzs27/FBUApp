//
//  RateViewController.h
//  FBUApp
//
//  Created by jessicasyl on 7/15/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RateViewController : UIViewController

@property (nonatomic,assign) int currentValue;
@property (weak, nonatomic) IBOutlet UITextField *rateField;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (strong, nonatomic) NSString *make;
@property (strong, nonatomic) NSString *model;
@property (strong, nonatomic) NSString *year;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) UIImage *img;

@end

NS_ASSUME_NONNULL_END
