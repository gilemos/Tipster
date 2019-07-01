//
//  ViewController.m
//  Tipster
//
//  Created by gilemos on 6/25/19.
//  Copyright © 2019 gilemos. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//The text field where the user will enter the total bill
@property (weak, nonatomic) IBOutlet UITextField *billField;

//The place where the tip will appear
@property (weak, nonatomic) IBOutlet UILabel *tipField;

//The place where the total bill will appear
@property (weak, nonatomic) IBOutlet UILabel *totalField;

//The bar where the user can choose a percentage for the tip
@property (weak, nonatomic) IBOutlet UISegmentedControl *percentagesBar;

@end

@implementation ViewController


//This method sets up the app when it first loads. We set out begining tip percentage as the selected
//value in the percentages bar adn the beggining default bill as zero
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"View did Load");
    
    NSArray *percentages = @[@(0.15), @(0.2), @(0.22)];
    
    double tipPercentage = [percentages[self.percentagesBar.selectedSegmentIndex] doubleValue];
    
    NSUserDefaults *defaultForPercentage = [NSUserDefaults standardUserDefaults];
    [defaultForPercentage setDouble:tipPercentage forKey:@"default_tip_percentage"];
    [defaultForPercentage synchronize];
    
    NSLog([NSString stringWithFormat:@"NEXT ROUND$%f", tipPercentage]);
}

//This method maked the keyboard go away when the user taps outside of the keyboard on the screen
- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}

//This method is called every time the user edits the bill field. It sets the default bill as the
//bill inserted by the user.
//It calls the method setUpValues to set up the proper values for the tip and total bill according to the
//default value with id "default_tip_percentage" and "default_bill"
- (IBAction)onEditBillField:(id)sender {
    NSLog(@"Edit Bill");

    NSUserDefaults *defaultForPercentage = [NSUserDefaults standardUserDefaults];
    double curTip = [defaultForPercentage doubleForKey:@"default_tip_percentage"];
    
    double curBill = [self.billField.text doubleValue];
    NSLog([NSString stringWithFormat:@"EDITING TIP$%f", curTip]);
    NSLog([NSString stringWithFormat:@"EDITION BILL$%f", curBill]);
    
    [self setUpValues:curBill percentage:curTip];
    
}

//This method is called every time the user edits the percentages bar.
- (IBAction)EditChangePercentageBar:(id)sender {
    
    NSLog(@"Edit Bar");
    NSArray *percentages = @[@(0.15), @(0.2), @(0.22)];
    
    double curTip = [percentages[self.percentagesBar.selectedSegmentIndex] doubleValue];
    
    NSUserDefaults *defaultForPercentage = [NSUserDefaults standardUserDefaults];
    [defaultForPercentage setDouble:curTip forKey:@"default_tip_percentage"];
    [defaultForPercentage synchronize];
    
    double curBill = [self.billField.text doubleValue];
    
    [self setUpValues:curBill percentage:curTip];
}


-(void)setUpValues:(double)bill percentage:(double)percentage{
    
    double tip = percentage * bill;
    NSLog(@"here");
    double total = bill + tip;
    
    self.tipField.text = [NSString stringWithFormat:@"$%.2f", tip];
    NSLog([NSString stringWithFormat:@"BILL SET UP VALUE$%f", bill]);
    NSLog([NSString stringWithFormat:@"PERCENTAGE SET UP VALUE$%f", percentage]);
    NSLog([NSString stringWithFormat:@"TIP SET UP VALUE$%f", tip]);
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"View did appear");
    NSUserDefaults *defaultForPercentage = [NSUserDefaults standardUserDefaults];
    double newTip = [defaultForPercentage doubleForKey:@"default_tip_percentage"];
     NSLog([NSString stringWithFormat:@"TIP APPEAR%f", newTip]);
    double curBill = [self.billField.text doubleValue];
    
    [self setUpValues:curBill percentage:newTip];
}
@end
