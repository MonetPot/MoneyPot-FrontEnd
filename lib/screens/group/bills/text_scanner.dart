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


// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:money_pot/screens/group/bills/results_screen.dart';
//
// class TextScanner extends StatefulWidget {
//   const TextScanner({Key? key}) : super(key: key);
//
//   @override
//   _TextScannerState createState() => _TextScannerState();
// }
//
// class _TextScannerState extends State<TextScanner> with WidgetsBindingObserver {
//   CameraController? cameraController;
//   final textRecognizer = TextRecognizer();
//   bool isCameraInitialized = false;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _checkPermissionAndStartCamera();
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     cameraController?.dispose();
//     textRecognizer.close();
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (cameraController == null || !cameraController!.value.isInitialized) {
//       return;
//     }
//     if (state == AppLifecycleState.inactive) {
//       cameraController?.dispose();
//     } else if (state == AppLifecycleState.resumed) {
//       if (cameraController != null) {
//         _initializeCamera();
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Text Recognition Sample'),
//       ),
//       body: isCameraInitialized
//           ? Stack(
//         children: [
//           CameraPreview(cameraController!),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 30),
//               child: ElevatedButton(
//                 onPressed: scanImage,
//                 child: const Text('Scan Text'),
//               ),
//             ),
//           ),
//         ],
//       )
//           : const Center(child: CircularProgressIndicator()),
//     );
//   }
//
//   Future<void> _checkPermissionAndStartCamera() async {
//     final status = await Permission.camera.request();
//     if (status.isGranted) {
//       _initializeCamera();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Camera permission is required for scanning.')),
//       );
//     }
//   }
//
//   Future<void> _initializeCamera() async {
//     final cameras = await availableCameras();
//     final camera = cameras.firstWhere(
//           (camera) => camera.lensDirection == CameraLensDirection.back,
//       orElse: () => cameras.first,
//     );
//     cameraController = CameraController(camera, ResolutionPreset.max, enableAudio: false);
//     await cameraController?.initialize();
//     setState(() {
//       isCameraInitialized = true;
//     });
//   }
//
//   Future<void> scanImage() async {
//     if (!isCameraInitialized) return;
//
//     try {
//       final pictureFile = await cameraController!.takePicture();
//       final file = File(pictureFile.path);
//       final inputImage = InputImage.fromFile(file);
//       final recognizedText = await textRecognizer.processImage(inputImage);
//
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ResultScreen(text: recognizedText.text),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error scanning text: $e')),
//       );
//     }
//   }
// }


// class TextScanner extends StatefulWidget {
//   const TextScanner({Key? key}) : super(key: key);
//
//   @override
//   State<TextScanner> createState() => _TextScannerState();
// }
//
// class _TextScannerState extends State<TextScanner> with WidgetsBindingObserver {
//   bool isPermissionGranted = false;
//   late final Future<void> future;
//
//   //For controlling camera
//   CameraController? cameraController;
//   final textRecogniser = TextRecognizer();
//
//   @override
//   void initState() {
//     super.initState();
//     //To display camera feed we need to add WidgetsBindingObserver.
//     WidgetsBinding.instance.addObserver(this);
//     future = _checkPermissionAndStartCamera();
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     stopCamera();
//     textRecogniser.close();
//     super.dispose();
//   }
//
//   //It'll check if app is in foreground or background
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (cameraController == null || !cameraController!.value.isInitialized) {
//       return;
//     }
//     if (state == AppLifecycleState.inactive) {
//       stopCamera();
//     } else if (state == AppLifecycleState.resumed &&
//         cameraController != null &&
//         cameraController!.value.isInitialized) {
//       startCamera();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: future,
//         builder: (context, snapshot) {
//           return Stack(
//             children: [
//               //Show camera content behind everything
//               if (isPermissionGranted)
//                 FutureBuilder<List<CameraDescription>>(
//                     future: availableCameras(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData) {
//                         initCameraController(snapshot.data!);
//                         return Center(
//                           child: CameraPreview(cameraController!),
//                         );
//                       } else {
//                         return const LinearProgressIndicator();
//                       }
//                     }),
//               Scaffold(
//                 appBar: AppBar(
//                   title: const Text('Text Recognition Sample'),
//                 ),
//                 backgroundColor:
//                 isPermissionGranted ? Colors.transparent : null,
//                 body: isPermissionGranted
//                     ? Column(
//                   children: [
//                     Expanded(child: Container()),
//                     Container(
//                       padding: EdgeInsets.only(bottom: 30),
//                       child: ElevatedButton(
//                           onPressed: (){
//                             scanImage();
//                           },
//                           child: Text('Scan Text')),
//                     ),
//                   ],
//                 )
//                     : Center(
//                   child: Container(
//                     padding:
//                     const EdgeInsets.only(left: 24.0, right: 24.0),
//                     child: const Text(
//                       'Camera Permission Denied',
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         });
//   }
//
//
//   //It will take care of scanning text from image
//   Future<void> scanImage() async {
//     if (cameraController == null) {
//       return;
//     }
//     final navigator = Navigator.of(context);
//     try {
//       final pictureFile = await cameraController!.takePicture();
//       final file = File(pictureFile.path);
//       final inputImage = InputImage.fromFile(file);
//       final recognizerText = await textRecogniser.processImage(inputImage);
//       await navigator.push(
//         MaterialPageRoute(
//           builder: (context) => ResultScreen(text: recognizerText.text),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('An error occurred when scanning text'),
//         ),
//       );
//     }
//   }
//
//   void _checkPermissionAndStartCamera() async {
//     bool hasPermission = await requestCameraPermission();
//     if (hasPermission) {
//       _initializeCamera();
//     } else {
//       // Handle the case when camera permission is denied
//       print('Camera permission denied');
//     }
//   }
//
//   Future<bool> requestCameraPermission() async {
//     var status = await Permission.camera.status;
//     if (status.isGranted) {
//       return true;
//     } else {
//       status = await Permission.camera.request();
//       return status.isGranted;
//     }
//   }
//
//   void _initializeCamera() async {
//     final cameras = await availableCameras();
//     initCameraController(cameras);
//   }
//
//   void initCameraController(List<CameraDescription> cameras) {
//     if (cameraController != null) {
//       return;
//     }
//     CameraDescription? camera = cameras.firstWhere(
//           (camera) => camera.lensDirection == CameraLensDirection.back,
//       orElse: () => cameras.first,
//     );
//     if (camera != null) {
//       cameraSelected(camera);
//     }
//   }
//
//   Future<void> cameraSelected(CameraDescription camera) async {
//     cameraController = CameraController(camera, ResolutionPreset.max, enableAudio: false);
//     await cameraController?.initialize();
//     if (!mounted) {
//       return;
//     }
//     setState(() {});
//   }
//
//   void startCamera() {
//     if (cameraController != null && !cameraController!.value.isInitialized) {
//       cameraSelected(cameraController!.description);
//     }
//   }
//
//   void stopCamera() {
//     cameraController?.dispose();
//   }
//
// }


// void _checkPermissionAndStartCamera() async {
//   bool hasPermission = await requestCameraPermission();
//   if (hasPermission) {
//     // Start camera
//   } else {
//     // Show an error or alert
//   }
// }

//
// Future<bool> requestCameraPermission() async {
//   var status = await Permission.camera.status;
//   if (status.isGranted) {
//     return true;
//   } else {
//     status = await Permission.camera.request();
//     return status.isGranted;
//   }
// }


// Future<void> requestCameraPermission() async {
//   final status = await Permission.camera.request();
//   isPermissionGranted = status == PermissionStatus.granted;
// }

// //It is used to initialise the camera controller
// //It also check the available camera in your device
// //It also check if camera controller is initialised or not.
// void initCameraController(List<CameraDescription> cameras) {
//   if (cameraController != null) {
//     return;
//   }
//   //Select the first ream camera
//   CameraDescription? camera;
//   for (var a = 0; a < cameras.length; a++) {
//     final CameraDescription current = cameras[a];
//     if (current.lensDirection == CameraLensDirection.back) {
//       camera = current;
//       break;
//     }
//   }
//   if (camera != null) {
//     cameraSelected(camera);
//   }
// }

// Future<void> cameraSelected(CameraDescription camera) async {
//   cameraController =
//       CameraController(camera, ResolutionPreset.max, enableAudio: false);
//   await cameraController?.initialize();
//   if (!mounted) {
//     return;
//   }
//   setState(() {});
// }
//
// //Start Camera
// void startCamera() {
//   if (cameraController != null) {
//     cameraSelected(cameraController!.description);
//   }
// }
//
// //Stop Camera
// void stopCamera() {
//   if (cameraController != null) {
//     cameraController?.dispose();
//   }
// }