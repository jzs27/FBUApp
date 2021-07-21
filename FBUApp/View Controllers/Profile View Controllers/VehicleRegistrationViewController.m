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
#import "RateViewController.h"

@interface VehicleRegistrationViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *modelTextField;
@property (weak, nonatomic) IBOutlet UIButton *typeButton;
@property (weak, nonatomic) IBOutlet UITableView *typeTableView;
@property (weak, nonatomic) IBOutlet UIImageView *vehicleView;
@property (weak, nonatomic) IBOutlet UITableView *yearTableView;
@property (weak, nonatomic) IBOutlet UIButton *yearButton;
@property (weak, nonatomic) IBOutlet UITextField *makeTextField;

@end

@implementation VehicleRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.typeTableView.dataSource = self;
    self.typeTableView.delegate = self;
    self.typeTableView.hidden = YES;
    
    self.yearTableView.dataSource = self;
    self.yearTableView.delegate = self;
    self.yearTableView.hidden = YES;
    
    self.typeData = [[NSArray alloc]initWithObjects:@"Small to Full Size",@"Luxury & Convertible",@"SUVs & Wagons",@"Vans & Trucks", nil];
    
    self.yearData = [[NSArray alloc]initWithObjects:@"2021",@"2020",@"2019",@"2018", nil];
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
    self.img = img;
    
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    RateViewController *rateViewController = [segue destinationViewController];
    
    rateViewController.vehicle = self.vehicle;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.typeTableView){
        return self.typeData.count;
    }
    else{
        return self.yearData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    static NSString *simpleTableIdentifier2 = @"SimpleTableItem2";
    
    UITableViewCell *cell;
    
    if (tableView == self.typeTableView){
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        cell.textLabel.text = [self.typeData objectAtIndex:indexPath.row] ;
    }
    else{
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier2];
        }
        cell.textLabel.text = [self.yearData objectAtIndex:indexPath.row] ;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.typeTableView){
        UITableViewCell *cell = [self.typeTableView cellForRowAtIndexPath:indexPath];
        [self.typeButton setTitle:cell.textLabel.text forState:UIControlStateNormal];
        self.type = cell.textLabel.text;
        
        self.typeTableView.hidden = YES;
    }
    
    else{
        UITableViewCell *cell = [self.yearTableView cellForRowAtIndexPath:indexPath];
        [self.yearButton setTitle:cell.textLabel.text forState:UIControlStateNormal];
        self.year = cell.textLabel.text;
        self.yearTableView.hidden = YES;
        
    }
}

- (IBAction)didTapButton:(id)sender {
    if (self.typeTableView.hidden == YES) {
            self.typeTableView.hidden = NO;
        }
    else{
        self.typeTableView.hidden = YES;
    }
}

- (IBAction)didTapYearButton:(id)sender {
    if (self.yearTableView.hidden == YES) {
            self.yearTableView.hidden = NO;
        }
    else{
        self.yearTableView.hidden = YES;
    }
}

- (IBAction)didTypeModel:(id)sender {
    self.model = self.modelTextField.text;
}

- (IBAction)didTypeMake:(id)sender {
    self.make = self.makeTextField.text;
}

- (IBAction)didTapNext:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Vehicle"];
    
    NSString *vehicleID = self.vehicle.objectId;
    [query getObjectInBackgroundWithId:vehicleID
                                 block:^(PFObject *vehicle, NSError *error) {
        
        vehicle[@"year"] = self.year;
        vehicle[@"make"] = self.make;
        vehicle[@"type"] = self.type;
        //vehicle[@"image"] =  [self getPFFileFromImage:self.img];
    
        [vehicle saveInBackground];
    }];
    
    [self performSegueWithIdentifier:@"fromVehicleRegistration" sender:nil];
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
