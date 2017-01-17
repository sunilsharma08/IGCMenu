//
//  ViewController.swift
//  IGCMenuSwiftExample
//
//  Created by Apple on 15/01/17.
//  Copyright © 2017 Sunil Sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, IGCMenuDelegate {

    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var menuTypeSwitch: UISwitch!
    
    var isMenuActive = false
    var igcMenu: IGCMenu?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenu()
    }
    
    func setupMenu(){
        self.menuButton.clipsToBounds = true
        self.menuButton.layer.cornerRadius = self.menuButton.frame.size.height / 2
        
        if igcMenu == nil{
            igcMenu = IGCMenu()
        }
        igcMenu?.menuButton = self.menuButton
        igcMenu?.menuSuperView = self.view
        igcMenu?.disableBackground = true
        igcMenu?.numberOfMenuItem = 5
        
        //Optional
        igcMenu?.menuItemsNameArray = ["Home", "Like", "Search", "User", "Buy"]
        let homeBackgroundColor = UIColor(colorLiteralRed: (33/255.0), green: (180/255.0), blue: (227/255.0), alpha: 1.0)
        let searchBackgroundColor = UIColor(colorLiteralRed: (139/255.0), green: (116/255.0), blue: (240/255.0), alpha: 1.0)
        let favoritesBackgroundColor = UIColor(colorLiteralRed: (241/255.0), green: (118/255.0), blue: (121/255.0), alpha: 1.0)
        let userBackgroundColor = UIColor(colorLiteralRed: (184/255.0), green: (204/255.0), blue: (207/255.0), alpha: 1.0)
        let buyBackgroundColor = UIColor(colorLiteralRed: (169/255.0), green: (59/255.0), blue: (188/255.0), alpha: 1.0)
        igcMenu?.menuBackgroundColorsArray = [homeBackgroundColor, searchBackgroundColor, favoritesBackgroundColor, userBackgroundColor, buyBackgroundColor]
        igcMenu?.menuImagesNameArray = ["home.png", "favourite.png", "search.png", "user.png", "buy.png"]
        igcMenu?.delegate = self
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        if isMenuActive{
            self.menuButton.setImage(UIImage(named: "plus.png"), for: .normal)
            self.menuTypeSwitch.isOn ? igcMenu?.hideGridMenu() : igcMenu?.hideCircularMenu()
            isMenuActive = false
        }else{
            self.menuButton.setImage(UIImage(named: "cross.png"), for: .normal)
            self.menuTypeSwitch.isOn ? igcMenu?.showGridMenu() : igcMenu?.showCircularMenu()
            isMenuActive = true
        }
    }
    
    
    func igcMenuSelected(selectedMenuName: String, atIndex index: Int) {
        UIAlertView(title: "", message: "\(selectedMenuName) at index \(index) is selected.", delegate: nil, cancelButtonTitle: "Ok").show()
        
        switch index {
        case 0:
            //perform any action
            break
        default:
            break
        }
    }
    


}

