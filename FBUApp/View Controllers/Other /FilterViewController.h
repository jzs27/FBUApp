//
//  FilterViewController.h
//  FBUApp
//
//  Created by jessicasyl on 7/21/21.
//

#import <UIKit/UIKit.h>
#import <BEMCheckBox/BEMCheckBox.h>

NS_ASSUME_NONNULL_BEGIN

@interface FilterViewController : UIViewController
@property (weak, nonatomic) IBOutlet BEMCheckBox *allCheckBox;
@property (weak, nonatomic) IBOutlet BEMCheckBox *vanCheckBox;
@property (weak, nonatomic) IBOutlet BEMCheckBox *highToLowCheckBox;
@property (weak, nonatomic) IBOutlet BEMCheckBox *smallCheckBox;
@property (weak, nonatomic) IBOutlet BEMCheckBox *luxuryCheckBox;
@property (weak, nonatomic) IBOutlet BEMCheckBox *wagonCheckBox;
@property (weak, nonatomic) IBOutlet BEMCheckBox *lowToHighCheckBox;

@end

NS_ASSUME_NONNULL_END
