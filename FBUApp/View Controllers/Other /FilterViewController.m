//
//  FilterViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/21/21.
//

#import "FilterViewController.h"

@interface FilterViewController ()<BEMCheckBoxDelegate>

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    NSString *tappedBox = @"";
    if (checkBox == self.smallCheckBox){
        tappedBox = @"Small to Full Size";
    }
    
    if (checkBox == self.luxuryCheckBox){
        tappedBox = @"Luxury & Convertible";
    }
    if (checkBox == self.vanCheckBox){
        tappedBox = @"Vans & Trucks";
    }
    if (checkBox == self.wagonCheckBox){
        tappedBox = @"SUVs & Wagons";
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
    
}

- (IBAction)didTapApply:(id)sender {
}

@end
