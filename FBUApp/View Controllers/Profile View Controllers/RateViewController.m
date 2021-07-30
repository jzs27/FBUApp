//
//  RateViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/15/21.
//

#import "RateViewController.h"

#import <Parse/Parse.h>
#import "math.h"
#import <SNNeuralNet/SNNeuralNet.h>


#import "ConfirmVehicleViewController.h"

@interface RateViewController ()

@property UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property double recommendedRate;
@property (weak, nonatomic) IBOutlet UILabel *rateCalculationLabel;
@property NSDictionary *makes;
@property NSDictionary *types;
@property NSDictionary *year;

@end

@implementation RateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self calculateRate];
    [self createNeuralNet];
    
    self.makes = @{@"Tesla":@1, @"Toyota":@1, @"Porche":@1, @"Audi":@1,@"BMW":@1, @"Chevrolet":@1,@"Jeep":@1};
    
    NSString *currentValueString = [NSString stringWithFormat:@"$%d",self.currentValue];
    CGFloat boldTextSize = 17.0f;

    self.rateCalculationLabel.text = [NSString stringWithFormat:@"Based on vehicle, location, and other factors, it is suggested that you charge %@ /day.",currentValueString];
    
    NSRange range1 = [self.rateCalculationLabel.text rangeOfString:currentValueString];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:self.rateCalculationLabel.text];
    [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextSize]} range:range1];
    
    self.rateCalculationLabel.attributedText = attributedText;
    self.rateField.text = [NSString stringWithFormat:@"%i",self.currentValue];
    self.locationLabel.text = self.vehicle.location;
    self.dateLabel.text = [Vehicle createDateString:self.vehicle.availableStartDate withEndDate:self.vehicle.availableEndDate];
}

-(void)calculateRate{
    
    self.recommendedRate = 1;
    
    if ([self.vehicle.year  isEqual: @"2020"]){
        self.recommendedRate = self.recommendedRate - 0.01;
    }
    if ([self.vehicle.year  isEqual: @"2019"]){
        self.recommendedRate = self.recommendedRate - 0.01;
    }
    if ([self.vehicle.year isEqual: @"2018"]){
        self.recommendedRate -=0.03;
    }
    if ([self.vehicle.location containsString:@"TX"] ){
        self.recommendedRate = self.recommendedRate - 0.01;
    }
    if ([self.vehicle.location containsString:@"NY"] || [self.vehicle.location containsString:@"CA"]){
        self.recommendedRate +=0.01;
    }
    self.currentValue = 50 * self.recommendedRate;
}

- (IBAction)didTapPlusButton:(id)sender {
    self.currentValue = self.currentValue +5;
    self.rateField.text = [NSString stringWithFormat:@"%i",self.currentValue];
}

- (IBAction)didTapMinusButton:(id)sender {
    self.currentValue = self.currentValue -5;
    self.rateField.text = [NSString stringWithFormat:@"%i",self.currentValue];
}

- (IBAction)didTypeRate:(id)sender {
    self.currentValue = [self.rateField.text intValue];
}

- (IBAction)didTapConfirm:(id)sender {
    self.activityView = [[UIActivityIndicatorView alloc]
                                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    self.activityView.center=self.view.center;
    [self.activityView startAnimating];
    [self.view addSubview:self.activityView];
    
    self.vehicle.rate = [NSNumber numberWithInt:self.currentValue];
    
    [self.vehicle saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error){
            NSLog(@"Error:%@",error.localizedDescription);
        }
        else{
            [self.activityView stopAnimating];
            [self performSegueWithIdentifier:@"fromRate" sender:nil];
        }
    }];
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"fromRate"]){
        ConfirmVehicleViewController *confirmVehicle = [segue destinationViewController];
        confirmVehicle.vehicle = self.vehicle;
    }
}

- (IBAction)didTapX:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)createNeuralNet{
    SNTrainingRecord records[] = {
        {SNInput(1,1,0), SNOutput(1)},
        {SNInput(0,1,1), SNOutput(1)},
        {SNInput(1,0,1), SNOutput(1)},
        {SNInput(1,0,0), SNOutput(0)},
        {SNInput(0,1,0), SNOutput(0)},
        {SNInput(0,0,1), SNOutput(0)},
        {SNInput(1,1,1), SNOutput(1)},
        {SNInput(0,0,0), SNOutput(0)}
    };

    SNNeuralNet *net = [[SNNeuralNet alloc] initWithTrainingData:records
                                                      numRecords:8
                                                       numInputs:3
                                                      numOutputs:1];

    
    
    net.maxIterations = 20000;  // maximum training iterations
    net.minError = 0.0001;       // error threshold to reach
    net.learningRate = 0.03;     // influences how quickly the network trains
    net.momentum = 0.1;         // influences learning rate
    
    
    double error = [net train:records numRecords:8];
    double *output = [net runInput:SNInput(1, 0,1)];
}

@end
