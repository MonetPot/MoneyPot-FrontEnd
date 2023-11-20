import 'dart:io';


import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:money_pot/screens/group/bills/results_screen.dart';

class TextScanner extends StatefulWidget {
  @override
  _BillScannerScreenState createState() => _BillScannerScreenState();
}

class _BillScannerScreenState extends State<TextScanner> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    _initializeControllerFuture = _cameraController.initialize();
    _initializeControllerFuture.then((_) {
      setState(() {
        isCameraInitialized = true;
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  Future<void> _scanBill() async {
    try {
      await _initializeControllerFuture;
      final image = await _cameraController.takePicture();
      await _processImage(image);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _processImage(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
          Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(text: recognizedText.text),
        ),
      );

    // for (TextBlock block in recognizedText.blocks) {
    //   final String text = block.text;
    //   for (TextLine line in block.lines) {
    //     // Each line in a block
    //     print(line.text);
    //     for (TextElement element in line.elements) {
    //       // Each element in a line
    //       print(element.text);
    //     }
    //   }
    // }

    // Dispose of the recognizer when it's no longer needed
    textRecognizer.close();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isCameraInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_cameraController);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          FloatingActionButton(
            onPressed: _scanBill,
            child: Icon(Icons.camera),
          ),
        ],
      ),
    );
  }
}