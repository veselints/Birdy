//
//  DetailViewController.m
//  BirdyApplication
//
//  Created by veso on 1/31/16.
//  Copyright © 2016 veso. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Birdy" style:UIBarButtonItemStylePlain
                                                                     target:self action:@selector(goBirdyHome:)];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goBirdyHome:(UIButton *)sender
{	
    if (!self.splitViewController.collapsed) {
        [(UINavigationController *)self.splitViewController.viewControllers[0]
         popToRootViewControllerAnimated:YES];
    }
}

@end
