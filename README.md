# camera_color_picker
A Flutter widget to pick colors using the camera.

*Note*: This plugin is still under development.

## Installation

First, add `camera_color_picker` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).


```
camera_color_picker: ^0.0.1
```
## Demo-Basic 
![Screenshot_2024-12-21-01-16-09-840_com example dummy](https://github.com/user-attachments/assets/783e7479-f5eb-4131-b89a-0ba0f3bc8bf5)

https://github.com/user-attachments/assets/0ddda603-7d17-4e48-aae0-1438765dd77d


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

##Demo-2
![Screenshot_2024-12-21-01-16-20-651_com example dummy](https://github.com/user-attachments/assets/c38aea6c-eda0-4ba7-b72a-44c35719d9a4)
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
              child: Container(
                  child: Icon(
                    Icons.camera_alt,
                    color: currentColor,
                    size: 66,
                  ),
                ),

```
