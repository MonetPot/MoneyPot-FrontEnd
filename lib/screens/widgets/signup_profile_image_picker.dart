import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import '../../../const/icons.dart';

class ProfileImagePicker extends StatefulWidget {
  final margin;

  ProfileImagePicker({this.margin, Key? key}) : super(key: key);

  @override
  _ProfileImagePickerState createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  late File _image;

  Future getImage() async {
    try {
      // New method of image picking
      final XFile? pickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera
      );

      // Check if an image was picked
      if (pickedFile != null) {
        // Update the state with the selected image
        setState(() {
          _image = File(pickedFile.path); // Convert XFile to File
        });
      }
    } catch (e) {
      // Handle any exceptions
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          Container(
            width: 260.0,
            height: 200.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15,
                    spreadRadius: 0,
                    offset: Offset(0.0, 16.0)),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: _image != null
                  ? Image.file(
                _image,
                fit: BoxFit.contain,
              )
                  : Image.asset(
                'assets/images/signup/signup_page_9_profile.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              await getImage();
            },
            icon: Icon(
              IconData(camera, fontFamily: 'Icons'),
              color: Color(0xffDBEDAF),
            ),
          )
        ],
      ),
    );
  }
}