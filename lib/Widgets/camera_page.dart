import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'video_data.dart'; // Importa el nuevo archivo

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImagePickerDemo(),
    );
  }
}

class ImagePickerDemo extends StatefulWidget {
  @override
  _ImagePickerDemoState createState() => _ImagePickerDemoState();
}

class _ImagePickerDemoState extends State<ImagePickerDemo> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  File? file;
  var _recognitions;
  img.Image? preprocessedImg;

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_original2.tflite",
      labels: "assets/labels.txt",
    );
  }

  Future<void> _pickImageCamera() async {
    await _pickImage(ImageSource.camera);
  }

  Future<void> _pickImageGallery() async {
    await _pickImage(ImageSource.gallery);
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        File originalFile = File(image.path);

        img.Image originalImage = img.decodeImage(originalFile.readAsBytesSync())!;

        img.Image resizedImage = img.copyResize(originalImage, width: 96, height: 96);

        String tempPath = (await getTemporaryDirectory()).path;
        File tempFile = File('$tempPath/temp_image.png')..writeAsBytesSync(img.encodePng(resizedImage));

        setState(() {
          _image = image;
          file = tempFile;
          preprocessedImg = resizedImage;
        });

        detectImage(file!);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> detectImage(File image) async {
    int startTime = DateTime.now().millisecondsSinceEpoch;

    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.65,
    );

    setState(() {
      _recognitions = recognitions;
    });

    int endTime = DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");

    if (_recognitions != null && _recognitions.isNotEmpty) {
      String detectedLabel = _recognitions[0]['label'];
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.green,
            title: Center(
              child: Text(
                detectedLabel,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            content: VideoData.getVideoWidget(detectedLabel),
            actions: <Widget>[
              TextButton(
                child: Text('OK', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _pickImageCamera,
              child: Text('Use Camera'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImageGallery,
              child: Text('Pick from Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
