//
//  ViewController.h
//  IGCMenuExample
//
//  Created by Apple on 15/02/16.
//  Copyright (c) 2016 Sunil Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGCMenu.h"

@interface ViewController : UIViewController<IGCMenuDelegate>

@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UISwitch *menuTypeSwitch;

@end

