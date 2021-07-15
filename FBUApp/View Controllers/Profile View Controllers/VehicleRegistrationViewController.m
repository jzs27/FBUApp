//
//  VehicleRegistrationViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/13/21.
//

// interface header
#import "VehicleRegistrationViewController.h"

// standard includes
#import <Parse/Parse.h>

// relative includes
#import "Vehicle.h"

@interface VehicleRegistrationViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *vehicleView;

@end

@implementation VehicleRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSURL *url = [NSURL URLWithString:@"https://parseapi.back4app.com/classes/Carmodels_Car_Model_List?limit=11"];
//    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
//    [urlRequest setValue:@"d3KrzmWFMDDmvtl6TqzWGLRGdmKk7KC8IU6Euon5" forHTTPHeaderField:@"d3KrzmWFMDDmvtl6TqzWGLRGdmKk7KC8IU6Euon5"]; // This is your app's application id
//    [urlRequest setValue:@"nHFOXhuez3JbWAgW7Vqm6rAkwEbwuTuUiBVU4Cls" forHTTPHeaderField:@"nHFOXhuez3JbWAgW7Vqm6rAkwEbwuTuUiBVU4Cls"]; // This is your app's REST API key
//    [[[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]; // Here you have the data that you need
//        printf("%s", [[NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil] bytes]);
//    }] resume];

    
}

- (IBAction)didTapVehicle:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    
    CGSize size = CGSizeMake(1500, 1500);
    self.vehicleView.image = [self resizeImage:originalImage withSize:size];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}




/*
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}
*/

@end
