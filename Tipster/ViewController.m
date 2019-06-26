//
//  ViewController.m
//  Tipster
//
//  Created by gilemos on 6/25/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billField;
@property (weak, nonatomic) IBOutlet UILabel *tipField;
@property (weak, nonatomic) IBOutlet UILabel *totalField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *percentagesBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onTap:(id)sender {
    NSLog(@"Hello");
    
    [self.view endEditing:YES];
}

- (IBAction)onEdit:(id)sender {
    
    NSArray *percentages = @[@(0.15), @(0.2), @(0.22)];
    
    double tipPercentage = [percentages[self.percentagesBar.selectedSegmentIndex] doubleValue];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double newTip = [defaults doubleForKey:@"default_tip_percentage"];

    double bill = [self.billField.text doubleValue];
    double tip = newTip * bill;
    double total = bill + tip;
    
    self.tipField.text = [NSString stringWithFormat:@"$%.2f", tip];
    self.totalField.text = [NSString stringWithFormat:@"$%.2f", total];
    
}

- (IBAction)onEditBegin:(id)sender {
    CGRect newFrame = self.billField.frame;
    
    newFrame.origin.y += 30;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.billField.frame = newFrame;
    }];
    
    [UIView animateWithDuration:1 animations:^{
        self.tipField.alpha = 0;
    }];
    
}

- (IBAction)onEditEnd:(id)sender {
    
    CGRect newFrame = self.billField.frame;
    
    newFrame.origin.y -= 30;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.billField.frame = newFrame;
    }];
    
    [UIView animateWithDuration:1 animations:^{
        self.tipField.alpha = 1;
    }];
}

@end
