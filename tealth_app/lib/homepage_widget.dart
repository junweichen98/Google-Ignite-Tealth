import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tealth_app/screens/search.dart';
import 'camera_widget.dart';
import 'main.dart';
import 'tips_widget.dart';

class HomepageWidget extends StatelessWidget {
  const HomepageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading:
            Image.asset('assets/tealth_logo_250.png', width: 40, height: 40),
        leadingWidth: 100,
        title: const Text(
          "What do you want to do today?",
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: const Color(0xff34346E),
                backgroundColor: Colors.white,
                side: const BorderSide(color: Color(0xffCCEFFC), width: 2),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22))),
                fixedSize: const Size(325, 130),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const InstructionsScreen()));
              },
              child: const Text('Check My Tealth', style: TextStyle(fontSize: 18)),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: const Color(0xff34346E),
                backgroundColor: Colors.white,
                side: const BorderSide(color: Color(0xffCCEFFC), width: 2),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22))),
                fixedSize: const Size(325, 130),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TipsWidget()));
              },
              child:
                  const Text('Dental Hygiene Tips', style: TextStyle(fontSize: 18)),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: const Color(0xff34346E),
                backgroundColor: Colors.white,
                side: const BorderSide(color: Color(0xffCCEFFC), width: 2),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22))),
                fixedSize: const Size(325, 130),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Search()));
              },
              child: const Text('Find a Dentist Near Me',
                  style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

class InstructionsScreen extends StatefulWidget {
  const InstructionsScreen({Key? key}) : super(key: key);

  @override
  _InstructionsState createState() => _InstructionsState();
}

class _InstructionsState extends State<InstructionsScreen> {
  bool checkedValue = false;
  late final File chosenImage;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  _imgFromCamera() async {
    File image = (await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    ));

    if (image != null) {
      setState(() {
        chosenImage = image;
      });

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(imageFile: chosenImage,)));
    }
  }

  _imgFromGallery() async {
    File image = (await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    ));

    if (image != null) {
      setState(() {
        chosenImage = image;
      });

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(imageFile: chosenImage,)));
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading:
            Image.asset('assets/tealth_logo_250.png', width: 40, height: 40),
        leadingWidth: 100,
        title: const Text(
          "Check My Tealth",
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
      body: Column(children: [
        Container(
          margin: const EdgeInsets.only(
              top: 30.0, bottom: 20.0, left: 20.0, right: 20.0),
          child: const Text(
            'Tealth helps you check your dental health by analyzing a picture of your teeth and gums. To get started, smile wide and take a close-up picture of your teeth!',
            style: TextStyle(
              fontFamily: 'Average Sans',
              color: Color(0xff34346E),
              fontSize: 20,
              height: 1.5,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
              top: 30.0, bottom: 20.0, left: 20.0, right: 20.0),
          child: Text(
            'Permission to use images uploaded',
            style: TextStyle(
              fontFamily: 'Average Sans',
              color: Colors.grey.shade800,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
              top: 0.0, bottom: 0.0, left: 20.0, right: 20.0),
          child: Text(
            'To continously improve our AI model in analyzing dental health, Tealth requires many different images of teeth and gums.\n\nDo you consent to the use of your photos? Note: all photos kept will be anonymous.',
            style: TextStyle(
              fontFamily: 'Average Sans',
              color: Colors.grey.shade700,
              fontSize: 18,
            ),
          ),
        ),
        CheckboxListTile(
          activeColor: const Color(0xff34346E),
          title: const Text(
            'I consent to the use of my pictures.',
            style: TextStyle(
              fontFamily: 'Average Sans',
              color: Color(0xff34346E),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          value: (sp.containsKey("uploadPermission")) ? checkedValue = sp.getBool("uploadPermission")! : false,
          onChanged: (newValue) {
            setState(() {
              checkedValue = newValue!;
              print("checked: $checkedValue");
              sp.setBool('uploadPermission', checkedValue);
            });
          },
          controlAffinity:
              ListTileControlAffinity.leading,
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            primary: const Color(0xff34346E),
            backgroundColor: Colors.white,
            side: const BorderSide(color: Color(0xffCCEFFC), width: 2),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(22))),
            fixedSize: const Size(100, 50),
          ),
          onPressed: () {
            _showPicker(context);
          },
          child: const Text('Go!', style: TextStyle(fontSize: 18)),
        ),
      ]),
    );
  }
}
