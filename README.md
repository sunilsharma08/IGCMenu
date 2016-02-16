# IGCMenu
This library gives easy way to create **Grid** and **Circular** menu.Light weight and highly customsiable.

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


#How to use
Drag the folder "IGCMenu" with the source files into your project, and add #import "IGCMenu.h" to the "ViewController.h" that will use it.
Then create instance variable in ViewController.m file.

```IGCMenu *igcMenu;```

Then create instance of class IGCMenu as follow

```
if (igcMenu == nil) {
        igcMenu = [[IGCMenu alloc] init];
    }
    igcMenu.disableBackground = YES;
    igcMenu.numberOfMenuItem = 5;

    igcMenu.menuButton = self.menuButton;

    igcMenu.menuSuperView = self.view;

    igcMenu.menuItemsNameArray = [NSArray arrayWithObjects:@"Home",@"Like",@"Search",@"User",@"Buy",nil];
    UIColor *homeBackgroundColor = [UIColor colorWithRed:(33/255.0) green:(180/255.0) blue:(227/255.0) alpha:1.0];
    UIColor *searchBackgroundColor = [UIColor colorWithRed:(139/255.0) green:(116/255.0) blue:(240/255.0) alpha:1.0];
    UIColor *favoritesBackgroundColor = [UIColor colorWithRed:(241/255.0) green:(118/255.0) blue:(121/255.0) alpha:1.0];
    UIColor *userBackgroundColor = [UIColor colorWithRed:(184/255.0) green:(204/255.0) blue:(207/255.0) alpha:1.0];
    UIColor *buyBackgroundColor = [UIColor colorWithRed:(169/255.0) green:(59/255.0) blue:(188/255.0) alpha:1.0];
    igcMenu.menuBackgroundColorsArray = [NSArray arrayWithObjects:homeBackgroundColor,favoritesBackgroundColor,searchBackgroundColor,userBackgroundColor, buyBackgroundColor,nil];

    igcMenu.menuImagesNameArray = [NSArray arrayWithObjects:@"home.png",@"favourite.png",@"search.png",@"user.png",@"buy.png",nil];

    igcMenu.delegate = self;
  ```
  
#Customisation
```
@property (nonatomic) NSInteger numberOfMenuItem;   //Number of menu items to show
@property (nonatomic) CGFloat menuRadius;           //Radius for circular menu
@property (weak,nonatomic) UIButton *menuButton;    //Menu button reference
@property (weak,nonatomic) UIView *menuSuperView;
@property (strong,nonatomic) NSArray *menuItemsNameArray;  //menu items name array,it can be empty
@property (strong,nonatomic) NSArray *menuBackgroundColorsArray; // menu items background color,it can be empty, default color is white
@property (strong,nonatomic) NSArray *menuImagesNameArray;   //menu item icon array it can be empty
@property (nonatomic) BOOL disableBackground;       //Disable background view, default is
@property int maxColumn;                            //Maximium number of column,default is 3
@property int menuHeight;                       //height = width ,default is 65


```

#Let us know!

We’d be really happy if you sent us links to your projects where you use our component. Just send an email to sunilsharma.ss08@gmail.com And do let us know if you have any questions or suggestion regarding anything.

#License
IGCMenu is available under the [MIT license](https://raw.githubusercontent.com/sunilsharma08/IGCMenu/develop/LICENSE.md).
