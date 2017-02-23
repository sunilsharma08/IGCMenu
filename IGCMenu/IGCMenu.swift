//
//  IGCMenu.swift
//  IGCMenuSwiftExample
//
//  Created by Sunil Sharma on 15/01/17.
//  Copyright © 2017 Sunil Sharma. All rights reserved.
//


import UIKit
import QuartzCore

enum IGCMenuBackgroundOptions {
    case BlurEffectExtraLight
    case BlurEffectLight
    case BlurEffectDark
    case Dark
    case None
}

@objc protocol IGCMenuDelegate {
    @objc optional func igcMenuSelected(selectedMenuName: String, atIndex index: Int)
}

class IGCMenu : NSObject {
    
    public weak var delegate: IGCMenuDelegate?
    public var numberOfMenuItem: Int = 0               //Number of menu items to show
    public var menuRadius: CGFloat = 120               //Radius for circular menu
    public weak var menuButton: UIButton?              //Menu button reference
    public weak var menuSuperView: UIView?             //Menu button super view reference
    public var menuItemsNameArray: [String]?           //Menu items name array,it can be empty
    public var menuBackgroundColorsArray: [UIColor]?   //Menu items background color,it can be empty, default color is white
    public var menuImagesNameArray: [String]?          //Menu item icons array it can be empty
    public var disableBackground:Bool = true           //Disable background view, default is TRUE
    public var maxColumn: Int = 3                      //Maximium number of column,default is 3
    public var menuHeight: Int = 65                    //height = width ,default is 65
    public var backgroundType: IGCMenuBackgroundOptions = .BlurEffectDark  //Default is BlurEffectDark
    
    private let ANIMATION_DURATION = 0.4
    private let MENU_BACKGROUND_VIEW_TAG = 6200
    private var menuButtonArray = [UIButton]()      //array of menu buttons
    private var menuNameLabelArray = [UILabel]()    //array of menu name label
    private var pMenuButtonSuperView: UIView?
    
    private func createMenuButtons() {
        menuButtonArray.removeAll()
        menuNameLabelArray.removeAll()
        
        for i in 0..<self.numberOfMenuItem {
            
            let menuButton = UIButton(type: .custom)
            menuButton.backgroundColor = UIColor.white
            menuButton.tag = menuStartTag(offset: i)
            
            if self.menuHeight == 0 {
                self.menuHeight = 65
            }
            
            menuButton.frame.size = CGSize(width: self.menuHeight, height: self.menuHeight)
            
            guard let mainMenuButton = self.menuButton else {
                return
            }
            menuButton.center = mainMenuButton.center
            menuButton.layer.cornerRadius = menuButton.frame.size.height/2
            menuButton.layer.masksToBounds = true
            menuButton.layer.opacity = 0
            menuButton.addTarget(self, action:#selector(IGCMenu.menuButtonClicked(sender:)), for: .touchUpInside)
            pMenuButtonSuperView?.insertSubview(menuButton, belowSubview: mainMenuButton)
            menuButtonArray.append(menuButton)
            
            //Display menu name if present
            if (self.menuItemsNameArray ?? []).count > i {
                let menuNameLabel = UILabel()
                menuNameLabel.backgroundColor = UIColor.clear
                menuNameLabel.numberOfLines = 1
                menuNameLabel.frame.size = CGSize(width: CGFloat(menuButton.frame.size.width), height: CGFloat(20))
                menuNameLabel.center = menuButton.center
                menuNameLabel.layer.opacity = 0.0
                menuNameLabel.textAlignment = .center
                menuNameLabel.font = UIFont.systemFont(ofSize: CGFloat(12))
                menuNameLabel.text = self.menuItemsNameArray?[i]
                menuNameLabel.sizeToFit()
                menuNameLabel.textColor = UIColor.white
                pMenuButtonSuperView?.insertSubview(menuNameLabel, belowSubview: mainMenuButton)
                menuNameLabelArray.append(menuNameLabel)
            }
            
            //Set custom menus button background color if present
            if let menuBackgroundColorsArray = self.menuBackgroundColorsArray,menuBackgroundColorsArray.count > i {
                menuButton.backgroundColor = menuBackgroundColorsArray[i]
            }
            
            //Display menu images if present
            if let menuImagesNameArray = self.menuImagesNameArray, menuImagesNameArray.count > i{
                let buttonImage = UIImage(named: menuImagesNameArray[i])
                menuButton.setImage(buttonImage, for: .normal)
            }
        }
    }
    
    private func menuSuperViewBackground() {
        if pMenuButtonSuperView == nil {
            pMenuButtonSuperView = UIView(frame: UIScreen.main.bounds)
            pMenuButtonSuperView?.tag = MENU_BACKGROUND_VIEW_TAG
        }
        if self.menuSuperView == nil {
            self.menuSuperView = self.menuButton?.superview
        }
        if let mainMenuButton = self.menuButton {
            self.menuSuperView?.bringSubview(toFront: mainMenuButton)
            self.menuSuperView?.insertSubview(pMenuButtonSuperView!, belowSubview: mainMenuButton)
        }
        else {
            assertionFailure("Menu button reference is nil")
        }
        if self.disableBackground {
            pMenuButtonSuperView?.isUserInteractionEnabled = true
        }
        else{
            pMenuButtonSuperView?.isUserInteractionEnabled = false
        }
        self.setBackgroundEffect()
    }
    
    func setBackgroundEffect() {
        switch self.backgroundType {
        case .Dark:
            pMenuButtonSuperView?.layer.backgroundColor = UIColor.black.withAlphaComponent(0.8).cgColor
        case .BlurEffectDark:
            self.setBlurredView(blurEffectStyle: .dark)
        case .BlurEffectLight:
            self.setBlurredView(blurEffectStyle: .light)
        case .BlurEffectExtraLight:
            self.setBlurredView(blurEffectStyle: .extraLight)
        case .None:
            pMenuButtonSuperView?.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func setBlurredView(blurEffectStyle:UIBlurEffectStyle) {
        if !UIAccessibilityIsReduceMotionEnabled() {
            let blurEffect = UIBlurEffect(style: blurEffectStyle)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = (pMenuButtonSuperView?.bounds ?? CGRect.zero)
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            pMenuButtonSuperView?.addSubview(blurEffectView)
        }
        else {
            pMenuButtonSuperView?.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    
    func showCircularMenu() {
        self.menuSuperViewBackground()
        self.createMenuButtons()
        
        var i = 1
        while i < (menuButtonArray.count * 2) {
            let angle: CGFloat = CGFloat(M_PI) / CGFloat(menuButtonArray.count * 2)
            UIView.animate(withDuration: ANIMATION_DURATION, delay: 0, options: .curveEaseInOut, animations: {
                self.pMenuButtonSuperView?.layer.opacity = 1.0
                let menuButton = self.menuButtonArray[i/2]
                menuButton.layer.opacity = 1.0
                
                if let mainMenuButton = self.menuButton {
                    let centerX: CGFloat = mainMenuButton.center.x - self.menuRadius * cos(angle * CGFloat(i))
                    let centerY: CGFloat = mainMenuButton.center.y - self.menuRadius * sin(angle * CGFloat(i))
                    menuButton.center = CGPoint(x: centerX, y: centerY)
                }
                
                if  self.menuNameLabelArray.count > (i/2){
                    let menuNameLabel = self.menuNameLabelArray[i/2]
                    menuNameLabel.layer.opacity = 1.0
                    menuNameLabel.center = CGPoint(x: menuButton.center.x, y: menuButton.frame.origin.y + menuButton.frame.size.height  + (menuNameLabel.frame.size.height / 2) + 5)
                }
            }, completion: nil)
            i = i+2
        }
    }
    
    func hideCircularMenu(){
        UIView.animate(withDuration: ANIMATION_DURATION, delay: 0, options: .curveEaseInOut, animations: {
            for i in 0..<self.menuButtonArray.count {
                let menuButton = self.menuButtonArray[i]
                menuButton.layer.opacity = 0
                if let mainMenuButton = self.menuButton {
                    menuButton.center = mainMenuButton.center
                    if self.menuNameLabelArray.count > i{
                        let menuNameLabel = self.menuNameLabelArray[i]
                        menuNameLabel.layer.opacity = 0
                        menuNameLabel.center = mainMenuButton.center
                    }
                }
            }
            self.pMenuButtonSuperView?.layer.opacity = 0
        }) { (finished) in
            self.pMenuButtonSuperView?.removeFromSuperview()
            self.pMenuButtonSuperView = nil
            for i in 0..<self.menuButtonArray.count {
                let menuButton = self.menuButtonArray[i]
                menuButton.removeFromSuperview()
                if self.menuNameLabelArray.count > i{
                    let menuNameLabel = self.menuNameLabelArray[i]
                    menuNameLabel.removeFromSuperview()
                }
            }
            self.menuNameLabelArray.removeAll()
            self.menuButtonArray.removeAll()
        }
    }
    
    func showGridMenu(){
        self.menuSuperViewBackground()
        self.createMenuButtons()
        
        let maxRow: Int = Int(ceilf(Float(menuButtonArray.count) / Float(self.maxColumn)))
        var topMenuCenterY: CGFloat = 0.0
        if let mainMenuButton = self.menuButton {
            topMenuCenterY = mainMenuButton.frame.origin.y - 10
        }
        var eachMenuVerticalSpace: CGFloat = 0
        var eachMenuWidth: CGFloat = 0
        
        if menuButtonArray.count > 0{
            let menuButton = menuButtonArray[0]
            eachMenuVerticalSpace = menuButton.frame.size.height + 20
            eachMenuWidth = menuButton.frame.size.width
            
            if menuNameLabelArray.count > 0 {
                let nameLabel = menuNameLabelArray[0]
                eachMenuVerticalSpace = eachMenuVerticalSpace + nameLabel.frame.size.height
            }
            topMenuCenterY = topMenuCenterY - (eachMenuVerticalSpace * CGFloat(maxRow)) + menuButton.frame.size.height/2
        }
        else {
            eachMenuVerticalSpace = 100
            topMenuCenterY = topMenuCenterY - (eachMenuVerticalSpace * CGFloat(maxRow)) + eachMenuVerticalSpace/3
        }
        
        let distanceBetweenMenu: CGFloat = ((pMenuButtonSuperView!.frame.size.width - (CGFloat(self.maxColumn) * eachMenuWidth))/CGFloat(self.maxColumn + 1));
        
        
        UIView.animate(withDuration: ANIMATION_DURATION, delay: 0, options: .curveEaseInOut, animations: {
            self.pMenuButtonSuperView?.layer.opacity = 1
            var menuIndex = 0
            
            //for each row
            var i = 1
            while i <= maxRow {
                var remainingMenuButton = self.maxColumn
                var menuCenterX: CGFloat
                
                //for each column
                var j = 1
                while j <= remainingMenuButton {
                    let menuButton = self.menuButtonArray[menuIndex]
                    menuButton.layer.opacity = 1.0
                    
                    let menuButtonWidth = menuButton.frame.size.width
                    menuCenterX = (distanceBetweenMenu * CGFloat(j)) + CGFloat(2 * j - 1) * (menuButtonWidth/2.0)
                    
                    if i == maxRow {
                        remainingMenuButton = self.menuButtonArray.count % self.maxColumn
                        if remainingMenuButton == 0 {
                            remainingMenuButton = self.maxColumn
                        }
                        menuCenterX = menuCenterX + CGFloat(self.maxColumn - remainingMenuButton) * (distanceBetweenMenu / CGFloat(2)) + CGFloat(self.maxColumn - remainingMenuButton) * menuButton.frame.size.width / CGFloat(2)
                    }
                    menuButton.center = CGPoint(x: CGFloat(menuCenterX), y: CGFloat(topMenuCenterY))
                    if self.menuNameLabelArray.count > menuIndex {
                        let menuNameLabel = self.menuNameLabelArray[menuIndex]
                        menuNameLabel.layer.opacity = 1.0
                        menuNameLabel.center = CGPoint(x: CGFloat(menuButton.center.x), y: CGFloat(menuButton.frame.origin.y + menuButton.frame.size.height + (menuNameLabel.frame.size.height / 2) + 5))
                    }
                    menuIndex += 1
                    j += 1
                }
                i += 1
                topMenuCenterY = topMenuCenterY + eachMenuVerticalSpace
            }
            
        }, completion: nil)
    }
    
    func hideGridMenu(){
        self.hideCircularMenu()
    }
    
    @objc private func menuButtonClicked(sender : UIButton){
        if self.delegate != nil {
            let buttonTag = sender.tag
            for index in 0..<menuButtonArray.count {
                let menuButton = menuButtonArray[index]
                if menuButton.tag == buttonTag {
                    var menuName: String = ""
                    if let menuItemsNameArray = self.menuItemsNameArray{
                        if menuItemsNameArray.count > index{
                            menuName = menuItemsNameArray[index]
                        }
                    }
                    self.delegate?.igcMenuSelected?(selectedMenuName: menuName, atIndex: index)
                    break
                }
            }
        }
    }
    
    private func menuStartTag(offset: Int) -> Int{
        return (6000 + offset)
    }
    
    private func menuNameLabeltag(offset: Int) -> Int{
        return (6200 + offset)
    }
}
