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
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *make;
@property (nonatomic, strong) NSString *model;
@property (nonatomic, strong) NSString *seats;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSNumber *rate;
@property (nonatomic, strong) PFUser *owner;
@property (nonatomic, strong) NSDate *availableStartDate;
@property (nonatomic, strong) NSDate *availableEndDate;
@property (nonatomic) BOOL *currentlyRented;


+(Vehicle *) createVehicle: (NSString*)location withCompletion: (PFBooleanResultBlock  _Nullable)completion;
+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image;
+(NSString *)createDateString:(NSDate *)startDate withEndDate:(NSDate *)endDate;
@end

NS_ASSUME_NONNULL_END
