//
//  PopUpViewController.m
//  FBUApp
//
//  Created by jessicasyl on 7/27/21.
//

#import "PopUpViewController.h"

@interface PopUpViewController ()

@end

@implementation PopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:0.8];
}

- (IBAction)didPressLogin:(id)sender {
    [self.view removeFromSuperview];
    [self.delegate returnToLogin];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
