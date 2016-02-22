//
//  IGCMenu.h
//  IGCMenu
//
//  Created by Sunil Sharma on 11/02/16.
//  Copyright (c) 2016 Sunil Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol IGCMenuDelegate <NSObject>

@optional
-(void)igcMenuSelected:(NSString *)selectedMenuName atIndex:(NSInteger)index;

@end

@interface IGCMenu : NSObject

@property (weak) id <IGCMenuDelegate>delegate;

@property (nonatomic) NSInteger numberOfMenuItem;   //Number of menu items to show
@property (nonatomic) CGFloat menuRadius;           //Radius for circular menu
@property (weak,nonatomic) UIButton *menuButton;    //Menu button reference
@property (weak,nonatomic) UIView *menuSuperView;   //Menu button super view reference
@property (strong,nonatomic) NSArray *menuItemsNameArray;        //Menu items name array,it can be empty
@property (strong,nonatomic) NSArray *menuBackgroundColorsArray; //Menu items background color,it can be empty, default color is white
@property (strong,nonatomic) NSArray *menuImagesNameArray;       //Menu item icons array it can be empty
@property (nonatomic) BOOL disableBackground;       //Disable background view, default is TRUE
@property int maxColumn;                            //Maximium number of column,default is 3
@property int menuHeight;                           //height = width ,default is 65

-(void)showCircularMenu;
-(void)hideCircularMenu;
-(void)showGridMenu;
-(void)hideGridMenu;

@end
