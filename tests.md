# Manual Acceptance Tests

## Edit mode

* Plugin adds to scene without any errors or warnings in the Output window
* Text on button reflects changes made to Text Value
* Toggling Enable Text checkbox makes text visible/hidden
* Setting a custom font changes the text font
* The style may be reset
* The style may be updated

## Running scene

* The Mouseover Darkening Factor works for mouse hover and mouse down for min, 0.1, and max values
* Pressing the button opens the color picker panel in the 2 possible positions according to Popup Centered setting
* The color picker panel may be opened in full or simplified form according to Simple Color Picker setting
* The text color flips between light and dark as the color selection is varied
* Repeat the above with min, 0.5, and max Text Color Flip Threshold values
* The color of the button tracks the current color selection in the color picker panel
* When clicking outside the panel, it closes
* There should be no errors or warnings in the Output window