//
//  PopUpViewController.h
//  FBUApp
//
//  Created by jessicasyl on 7/27/21.
//

#import <UIKit/UIKit.h>

#import "Reservation.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PopViewControllerDelegate

-(void)returnToLogin;

@end

@interface PopUpViewController : UIViewController

@property Reservation *reservation;
@property (nonatomic,weak) id<PopViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
