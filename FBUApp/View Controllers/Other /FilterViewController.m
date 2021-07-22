//
//  FilterViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/21/21.
//

#import "FilterViewController.h"

@interface FilterViewController ()

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

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
    NSLog(@"tapping box");
    NSString *tappedBox = @"";
    if (checkBox == self.smallCheckBox && self.smallCheckBox.on ==YES){
        tappedBox = @"Small to Full Size";
    }
    
    if (checkBox == self.luxuryCheckBox && self.luxuryCheckBox.on == YES){
        tappedBox = @"Luxury & Convertible";
    }
    if (checkBox == self.vanCheckBox && self.vanCheckBox.on == YES){
        tappedBox = @"Vans & Trucks";
    }
    if (checkBox == self.wagonCheckBox && self.wagonCheckBox.on == YES){
        tappedBox = @"SUVs & Wagons";
    }
    [self.delegate addQueryFilter:tappedBox];
}

- (IBAction)didTapReset:(id)sender {
    self.allCheckBox.on = NO;
    self.smallCheckBox.on = NO;
    self.highToLowCheckBox.on = NO;
    self.lowToHighCheckBox.on = NO;
    self.luxuryCheckBox.on = NO;
    self.vanCheckBox.on = NO;
    self.wagonCheckBox.on = NO;
}

- (IBAction)didTapApply:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
