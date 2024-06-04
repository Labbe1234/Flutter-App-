import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

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
  var v = "";
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
      model: "assets/EcoSnapModel2.tflite",
      labels: "assets/labels.txt",
    );
  }

  Future<void> _pickImageCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        File originalFile = File(image.path);

        // Load the image using the image package
        img.Image originalImage = img.decodeImage(originalFile.readAsBytesSync())!;

        // Resize the image to 96x96
        img.Image resizedImage = img.copyResize(originalImage, width: 96, height: 96);

        // Save the resized image to a temporary file
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

  Future<void> _pickImageGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        File originalFile = File(image.path);

        // Load the image using the image package
        img.Image originalImage = img.decodeImage(originalFile.readAsBytesSync())!;

        // Resize the image to 96x96
        img.Image resizedImage = img.copyResize(originalImage, width: 96, height: 96);

        // Save the resized image to a temporary file
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
      numResults: 2, // Return 1 or 2 results
      threshold: 0.65, // Confidence threshold
    );

    setState(() {
      _recognitions = recognitions;
      v = recognitions?.map((recognition) => recognition['label']).join(', ') ?? '';
    });

    print("//////////////////////////////////////////////////");
    print(_recognitions);
    print("//////////////////////////////////////////////////");

    int endTime = DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");
  }


@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (_image != null)
            Container(
              width: 200,  // Set the desired width
              height: 200, // Set the desired height
              child: Image.file(
                File(_image!.path),
                fit: BoxFit.contain,  // Change to fit: BoxFit.cover, BoxFit.fill, etc., based on your needs
              ),
            )
          else
            Text('No image selected'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _pickImageCamera,
            child: Text('Use Camera'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _pickImageGallery,
            child: Text('Pick from Gallery'),
          ),
          SizedBox(height: 20),
          Text(v),
        ],
      ),
    ),
  );
}
}