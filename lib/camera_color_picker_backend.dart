import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CameraColorPickerBackend extends StatefulWidget {
  const CameraColorPickerBackend({Key? key}) : super(key: key);

  @override
  State<CameraColorPickerBackend> createState() =>
      _CameraColorPickerBackendState();
}

Uint8List? bytes;
int f = 0;
Color middleColor = const Color(0xfffbead9);
int height = 0;
int width = 0;

class _CameraColorPickerBackendState extends State<CameraColorPickerBackend> {
  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

//   void processImg()async {
//     final ByteData imageData = await NetworkAssetBundle(Uri.parse("https://cdn.vox-cdn.com/thumbor/I7I0t87KZ-vf_GSWrH118jwl6d0=/1400x0/filters:no_upscale()/cdn.vox-cdn.com/uploads/chorus_asset/file/23437452/The_Spy_x_Family_Anime_Succeeds_Because_of_Its_Characters_.jpg")).load("");
//     bytes = imageData.buffer.asUint8List();
//
//
//     // print(color);
//     // print("yo");
// setState(() {
//   f=1;
//   // middleColor=extractMiddlePixelsColor(bytes);
// });
//
// // display it with the Image.memory widget
//
//   }

  Color _getMIddleColorFromYUV420(CameraImage image) {
    int? bytesPerRow = image.planes[2].bytesPerRow;
    int? bytesPerPixel = image.planes[2].bytesPerPixel;
    width = image.width;
    height = image.height;

    int x = (width / 2).floor() - 1;
    int y = (height / 2).floor() - 1;
// print(width);
// print(y);
    int hexFF = 255;
    int uvIndex =
        (bytesPerPixel! * (x / 2).floor()) + (bytesPerRow * ((y / 2).floor()));
    int index = (y * width) + x;
// print(uvIndex);
// print(index);
    int yp = image.planes[0].bytes[index];
    int up = image.planes[1].bytes[uvIndex];
    int vp = image.planes[2].bytes[uvIndex];

    int rt = (yp + vp * 1436 / 1024 - 179).round();
    int gt = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91).round();
    int bt = (yp + up * 1814 / 1024 - 227).round();
    int r = clamp(0, 255, rt);
    int g = clamp(0, 255, gt);
    int b = clamp(0, 255, bt);

    var newClr = (hexFF << 24) | (b << 16) | (g << 8) | r;

    // print(abgrToColor(newClr));

    return abgrToColor(newClr);
  }

  Color abgrToColor(int argbColor) {
    int r = (argbColor >> 16) & 0xFF;
    int b = argbColor & 0xFF;
    int hex = (argbColor & 0xFF00FF00) | (b << 16) | r;
    return Color(hex);
  }

  int clamp(int lower, int higher, int val) {
    if (val < lower) {
      return 0;
    } else if (val > higher) {
      return 255;
    } else {
      return val;
    }
  }

  CameraController? _camera;
  bool _cameraInitialized = false;
  void _initializeCamera() async {
    // Get list of cameras of the device

    List<CameraDescription> cameras = await availableCameras();
// Create the CameraController
    _camera = CameraController(cameras[0], ResolutionPreset.veryHigh);
// Initialize the CameraController
    _camera!.initialize().then((_) async {
      // Start ImageStream
      await _camera!
          .startImageStream((CameraImage image) => _processCameraImage(image));
      setState(() {
        _cameraInitialized = true;
      });
    });
  }

  void _processCameraImage(CameraImage image) async {
    setState(() {
      middleColor = _getMIddleColorFromYUV420(image);
    });
  }

  @override
  Widget build(BuildContext contextB) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
          title: const Text('pick color'), automaticallyImplyLeading: false),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          (_cameraInitialized)
              ? SizedBox(
                  height: width * 1.0,
                  width: height * 1.0,
                  child: AspectRatio(
                    aspectRatio: _camera!.value.aspectRatio,
                    child: CameraPreview(
                      _camera!,
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
          const Center(child: Icon(Icons.add_box_rounded)),
          Padding(
            padding: EdgeInsets.fromLTRB(0, height - 150, 0, 0),
            child: GestureDetector(
              onTap: () async {
                _cameraInitialized = false;
                await _camera!.dispose();
                if (!context.mounted) return;
                Navigator.pop(context, middleColor.toString());
              },
              child: Container(
                color: middleColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        backgroundColor: middleColor,
                        foregroundColor: Colors.white,
                        elevation: 20,
                        onPressed: () {},
                        tooltip: 'Increment',
                        child: const Icon(Icons.color_lens_outlined),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
