// import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

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
  // var dataList = [];
  @override
  void initState() {
    super.initState();
    loadmodel().then((value) {
      setState(() {});
    });
  }

  loadmodel() async {
    await Tflite.loadModel(
      model: "assets/model_original2.tflite",
      labels: "assets/labels.txt",
    );
  }

  Future<void> _pickImageCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = image;
        file = File(image!.path);

      });
      detectimage(file!);
    } catch (e) {
      print('Error picking image: $e');
    }
  }

 Future<void> _pickImageGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        file = File(image!.path);

      });
      detectimage(file!);
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future detectimage(File image) async {
    int startTime = new DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      // numResults: 1,
      // threshold: 0.65,
      // imageMean: 127.5,
      // imageStd: 127.5,
    );
    setState(() {
      _recognitions = recognitions;
      v = recognitions?.map((recognition) => recognition['label']).join(', ') ?? '';
      // dataList = List<Map<String, dynamic>>.from(jsonDecode(v));
    });
    print("//////////////////////////////////////////////////");
    print(_recognitions);
    // print(dataList);
    print("//////////////////////////////////////////////////");
    int endTime = new DateTime.now().millisecondsSinceEpoch;
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
              Image.file(
                File(_image!.path),
                height: 200,
                width: 200,
                fit: BoxFit.cover,
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