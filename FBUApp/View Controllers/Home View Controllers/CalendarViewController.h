//
//  CalendarViewController.h
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalendarViewController : UIViewController

@property NSMutableArray *arrayOfData;
@property (weak, nonatomic) IBOutlet UILabel *monthly;

@end

NS_ASSUME_NONNULL_END
