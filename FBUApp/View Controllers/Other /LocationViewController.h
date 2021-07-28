//
//  ReuseLocationViewController.h
//  FBUApp
//
//  Created by jessicasyl on 7/19/21.
//

#import <UIKit/UIKit.h>

#import <GoogleMaps/GoogleMaps.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ReuseLocationDelegate

-(void)didSetLocation:(NSString *)location;
-(void)didSetLocation:(NSString *)location withGeoPoint:(PFGeoPoint*)geoPoint;

@end

@interface LocationViewController : UIViewController

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (strong, nonatomic) NSString *location;
@property (nonatomic,weak) id<ReuseLocationDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
