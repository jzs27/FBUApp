//
//  VehicleImageViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/21/21.
//

#import "VehicleImageViewController.h"

#import "RateViewController.h"

@interface VehicleImageViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation VehicleImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationLabel.text = self.vehicle.location;
    
    self.dateLabel.text = [Vehicle createDateString:self.vehicle.availableStartDate withEndDate:self.vehicle.availableEndDate];
    
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
    UIImage *img = [self resizeImage:originalImage withSize:size];
    self.vehicleView.image = img;
    self.image= img;
    
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

- (IBAction)didTapConfirm:(id)sender {
    self.activityView = [[UIActivityIndicatorView alloc]
                                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    self.activityView.center=self.view.center;
    [self.activityView startAnimating];
    [self.view addSubview:self.activityView];
    
    if (self.image != nil){
        self.vehicle.image = [Vehicle getPFFileFromImage:self.image];
        [self.vehicle saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (error){
                NSLog(@"Error:%@",error.localizedDescription);
            }
            else{
                [self.activityView stopAnimating];
                [self performSegueWithIdentifier:@"fromVehicleImage" sender:nil];
            }
        }];
    }
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"fromVehicleImage"]){
        RateViewController *rate = [segue destinationViewController];
        rate.vehicle = self.vehicle;
    }
}

- (IBAction)didTapX:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
