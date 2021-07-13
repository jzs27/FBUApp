//
//  Vehicle.m
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//

#import "Vehicle.h"

@implementation Vehicle

@dynamic postID;
@dynamic brand;
@dynamic location;
@dynamic image;
@dynamic rate;
@dynamic owner;
@dynamic model;
@dynamic availableEndDate;
@dynamic availableStartDate;


+ (nonnull NSString *)parseClassName {
    return @"Vehicle";
}


+ (void) createVehicle: ( UIImage * _Nullable )image  withLocation:(NSString*)location withRate:(NSNumber*)rate withOwner:(PFUser*)owner withAvailableStartDate:(NSDate*)availableStartDate withAvailableEndDate:(NSDate*)availableEndDate withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    
    //brand model etc from API?
    
    Vehicle *newVehicle = [Vehicle new];
    newVehicle.image = [self getPFFileFromImage:image];
    newVehicle.rate =  rate; //do I send it into function?
    newVehicle.owner = [PFUser currentUser];
    newVehicle.location = location;
    newVehicle.availableEndDate = availableEndDate;
    newVehicle.availableStartDate = availableStartDate;
    
    [newVehicle saveInBackgroundWithBlock: completion];
}



+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    return [PFFileObject fileObjectWithName:@"image.png"  data:imageData];
}
@end