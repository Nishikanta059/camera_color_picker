import 'package:camera_color_picker/camera_color_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Camera Color Picker Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Camera Color Picker Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Color currentColor = Colors.blueAccent;

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //example-1 basic implementation
              CameraColorPicker(
                currentColor: currentColor,
                onColorChanged: (Color color) {
                  currentColor = color;
                  setState(() {});
                },
              ),
              const SizedBox(height: 50),

              //example-2 if you want to modify the appearance of the button ,but use container without a onTap functionality
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
            ],
          ),
        ));
  }
}
