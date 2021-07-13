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
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) PFUser *owner;


@end

NS_ASSUME_NONNULL_END
