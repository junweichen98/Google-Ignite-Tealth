import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';
import 'loader_widget.dart';

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final File imageFile;

  const DisplayPictureScreen({Key? key, required this.imageFile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading:
            Image.asset('assets/tealth_logo_250.png', width: 40, height: 40),
        leadingWidth: 100,
        title: const Text(
          "Use this picture?",
          style: TextStyle(
            fontFamily: 'Average Sans',
            color: Color(0xff34346E),
            fontSize: 18,
          ),
        ),
        elevation: 0,
        backgroundColor: const Color(0xffCCEFFC),
        toolbarHeight: 130,
      ),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the file to display the image.
      body: Column(
        children: [
          Center(
            child: Container(
              width: 300,
              height: 400,
              margin: const EdgeInsets.only(top: 30.0, bottom: 10.0),
              child: Image.file(imageFile, fit: BoxFit.fitWidth),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: const Color(0xff34346E),
                    backgroundColor: Colors.white,
                    side: BorderSide(color: const Color(0xffCCEFFC), width: 2),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22))),
                    fixedSize: Size(100, 50),
                  ),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    bool uploadPermission =
                        prefs.getBool('uploadPermission') ?? false;
                    print("uploadPermission: $uploadPermission");
                    if (uploadPermission) {
                      // save to image to firebase
                      uploadFile(imageFile);
                    }
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Loader(imageFile: imageFile,)));
                  },
                  child: Text('Yes', style: TextStyle(fontSize: 18)),
                ),
                SizedBox(width: 50),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: const Color(0xff34346E),
                    backgroundColor: Colors.white,
                    side: BorderSide(color: const Color(0xffCCEFFC), width: 2),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22))),
                    fixedSize: Size(100, 50),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('No', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> uploadFile(File imageFile) async {
  // Create uuid object
  var uuid = Uuid();

  // Generate a v1 (time-based) id
  var uniqueRef = uuid.v1();

  try {
    await firebase_storage.FirebaseStorage.instance
        .ref(uniqueRef)
        .putFile(imageFile);
    print("Upload successful.");
  } catch (e) {
    print("File upload failed.");
  }
}
