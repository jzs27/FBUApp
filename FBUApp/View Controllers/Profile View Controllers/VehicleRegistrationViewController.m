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
#import "VehicleImageViewController.h"

@interface VehicleRegistrationViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *modelTextField;
@property (weak, nonatomic) IBOutlet UIButton *typeButton;
@property (weak, nonatomic) IBOutlet UITableView *typeTableView;
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"fromVehicleRegistration"]){
        VehicleImageViewController *vehicleImage = [segue destinationViewController];
        vehicleImage.vehicle = self.vehicle;
    }
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
    if (self.year != nil){
            self.vehicle.year= self.year;
        }
        if (self.makeTextField.text != nil){
            self.vehicle.make = self.makeTextField.text;
        }
        if (self.modelTextField.text != nil){
            self.vehicle.model = self.modelTextField.text;
        }
        if (self.type != nil){
            self.vehicle.type = self.type;
        }
    
    [self.vehicle saveInBackground];
    
    [self performSegueWithIdentifier:@"fromVehicleRegistration" sender:nil];
}



@end
