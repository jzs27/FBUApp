//
//  CalendarViewController.h
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalendarViewController : UIViewController

@property NSMutableArray *arrayOfDates;
@property NSDate *startDate;
@property NSDate *endDate;
@property bool *firstDate;
@property (weak, nonatomic) IBOutlet UILabel *monthly;

@end

NS_ASSUME_NONNULL_END
