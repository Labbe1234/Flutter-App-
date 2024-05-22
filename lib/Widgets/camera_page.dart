import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../tflite_model_loader.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    TFLiteModelLoader.loadModel();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    _controller = CameraController(camera, ResolutionPreset.medium);
    await _controller.initialize();
    if (!mounted) return;
    setState(() {
      _isReady = true;
    });
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
