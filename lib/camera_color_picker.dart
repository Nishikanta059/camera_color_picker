library camera_color_picker;

import 'package:flutter/material.dart';

import 'camera_color_picker_backend.dart';

class CameraColorPicker extends StatefulWidget {
  final Color currentColor;
  final Function(Color color) onColorChanged;
  final Widget? child;
  const CameraColorPicker(
      {Key? key,
      required this.onColorChanged,
      required this.currentColor,
      this.child})
      : super(key: key);

  @override
  State<CameraColorPicker> createState() => _CameraColorPickerState();
}

class _CameraColorPickerState extends State<CameraColorPicker> {
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    Color _currentColor2 = widget.currentColor;
    void getColor() async {
      // print(currentColor4);
      var colorString = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  const CameraColorPickerBackend()));

      String valueString = colorString
          .toString()
          .split('(0x')[1]
          .split(')')[0]; // kind of hacky..
      int value = int.parse(valueString, radix: 16);

      _currentColor2 = Color(value);

      widget.onColorChanged(_currentColor2);
      setState(() {});

      // Navigator.pop(context, currentColor.toString());
    }

    return widget.child == null
        ? ElevatedButton(
            onPressed: () => getColor(),
            style: ElevatedButton.styleFrom(
              backgroundColor: _currentColor2,
            ),
            child: const Text('Tap me'))
        : GestureDetector(
            child: widget.child,
            onTap: () => getColor(),
          );
  }
}
