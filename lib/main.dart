import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'tflite_model_loader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final camera = cameras.first;
  runApp(MyApp(camera: camera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  const MyApp({Key? key, required this.camera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraScreen(camera: camera),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({Key? key, required this.camera}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isReady = true;
      });
    });
    TFLiteModelLoader.loadModel();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(title: Text('Camera Screen')),
      body: CameraPreview(_controller),
      floatingActionButton: FloatingActionButton(
        onPressed: _classifyImage,
        child: Icon(Icons.camera),
      ),
    );
  }

  void _classifyImage() async {
    try {
      XFile? image = await _controller.takePicture();
      if (image == null) return;

      List<dynamic> output = await TFLiteModelLoader.runInference(image.path);
      // Display classification result
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Image Classification Result'),
            content: Text(output.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error classifying image: $e');
    }
  }
}
