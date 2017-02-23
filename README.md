# IGCMenu
IGCMenu library gives easy way to create **Grid** and **Circular** menu in app.

This is light weight and highly customisable menu.Support iOS 7 and above.

<table>
  <tr>
    <th>Grid Menu</th>
    <th>Circular Menu</th>
  </tr>
  <tr>
    <td><img src="https://raw.githubusercontent.com/sunilsharma08/IGCMenu/develop/Grid_Menu_Demo.gif" alt="Grid Menu" width="320" height="568"/></td>
    <td><img src="https://raw.githubusercontent.com/sunilsharma08/IGCMenu/develop/Circular_Menu_Demo.gif" alt="Circular Menu" width="320" height="568"/></td>
  </tr>
</table>

#Features
* Grid Menu
* Circular Menu
* Enable/Diable menu background
* Menu items can be without images/names


#How to use

Drag the folder "IGCMenu" with the source files into your project.
 
##Conform Protocol
 **Optional** if you don't want to get notify for menu items selection then skip this step.
 
 Conform to IGCMenuDelegate
 
 ```swift
 class ViewController: UIViewController, IGCMenuDelegate
 ```
 
##Create Instance Variable

Create instance variable of type IGCMenu.

```swift
var igcMenu: IGCMenu?
```
##Create instance of class IGCMenu and configure attributes

```swift
   //Grid menu setup
   igcMenu = IGCMenu()
   igcMenu?.menuButton = self.menuButton   //Grid menu setup
   igcMenu?.menuSuperView = self.view      //Pass reference of menu button super view
   igcMenu?.disableBackground = true       //Enable/disable menu background
   igcMenu?.numberOfMenuItem = 5           //Number of menu items to display
        
   /* Optional
   Pass name of menu items
   **/
   igcMenu?.menuItemsNameArray = ["Home", "Like", "Search", "User", "Buy"]
        
   /*Optional
   Pass color of menu items
   **/
   let homeBackgroundColor = UIColor(colorLiteralRed: (33/255.0), green: (180/255.0), blue: (227/255.0), alpha: 1.0)
   let searchBackgroundColor = UIColor(colorLiteralRed: (139/255.0), green: (116/255.0), blue: (240/255.0), alpha: 1.0)
   let favoritesBackgroundColor = UIColor(colorLiteralRed: (241/255.0), green: (118/255.0), blue: (121/255.0), alpha: 1.0)
   let userBackgroundColor = UIColor(colorLiteralRed: (184/255.0), green: (204/255.0), blue: (207/255.0), alpha: 1.0)
   let buyBackgroundColor = UIColor(colorLiteralRed: (169/255.0), green: (59/255.0), blue: (188/255.0), alpha: 1.0)
   igcMenu?.menuBackgroundColorsArray = [homeBackgroundColor, searchBackgroundColor, favoritesBackgroundColor, userBackgroundColor, buyBackgroundColor]
        
   /*Optional
   Pass menu items icons
   **/
   igcMenu?.menuImagesNameArray = ["home.png", "favourite.png", "search.png", "user.png", "buy.png"]
        
   /*Optional
   if you don't want to get notify for menu items selection conform delegate
   **/
   igcMenu?.delegate = self
```
Array of name,color and icons will appear in the same order.

##Show/Hide menu

On menu button press you can show/hide menu items by calling methods below.

To show/hide **circular menu**
```swift
igcMenu?.showCircularMenu()  //Show circular menu
igcMenu?.hideCircularMenu()  //Hide circular menu
```
To show/hide **grid menu**
```swift
igcMenu?.showGridMenu()     //Show grid menu
igcMenu?.hideGridMenu()     //Hide grid menu
```

##Delegate Implementation
To get notify about menu item selection you must implement this method.
```swift
func igcMenuSelected(selectedMenuName: String, atIndex index: Int) {
//Perform any action on selection of menu item
}
```
On selecting any menu item it gives selected menu item name(if present otherwise nil) and index of menu item.Index of menu item start from 0.

#Customisations
```swift
public var numberOfMenuItem: Int         //Number of menu items to show
public var menuRadius: CGFloat           //Radius for circular menu,default is 120
public weak var menuButton: UIButton?    //Menu button reference
public weak var menuSuperView: UIView?   //Menu button super view reference
public var menuItemsNameArray: [String]?         //Menu items name array,it can be empty
public var menuBackgroundColorsArray: [UIColor]? //Menu items background color,it can be empty, default color is white
public var menuImagesNameArray: [String]?        //Menu item icons array it can be empty
public var disableBackground              //Disable background view, default is TRUE
public var maxColumn: Int                 //Maximium number of column,default is 3
public var menuHeight: Int                //height = width ,default is 65

```
#Note
This library does not customise menu button(in example at bottom in dark blue background color) like making round,setting background color,changing icon like + and x.
This is left on you to customise.You can take refernce form example if any help needed.
Code to make button circle is:
```swift
self.menuButton.clipsToBounds = true
self.menuButton.layer.cornerRadius = self.menuButton.frame.size.height / 2
```

#Let us know!

We will be happy if you sent us links to your projects where you use our library. And do let us know if you have any questions or suggestion regarding anything.

#License
IGCMenu is available under the [MIT license](https://raw.githubusercontent.com/sunilsharma08/IGCMenu/develop/LICENSE.md).
