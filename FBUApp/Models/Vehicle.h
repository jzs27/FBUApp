//
//  Vehicle.h
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Vehicle : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *brand;
@property (nonatomic, strong) NSString *model;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSNumber *rate;
@property (nonatomic, strong) PFUser *owner;
@property (nonatomic, strong) NSDate *availableStartDate;
@property (nonatomic, strong) NSDate *availableEndDate;


+ (void) createVehicle: ( UIImage * _Nullable )image  withLocation:(NSString*)location withRate:(NSNumber*)rate withOwner:(PFUser*)owner withAvailableStartDate:(NSDate*)availableStartDate withAvailableEndDate:(NSDate*)availableEndDate withCompletion: (PFBooleanResultBlock  _Nullable)completion;

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image;
@end

NS_ASSUME_NONNULL_END
