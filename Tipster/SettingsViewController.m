//
//  SettingsViewController.m
//  Tipster
//
//  Created by gilemos on 6/25/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISlider *rollBar;
@property (weak, nonatomic) IBOutlet UITextField *tipLabel;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)slider:(id)sender {
    double curValue = self.rollBar.value;
    
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", curValue];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setDouble:curValue forKey:@"default_tip_percentage"];
    [defaults synchronize];
    
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
