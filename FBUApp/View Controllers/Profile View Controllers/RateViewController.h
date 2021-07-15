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

@end

NS_ASSUME_NONNULL_END
