//
//  FilterViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/21/21.
//

#import "FilterViewController.h"

@interface FilterViewController ()

@property NSMutableArray *filters;

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.filters = [NSMutableArray new];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)didTapCheckBox:(BEMCheckBox *)checkBox{
    if (checkBox == self.allCheckBox && self.allCheckBox.on == YES){
        self.smallCheckBox.on = YES;
        self.luxuryCheckBox.on = YES;
        self.vanCheckBox.on = YES;
        self.wagonCheckBox.on = YES;
        self.filters = [[NSArray alloc]initWithObjects:@"Small to Full Size",@"Luxury & Convertible",@"SUVs & Wagons",@"Vans & Trucks", nil];
    }
    if (checkBox == self.smallCheckBox && self.smallCheckBox.on ==YES){
        [self.filters addObject:@"Small to Full Size"];

    }
    if (checkBox == self.smallCheckBox && self.smallCheckBox.on ==NO){
        [self didTapReset:nil];

    }
    
    if (checkBox == self.luxuryCheckBox && self.luxuryCheckBox.on == YES){
        [self.filters addObject:@"Luxury & Convertible"];
        
    }
    if (checkBox == self.vanCheckBox && self.vanCheckBox.on == YES){
        [self.filters addObject:@"Vans & Trucks"];
        
    }
    if (checkBox == self.wagonCheckBox && self.wagonCheckBox.on == YES){
        [self.filters addObject:@"SUVs & Wagons"];
        
    }
    if (checkBox == self.lowToHighCheckBox && self.lowToHighCheckBox.on == YES){
        [self.delegate addPriceFilter:@"lowToHigh"];
        [self.filters addObject:@"lowToHigh"];
    }
    if (checkBox == self.highToLowCheckBox && self.highToLowCheckBox.on == YES){
        [self.delegate addPriceFilter:@"highToLow"];
        [self.filters addObject:@"highToLow"];
    }
    
}

- (IBAction)didTapReset:(id)sender {
    self.allCheckBox.on = NO;
    self.smallCheckBox.on = NO;
    self.highToLowCheckBox.on = NO;
    self.lowToHighCheckBox.on = NO;
    self.luxuryCheckBox.on = NO;
    self.vanCheckBox.on = NO;
    self.wagonCheckBox.on = NO;
    self.filters = [NSMutableArray new];
}

- (IBAction)didTapApply:(id)sender {
    [self.delegate addMultiFilter:self.filters];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
