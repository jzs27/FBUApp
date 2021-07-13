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
@dynamic price;
@dynamic owner;
@dynamic model;

+ (nonnull NSString *)parseClassName {
    return @"Vehicle";
}


+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Vehicle *newVehicle = [Vehicle new];
    newVehicle.image = [self getPFFileFromImage:image];
    newVehicle.price =  @(0); //do I send it into function?
    newVehicle.owner = [PFUser currentUser];
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
