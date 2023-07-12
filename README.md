# camera_color_picker
A Flutter widget to pick colors using the camera.

*Note*: This plugin is still under development.

## Installation

First, add `camera_color_picker` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).


```
camera_color_picker: ^0.0.1
```

## Basic Example

```
Color currentColor = Colors.blueAccent;
```

```
CameraColorPicker(
                currentColor: currentColor,
                onColorChanged: (Color color) {
                  currentColor = color;
                  setState(() {});
                },
              ),

```


## Example-2 (Use the child argument to change the appearance of the button)

```
Color currentColor = Colors.blueAccent;
```

```
 CameraColorPicker(
                currentColor: currentColor,
                onColorChanged: (Color color) {
                  currentColor = color;
                  setState(() {});
                },
              child: Icon(
                  Icons.icecream_sharp,
                  color: currentColor,
                ),
              ),

```
