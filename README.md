# IGCMenu
IGCMenu library gives easy way to create **Grid** and **Circular** menu in app.

This is light weight and highly customisable.

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

##Import
 ```objc
 #import "IGCMenu.h"
 ```
 
##Conform Protocol
 **Optional** if you don't want to get notify for menu items selection then skip this step.
 
 Conform to IGCMenuDelegate
 
 ```objc
 @interface ViewController : UIViewController<IGCMenuDelegate>
 ```
 
##Create Instance Variable

Create instance variable of type IGCMenu.

```objc
@implementation ViewController{
    IGCMenu *igcMenu;
}
```
##Create instance of class IGCMenu and configure attributes

```objc
if (igcMenu == nil) {
      igcMenu = [[IGCMenu alloc] init];
  }
  igcMenu.menuButton = self.menuButton;   //Pass refernce of menu button
  igcMenu.menuSuperView = self.view;      //Pass reference of menu button super view
  igcMenu.disableBackground = YES;        //Enable/disable menu background
  igcMenu.numberOfMenuItem = 5;           //Number of menu items to display

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
```
Array of name,color and icons will appear in the same order.

##Show/Hide menu

On menu button press you can show/hide menu items by calling methods below.

To show/hide **circular menu**
```objc
[igcMenu showCircularMenu];  //Show circular menu
[igcMenu hideCircularMenu];  //Hide circular menu
```
To show/hide **grid menu**
```objc
[igcMenu showGridMenu];     //Show grid menu
[igcMenu hideGridMenu];     //Hide grid menu
```

##Delegate Implementation
To get notify about menu item selection you must implement this method.
```objc
- (void)igcMenuSelected:(NSString *)selectedMenuName atIndex:(NSInteger)index{
//Perform any action on selection of menu item
}
```
On selecting any menu item it gives selected menu item name(if present otherwise nil) and index of menu item.Index of menu item start from 0.

#Customisation
```objc
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

```
#Note
This library does not customise menu button(in example at bottom in dark blue background color) like making round,setting background color,changing icon like + and x.
This is left on you to customise.You can take refernce form example if any help needed.
Code to make button circle is:
```objc
self.menuButton.clipsToBounds = YES;
self.menuButton.layer.cornerRadius = self.menuButton.frame.size.height/2;
```

#Let us know!

We will be happy if you sent us links to your projects where you use our library. And do let us know if you have any questions or suggestion regarding anything.

#License
IGCMenu is available under the [MIT license](https://raw.githubusercontent.com/sunilsharma08/IGCMenu/develop/LICENSE.md).
