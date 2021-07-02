---
title: BuildContextExtension
---

`BuildContextExtension` Extension for `BuildContext` data type.

## Utility

### cypageController
**-> CypageController**<br />
Get `CypageController` from current context.<br />
*nullable*

### showBottomSheet(BottomSheetHandler)
**-> Future Generic**<br />
Call bottom sheet that handled by `bottomSheetHandler()`<br />
*nullable*

### showDialog(DialogHandler)
**-> Future Generic**<br />
Call dialog that handled by `dialogHandler()`<br />
*nullable*

### mq
**-> MediaQueryData**<br />
Get `MediaQueryData` from current context.<br />
*non-nullable*

### screenSize
**-> Size**<br />
Get `MediaQueryData` Screen Size.<br />
*non-nullable*

### screenDensity
**-> double**<br />
Get `MediaQueryData` Screen Density.<br />
*non-nullable*

### screenPadding
**-> EdgeInsetsGeometry**<br />
Get `MediaQueryData` Screen Padding.<br />
*non-nullable*

### screenWidth
**-> double**<br />
Get `MediaQueryData` Screen Width.<br />
*non-nullable*

### screenHeight
**-> double**<br />
Get MediaQuery Screen Height<br />
*non-nullable*

### percentWidth
**-> double**<br />
Get MediaQuery Screen Width in percentage<br />
*non-nullable*

### percentHeight
**-> double**<br />
Get MediaQuery Screen Width in percentage<br />
*non-nullable*

### safePercentWidth
**-> double**<br />
Get MediaQuery Screen Width in percentage including safe area calculation<br />
*non-nullable*

### safePercentHeight
**-> double**<br />
Get MediaQuery Screen Width in percentage including safe area calculation<br />
*non-nullable*

### orientation
**-> Orientation**<br />
Returns Orientation using MediaQuery<br />
*non-nullable*

### isLandscape
**-> bool**<br />
Return true if Orientation is Landscape<br />
*non-nullable*

### theme
**-> ThemeData**<br />
Get theme from context<br />
*non-nullable*

### cupertinoTheme
**-> CupertinoThemeData**<br />
Get Cupertino Theme Data from context<br />
*non-nullable*

### textTheme
**-> TextTheme**<br />
Get Text Theme from context<br />
*non-nullable*

### captionStyle
**-> TextStyle**<br />
Get caption style from TextTheme<br />
*nullable*

### accentColor
**-> Color**<br />
The foreground color for widgets (knobs, text, overscroll edge effect, etc. Accent color is also known as the secondary color.<br />
*non-nullable*

### primaryColor
**-> Color**<br />
The background color for major parts of the app (toolbars, tab bars, etc)<br />
*non-nullable*

### backgroundColor
**-> Color**<br />
A color that contrasts with the primaryColor<br />
*non-nullable*

### canvasColor
**-> Color**<br />
The default color of MaterialType.canvas<br />
*non-nullable*

### cardColor
**-> Color**<br />
The default color of MaterialType.card<br />
*non-nullable*

### brightness
**-> Brightness**<br />
The default brightness of the Theme<br />
*non-nullable*

### navigator
**-> NavigatorState**<br />
returns the state from the closest instance of this class encloses the given context<br />
*nullable*

### push(WidgetBuilder)
**->  Generic**<br />
Push the current context to given widget<br />
*non-nullable*

### pop()
**-> Generic**<br />
`Generic result` <br />
Function to back from this page<br />
*non-nullable*

### form
**-> FormState**<br />
return the state from the closest instance of this class that encloses the given context<br />
*non-nullable*

### locale
**-> Locale**<br />
Return the current locale of the app as specified in the Localization widget<br />
*nullable*

### overlay
**-> OverlayState**<br />
Return the state from the closest instance of this class that encloes the given context. It is used for showing widgets on top of everything<br />
*nullable*

### addOverlay(WidgetBuilder)
**-> OverlayEntry**<br />
Insert the given widget into the overlay, the new inserted widget will always be at top<br />
*non-nullable*

### scaffold
**-> ScaffoldState**<br />
Return the closest instance of ScaffoldState in the widget tree, if there's no scaffold then will throw an exception<br />
*non-nullable*

### clearFocus()
**-> void**<br />
Clear current context focus, like keyboard etc<br />
*non-nullable*

<br />

#### Maintained By corecybernetics354@gmail.com