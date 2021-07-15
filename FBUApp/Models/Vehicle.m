//
//  Vehicle.m
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//
#import "Vehicle.h"

@implementation Vehicle

@dynamic postID;
@dynamic make;
@dynamic location;
@dynamic image;
@dynamic rate;
@dynamic owner;
@dynamic model;
@dynamic year;
@dynamic availableEndDate;
@dynamic availableStartDate;

+ (nonnull NSString *)parseClassName {
    return @"Vehicle";
}

+ (void) createVehicle: ( UIImage * _Nullable )image  withLocation:(NSString*)location withMake:(NSString*)make withModel:(NSString*)model withYear:(NSString*)year withRate:(NSNumber*)rate withOwner:(PFUser*)owner withAvailableStartDate:(NSDate*)availableStartDate withAvailableEndDate:(NSDate*)availableEndDate withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Vehicle *newVehicle = [Vehicle new];
    newVehicle.image = [self getPFFileFromImage:image];
    newVehicle.rate =  rate;
    newVehicle.owner = [PFUser currentUser];
    newVehicle.location = location;
    newVehicle.availableEndDate = availableEndDate;
    newVehicle.availableStartDate = availableStartDate;
    newVehicle.make = make;
    newVehicle.model = model;
    newVehicle.year = year;
    
    [newVehicle saveInBackgroundWithBlock: completion];
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    if (!imageData) {
        return nil;
    }
    return [PFFileObject fileObjectWithName:@"image.png"  data:imageData];
}

@end
