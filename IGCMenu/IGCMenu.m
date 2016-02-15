//
//  IGCMenu.m
//  IGCMenu
//
//  Created by Sunil Sharma on 11/02/16.
//  Copyright (c) 2016 Sunil Sharma. All rights reserved.
//

#import "IGCMenu.h"
#import <QuartzCore/QuartzCore.h>

#define MENU_START_TAG(offset) (6000 + offset)
#define MENU_NAME_LABEL_TAG(offset) (6100 + offset)
#define ANIMATION_DURATION 0.4
#define MENU_BACKGROUND_VIEW_TAG 6200

@implementation IGCMenu{
    NSMutableArray *menuButtonArray;        //array of menu buttons
    NSMutableArray *menuNameLabelArray;     //array of menu name label
    UIView *pMenuButtonSuperView;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        menuButtonArray = [[NSMutableArray alloc] init];
        menuNameLabelArray = [[NSMutableArray alloc] init];
        //Default values
        self.disableBackground = YES;
        self.numberOfMenuItem = 0;
        self.menuRadius = 120;
        self.maxColumn = 3;
    }
    return self;
}

- (void)createMenuButtons{
    [menuButtonArray removeAllObjects];
    [menuNameLabelArray removeAllObjects];
    for (int i = 0; i < self.numberOfMenuItem; i++) {
        
        UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        menuButton.backgroundColor = [UIColor whiteColor];
        menuButton.tag = MENU_START_TAG(i);
        CGRect newFrame = menuButton.frame;
        CGFloat menuButtonSize;
        if (self.menuHeight) {
            menuButtonSize = self.menuHeight;
        }
        else{
            menuButtonSize = self.menuHeight = 65;
        }
        newFrame.size = CGSizeMake(menuButtonSize, menuButtonSize);
        menuButton.frame = newFrame;
        
        menuButton.center = self.menuButton.center;
        menuButton.layer.cornerRadius = menuButton.frame.size.height / 2;
        menuButton.layer.masksToBounds = YES;
        menuButton.layer.opacity = 0.0;
        [menuButton addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [pMenuButtonSuperView insertSubview:menuButton belowSubview:self.menuButton];
        [menuButtonArray addObject:menuButton];
        //Display menu name if present
        if (self.menuItemsNameArray.count > i) {
            UILabel *menuNameLabel = [[UILabel alloc] init];
            menuNameLabel.backgroundColor = [UIColor clearColor];
            menuNameLabel.numberOfLines = 1;
            newFrame = menuNameLabel.frame;
            newFrame.size = CGSizeMake(menuButton.frame.size.width, 20);
            menuNameLabel.frame = newFrame;
            menuNameLabel.center = menuButton.center;
            menuNameLabel.layer.opacity = 0.0;
            menuNameLabel.textAlignment = NSTextAlignmentCenter;
            menuNameLabel.font = [UIFont systemFontOfSize:12];
            menuNameLabel.text = self.menuItemsNameArray[i];
            [menuNameLabel sizeToFit];
            menuNameLabel.textColor = [UIColor whiteColor];
            [pMenuButtonSuperView insertSubview:menuNameLabel belowSubview:self.menuButton];
            [menuNameLabelArray addObject:menuNameLabel];
        }
        
        //Set custom menus button background color if present
        if (self.menuBackgroundColorsArray.count > i) {
            menuButton.backgroundColor =(UIColor *)self.menuBackgroundColorsArray[i];
        }
        
        //Display menu images if present
        if (self.menuImagesNameArray.count > i) {
            [menuButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.menuImagesNameArray[i]]] forState:UIControlStateNormal];
        }
    }
}

- (void)menuSuperViewBackground{
        if (pMenuButtonSuperView == nil) {
            pMenuButtonSuperView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            pMenuButtonSuperView.tag = MENU_BACKGROUND_VIEW_TAG;
        }
        if (!self.menuSuperView) {
            self.menuSuperView = [self.menuButton superview];
        }
        [self.menuSuperView bringSubviewToFront:self.menuButton];
        [self.menuSuperView insertSubview:pMenuButtonSuperView belowSubview:self.menuButton];
    if (self.disableBackground) {
        pMenuButtonSuperView.userInteractionEnabled = YES;
        pMenuButtonSuperView.layer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8].CGColor;
    }
    else{
        pMenuButtonSuperView.userInteractionEnabled = NO;
        pMenuButtonSuperView.layer.backgroundColor = [UIColor clearColor].CGColor;
    }
}

- (void)showCircularMenu{
    
    [self menuSuperViewBackground];
    
    if (menuButtonArray.count <= 0) {
        [self createMenuButtons];
    }
    //menuButton.center = CGPointMake(homeButtonCenter.x - radius * cos(angle * i), homeButtonCenter.y - radius * sin(angle * i));
    
    for (int  i = 1; i < menuButtonArray.count * 2; i=i+2) {
        
        CGFloat angle = M_PI / (menuButtonArray.count * 2);
        [UIView animateWithDuration:ANIMATION_DURATION delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            pMenuButtonSuperView.layer.opacity = 1.0;
            UIButton * menuButton = (UIButton *)[menuButtonArray objectAtIndex:i/2];
            menuButton.layer.opacity = 1.0;
            menuButton.center = CGPointMake(self.menuButton.center.x - self.menuRadius * cos(angle * i), self.menuButton.center.y - self.menuRadius * sin(angle * i));
            if (menuNameLabelArray.count > (i/2)) {
                UILabel *menuNameLabel = (UILabel *)[menuNameLabelArray objectAtIndex:i/2];
                menuNameLabel.layer.opacity = 1.0;
                menuNameLabel.center = CGPointMake(menuButton.center.x, menuButton.frame.origin.y + menuButton.frame.size.height  + (menuNameLabel.frame.size.height / 2) + 5);
            }
        }completion:nil];
    }
}

- (void)hideCircularMenu{
    [UIView animateWithDuration:ANIMATION_DURATION delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        for (int i = 0; i < menuButtonArray.count; i++) {
            UIButton *menuButton = (UIButton *)[menuButtonArray objectAtIndex:i];
            menuButton.layer.opacity = 0.0;
            menuButton.center = self.menuButton.center;
            if (menuNameLabelArray.count > i) {
                UILabel *menuNameLabel = (UILabel *)[menuNameLabelArray objectAtIndex:i];
                menuNameLabel.layer.opacity = 0.0;
                menuNameLabel.center = self.menuButton.center;
                pMenuButtonSuperView.layer.opacity = 0.0;
            }
        }
    } completion:^(BOOL finished) {
        
        [pMenuButtonSuperView removeFromSuperview];
        for (int i = 0; i < menuButtonArray.count; i++) {
            UIButton *menuButton = (UIButton *)[menuButtonArray objectAtIndex:i];
            [menuButton removeFromSuperview];
            if (menuNameLabelArray.count > i) {
                UILabel *menuNameLabel = (UILabel *)[menuNameLabelArray objectAtIndex:i];
                [menuNameLabel removeFromSuperview];
            }
        }
        [menuNameLabelArray removeAllObjects];
        [menuButtonArray removeAllObjects];
    }];
}

-(void)showGridMenu{
    [self menuSuperViewBackground];
    if (menuButtonArray.count <= 0) {
        [self createMenuButtons];
    }
    
    int maxRow = ceilf(menuButtonArray.count /(float)self.maxColumn);
    __block CGFloat topMenuCenterY = self.menuButton.frame.origin.y - 10;
    CGFloat eachMenuVerticalSpace = 0;
    CGFloat eachMenuWidth = 0;
    if (menuButtonArray.count) {
        UIButton *menuButton = (UIButton *)menuButtonArray[0];
        eachMenuVerticalSpace = menuButton.frame.size.height + 20;
        eachMenuWidth = menuButton.frame.size.width;
        if (menuNameLabelArray.count) {
            UILabel *nameLabel = (UILabel *)menuNameLabelArray[0];
            eachMenuVerticalSpace = eachMenuVerticalSpace + nameLabel.frame.size.height;
        }
        topMenuCenterY = topMenuCenterY - (eachMenuVerticalSpace * maxRow) + menuButton.frame.size.height/2;
    }
    else{
        eachMenuVerticalSpace = 100.0;
        topMenuCenterY = topMenuCenterY - (eachMenuVerticalSpace * maxRow) + eachMenuVerticalSpace/3;
    }
    
    __block CGFloat distanceBetweenMenu = ((pMenuButtonSuperView.frame.size.width - (self.maxColumn*eachMenuWidth))/(self.maxColumn +1));
    
    [UIView animateWithDuration:ANIMATION_DURATION delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        pMenuButtonSuperView.layer.opacity = 1.0;
        
        int menuIndex = 0;
        //for each row
        for(int  i = 1; i <= maxRow; i++,topMenuCenterY += eachMenuVerticalSpace) {
            
            int remainingMenuButton = self.maxColumn;
            //CGFloat menuCenterX = distanceBetweenMenu;
            
            CGFloat menuCenterX;
            //for each column
            for (int j = 1; j <= remainingMenuButton; j++) {
                UIButton *menuButton = (UIButton *)[menuButtonArray objectAtIndex:menuIndex];
                menuButton.layer.opacity = 1.0;
                
                menuCenterX = (distanceBetweenMenu *j) + (2*j - 1)*(menuButton.frame.size.width/2);
                if (i == maxRow) {
                    remainingMenuButton = menuButtonArray.count % self.maxColumn;
                    if (remainingMenuButton == 0) {
                        remainingMenuButton = self.maxColumn;
                    }
                    menuCenterX = menuCenterX + ((self.maxColumn - remainingMenuButton)*(distanceBetweenMenu/2)) + (self.maxColumn - remainingMenuButton)*menuButton.frame.size.width/2;
                }
                menuButton.center = CGPointMake(menuCenterX, topMenuCenterY);
                
                if (menuNameLabelArray.count > menuIndex) {
                    UILabel *menuNameLabel = (UILabel *)[menuNameLabelArray objectAtIndex:menuIndex];
                    menuNameLabel.layer.opacity = 1.0;
                    menuNameLabel.center = CGPointMake(menuButton.center.x, menuButton.frame.origin.y + menuButton.frame.size.height  + (menuNameLabel.frame.size.height / 2) + 5);
                }
                
                menuIndex++;
            }
        }
    }completion:nil];
}

-(void)hideGridMenu{
    [self hideCircularMenu];
}

- (void)menuButtonClicked:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(igcMenuSelected:atIndex:)]) {
    int index;
    NSInteger buttonTag =  sender.tag;
    for (index = 0; index < menuButtonArray.count; index++) {
        UIButton *menuButton = (UIButton *)[menuButtonArray objectAtIndex:index];
        if (menuButton.tag == buttonTag) {
            NSString *menuName;
            if (self.menuItemsNameArray.count > index) {
                menuName = self.menuItemsNameArray[index];
            }
            if (self.delegate) {
                [self.delegate igcMenuSelected:menuName atIndex:index];
            }
            break;
        }
    }
}
}


@end
