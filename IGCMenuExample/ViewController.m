//
//  ViewController.m
//  IGCMenuExample
//
//  Created by Apple on 15/02/16.
//  Copyright (c) 2016 Sunil Sharma. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    BOOL isMenuActive;
    IGCMenu *igcMenu;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isMenuActive = NO;
    [self setupMenu];
}

-(void)setupMenu{
    self.menuButton.clipsToBounds = YES;
    self.menuButton.layer.cornerRadius = self.menuButton.frame.size.height / 2;
    //Grid menu setup;
    if (igcMenu == nil) {
        igcMenu = [[IGCMenu alloc] init];
    }
    igcMenu.menuButton = self.menuButton;   //Pass refernce of menu button
    igcMenu.menuSuperView = self.view;      //Pass reference of menu button super view
    igcMenu.disableBackground = YES;        //Enable/disable menu background
    igcMenu.numberOfMenuItem = 5;           //Number of menu items to display
    
    //Menu background. It can be BlurEffectExtraLight,BlurEffectLight,BlurEffectDark,Dark or None
    igcMenu.backgroundType = BlurEffectDark;
    //Menu position style on Top or Bottom of menu button, default is Top
    //igcMenu.positionStyle = Bottom;
    
    /* Optional
     Pass name of menu items
     **/
    igcMenu.menuItemsNameArray = [NSArray arrayWithObjects:@"Home",@"Like",@"Search",@"User",@"Buy",nil];
    
    /*Optional
     Pass color of menu items
     **/
    UIColor *homeBackgroundColor = [UIColor colorWithRed:(33/255.0) green:(180/255.0) blue:(227/255.0) alpha:1.0];
    UIColor *searchBackgroundColor = [UIColor colorWithRed:(139/255.0) green:(116/255.0) blue:(240/255.0) alpha:1.0];
    UIColor *favoritesBackgroundColor = [UIColor colorWithRed:(241/255.0) green:(118/255.0) blue:(121/255.0) alpha:1.0];
    UIColor *userBackgroundColor = [UIColor colorWithRed:(184/255.0) green:(204/255.0) blue:(207/255.0) alpha:1.0];
    UIColor *buyBackgroundColor = [UIColor colorWithRed:(169/255.0) green:(59/255.0) blue:(188/255.0) alpha:1.0];
    igcMenu.menuBackgroundColorsArray = [NSArray arrayWithObjects:homeBackgroundColor,favoritesBackgroundColor,searchBackgroundColor,userBackgroundColor, buyBackgroundColor,nil];
    
    /*Optional
     Pass menu items icons
     **/
    igcMenu.menuImagesNameArray = [NSArray arrayWithObjects:@"home.png",@"favourite.png",@"search.png",@"user.png",@"buy.png",nil];
    
    /*Optional if you don't want to get notify for menu items selection
     conform delegate
     **/
    igcMenu.delegate = self;
}
- (IBAction)menuButtonPressed:(id)sender {
    if (isMenuActive) {
        [self.menuButton setImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
        if (self.menuTypeSwitch.isOn) {
            [igcMenu hideGridMenu];
        }
        else{
            [igcMenu hideCircularMenu];
        }
        isMenuActive = NO;
    }
    else{
        [self.menuButton setImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
        if (self.menuTypeSwitch.isOn) {
            [igcMenu showGridMenu];
        }
        else{
            [igcMenu showCircularMenu];
        }
        isMenuActive = YES;
    }
}

- (void)igcMenuSelected:(NSString *)selectedMenuName atIndex:(NSInteger)index{
    NSLog(@"selected menu name = %@ at index = %ld",selectedMenuName,(long)index);
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"%@ at index %ld is selected",selectedMenuName,(long)index] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
    
    switch (index) {
        case 0:
            //Perform any action that u want on menu selection
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

