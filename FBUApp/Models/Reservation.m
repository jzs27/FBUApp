//
//  Reservation.m
//  FBUApp
//
//  Created by jessicasyl on 7/12/21.
//

#import "Reservation.h"

@implementation Reservation

//@dynamic objectID;
@dynamic brand;
@dynamic location;
@dynamic image;
@dynamic price;
@dynamic rentee;
@dynamic renter;
@dynamic model;

+ (nonnull NSString *)parseClassName {
    return @"Reservation";
}


+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Reservation *newReservation = [Reservation new];
    newReservation.image = [self getPFFileFromImage:image];
    newReservation.price =  @(0); //do I send it into function?
    newReservation.rentee = [PFUser currentUser];
    [newReservation saveInBackgroundWithBlock: completion];
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
