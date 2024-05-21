import 'package:tflite/tflite.dart';


class TFLiteModelLoader {
  static Future<void> loadModel() async {
    String? res = await Tflite.loadModel(
      model: "assets/model_original2.tflite",  // Use forward slashes
      labels: "assets/labels.txt",
    );
    print(res ?? 'Model loading failed');  // Handle null value using null-aware operator
  }

  static Future<List<dynamic>> runInference(String imagePath) async {
    var output = await Tflite.runModelOnImage(
      path: imagePath,
      numResults: 5,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    return output!;
  }
}
