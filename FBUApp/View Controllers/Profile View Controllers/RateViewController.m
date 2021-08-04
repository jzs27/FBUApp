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
@property int make;
@property int year;
@property int type;
@property int location;
@property int time;
@property int result;

@end

@implementation RateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNetInputs];
    [self calculateRate];
    [self setupLabels];
    self.locationLabel.textAlignment = NSTextAlignmentCenter;
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    self.rateCalculationLabel.textAlignment = NSTextAlignmentCenter;
    
    self.makes = @{@"Tesla":@1, @"Toyota":@1, @"Porche":@1, @"Audi":@1,@"BMW":@1, @"Chevrolet":@1,@"Jeep":@1};
}

-(void)setupLabels{
    NSString *currentValueString = [NSString stringWithFormat:@"$%d",self.currentValue];
    CGFloat boldTextSize = 17.0f;

    self.rateCalculationLabel.text = [NSString stringWithFormat:@"Based on vehicle, location, and other factors, it is suggested that you charge %@ / day.",currentValueString];
    
    NSRange range1 = [self.rateCalculationLabel.text rangeOfString:currentValueString];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:self.rateCalculationLabel.text];
    [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextSize]} range:range1];
    
    self.rateCalculationLabel.attributedText = attributedText;
    self.rateField.text = [NSString stringWithFormat:@"%i",self.currentValue];
    self.locationLabel.text = self.vehicle.location;
    self.dateLabel.text = [Vehicle createDateString:self.vehicle.availableStartDate withEndDate:self.vehicle.availableEndDate];
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

-(void)setNetInputs{
    self.location = 0;
    if ([self.vehicle.location containsString:@"NY"] || [self.vehicle.location containsString:@"CA"]){
        self.location = 1;
    }
    NSTimeInterval secondsBetween = [self.vehicle.availableStartDate timeIntervalSinceDate:self.vehicle.availableEndDate];
    int days = secondsBetween / 86400;
    self.time = 0;
    if (days < 7){
        self.time = 1;
    }
    
    self.make = 0;
    if ([self.makes objectForKey:self.vehicle.make]){
        self.make =1;
    }
    
    self.type = 0;
    if (![self.vehicle.type  isEqual: @"Small to Full Size"]){
        self.type = 1;
    }
    
    self.year = 0;
    if ([self.vehicle.year  isEqual: @"2021"] || [self.vehicle.year  isEqual: @"2020"] || [self.vehicle.year  isEqual: @"2019"]){
        self.year = 1;
    }
}

-(void)calculateRate{
    SNTrainingRecord records[] = {
        {SNInput(1,1,1,1,1), SNOutput(1)},
        {SNInput(1,1,1,1,0), SNOutput(1)},
        {SNInput(1,1,1,0,1), SNOutput(1)},
        {SNInput(1,1,0,1,1), SNOutput(1)},
        {SNInput(1,0,1,1,1), SNOutput(1)},
        {SNInput(0,1,1,1,1), SNOutput(1)},
        {SNInput(1,1,1,0,0), SNOutput(1)},
        {SNInput(1,1,0,1,0), SNOutput(1)},
        {SNInput(1,0,1,1,0), SNOutput(1)},
        {SNInput(0,1,1,1,0), SNOutput(1)},
        {SNInput(1,1,0,0,1), SNOutput(1)},
        {SNInput(1,0,1,0,1), SNOutput(1)},
        {SNInput(0,1,1,0,1), SNOutput(1)},
        {SNInput(1,0,0,1,1), SNOutput(1)},
        {SNInput(0,1,0,1,1), SNOutput(1)},
        {SNInput(0,0,1,1,1), SNOutput(1)},
        {SNInput(0,0,0,0,0), SNOutput(0)},
        {SNInput(0,0,0,0,1), SNOutput(0)},
        {SNInput(0,0,0,1,0), SNOutput(0)},
        {SNInput(0,0,1,0,0), SNOutput(0)},
        {SNInput(0,1,0,0,0), SNOutput(0)},
        {SNInput(1,0,0,0,0), SNOutput(0)},
        {SNInput(0,0,0,1,1), SNOutput(0)},
        {SNInput(0,0,1,0,1), SNOutput(0)},
        {SNInput(0,1,0,0,1), SNOutput(0)},
        {SNInput(1,0,0,0,1), SNOutput(0)},
        {SNInput(0,0,1,1,0), SNOutput(0)},
        {SNInput(0,1,0,1,0), SNOutput(0)},
        {SNInput(1,0,0,1,0), SNOutput(0)},
        {SNInput(0,1,1,0,0), SNOutput(0)},
        {SNInput(1,0,1,0,0), SNOutput(0)},
        {SNInput(1,1,0,0,0), SNOutput(0)}
    };
    
    

    SNNeuralNet *net = [[SNNeuralNet alloc] initWithTrainingData:records
                                                      numRecords:31
                                                       numInputs:5
                                                      numOutputs:1];
    
    [net.hiddenLayers arrayByAddingObjectsFromArray:@[@4,]];

    net.maxIterations = 20000;
    net.minError = 0.0001;
    net.learningRate = 0.03;
    net.momentum = 0.1;
    
    if (!net.isTrained){
        [net train:records numRecords:31];
    }
    
    
    double *output = [net runInput:SNInput(self.make, self.year, self.type, self.location, self.time)];
    
    self.currentValue = 0;
    
    if (output[0] >= 0.9){
        self.currentValue = 50;
    }
    if (output[0] >= 0.02){
        self.currentValue = 40;
    }
}

@end
