import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:scalpinspector_app/animation.dart';
import 'package:scalpinspector_app/screens/result_screen.dart';

import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

import '../db_helper.dart';

class DiagnoseScreen extends StatefulWidget {
  const DiagnoseScreen({super.key});

  @override
  DiagnoseScreenState createState() => DiagnoseScreenState();
}

class DiagnoseScreenState extends State<DiagnoseScreen> {
  File? _imageFile;
  String _diseaseName = '';
  String _confidenceScore = '';
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitPicture() async {
    _diseaseName = '';
    _confidenceScore = '';
    if (_imageFile != null) {
      const apiUrl =
          'http://10.0.2.2:8000/predict'; // Replace with your API hosting endpoint

      // Read the image file
      List<int> imageBytes = await _imageFile!.readAsBytes();

      // Create a multipart request
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      // Add the preprocessed image to the request
      request.files.add(http.MultipartFile.fromBytes('image', imageBytes,
          filename: 'image.jpg'));

      try {
        // Send the request and get the response
        var response = await request.send();

        // Check the response status code
        if (response.statusCode == 200) {
          // Read the response as JSON
          var responseData = await response.stream.bytesToString();
          var decodedResponse = json.decode(responseData);

          // Handle the response as needed
          String predictedClass = decodedResponse['class'];
          double confidenceScore = decodedResponse['confidence_score'];
          _confidenceScore = confidenceScore.toStringAsFixed(2);
          _diseaseName = predictedClass;
          if (!mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(
                imageFile: _imageFile,
                diseaseName: _diseaseName,
                confidenceScore: _confidenceScore,
              ),
            ),
          );
        } else {
          // Handle error
          print('Request failed with status: ${response.statusCode}');
        }
      } catch (e) {
        // Handle network or other errors
        print('Error sending the request: $e');
      }
    }
  }

  Future<void> diagnose() async {
    final interpreter = await Interpreter.fromAsset('assets/model.tflite');
    print(interpreter.getOutputTensors());
    print(interpreter.getInputTensors());
    final input = _imageFile!.readAsBytesSync();
    final preprocessed = preprocessImage(input);
    final output = List.filled(1 * 5, 0).reshape([1, 5]);
    interpreter.run(preprocessed, output);
    print(output);
  }

  Future<List<String>> loadLabels() async {
    String labelsText = await rootBundle.loadString('assets/labels.txt');
    return const LineSplitter().convert(labelsText);
  }

  int getRed(int pixel) {
    return (pixel >> 16) & 0xFF;
  }

  int getGreen(int pixel) {
    return (pixel >> 8) & 0xFF;
  }

  int getBlue(int pixel) {
    return pixel & 0xFF;
  }

  Uint8List preprocessImage(Uint8List imageBytes) {
    // Convert the imageBytes to a Dart image object using the image package
    img.Image? image = img.decodeImage(imageBytes);

    // Resize the image to (224, 224)
    img.Image resizedImage = img.copyResize(image!, width: 224, height: 224);

    // Prepare the uint8List to hold the preprocessed image data
    Uint8List uint8List = Uint8List(1 * 224 * 224 * 3);

    // Normalize and reshape the pixel values to [0, 255]
    int pixelIndex = 0;
    for (var y = 0; y < 224; y++) {
      for (var x = 0; x < 224; x++) {
        int pixel = resizedImage.getPixel(x, y).hashCode;
        uint8List[pixelIndex++] = getRed(pixel); // Red channel
        uint8List[pixelIndex++] = getGreen(pixel); // Green channel
        uint8List[pixelIndex++] = getBlue(pixel); // Blue channel
      }
    }

    return uint8List;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/blue_back.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
              color: Colors.white,
              size: 35,
            ),
          ),
          body: Column(
            children: [
              Column(
                children: [
                  FadeAnimation(
                    delay: 1,
                    child: SizedBox(
                      child: Image.network(
                          'https://cdn-icons-png.flaticon.com/128/9733/9733578.png'),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 100, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Gutter(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _imageFile != null
                                ? Image.file(
                                    _imageFile!,
                                    width: 300,
                                    height: 300,
                                  )
                                : Center(
                                    child: SizedBox(
                                        child: Text('No Image selected')),
                                  )
                          ],
                        ),
                        Gutter(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.camera),
                              onPressed: _pickImageFromCamera,
                            ),
                            IconButton(
                              icon: const Icon(Icons.upload_file),
                              onPressed: _pickImageFromGallery,
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: _imageFile != null ? _submitPicture : null,
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.blue.shade200,
                            ),
                            child: Center(
                                child: Text(
                              'Submit',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
