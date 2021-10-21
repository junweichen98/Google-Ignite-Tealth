import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tealth_app/reminder_widget.dart';
import 'package:tealth_app/screens/search.dart';
import 'home_widget.dart';
import 'homepage_widget.dart';

class ResultsWidget extends StatefulWidget {
  final File imageFile;

  const ResultsWidget({Key? key, required this.imageFile}) : super(key: key);

  @override
  _ResultsWidgetState createState() => _ResultsWidgetState();
}

class _ResultsWidgetState extends State<ResultsWidget> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text('Are you sure you want to leave?'),
            content: const Text('Your current results will be lost once you leave the page.\n\nPlease make sure you screenshot your results before leaving.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Home())),
                child: const Text('Yes'),
              ),
            ],
          ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading:
            Image.asset('assets/tealth_logo_250.png', width: 40, height: 40),
            leadingWidth: 100,
            title: const Text(
              "You have good Tealth!", // replace with actual results next time
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
          body: Column(
            children: [
              Center(
                child: Container(
                  width: 300,
                  height: 300,
                  margin: const EdgeInsets.only(top: 30.0, bottom: 10.0),
                  child: Image.file(widget.imageFile, fit: BoxFit.fitWidth),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: const Color(0xff34346E),
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                            color: Color(0xffCCEFFC), width: 2),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(22))),
                        fixedSize: const Size(300, 60),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Search()));
                      },
                      child: const Text('Find a Dentist Near Me',
                          style: TextStyle(fontSize: 18)),
                    ),
                    const SizedBox(height: 30),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: const Color(0xff34346E),
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                            color: Color(0xffCCEFFC), width: 2),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(22))),
                        fixedSize: const Size(300, 60),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const InstructionsScreen()));
                      },
                      child:
                      const Text(
                          'Check Tealth Again', style: TextStyle(fontSize: 18)),
                    ),
                    const SizedBox(height: 30),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: const Color(0xff34346E),
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                            color: Color(0xffCCEFFC), width: 2),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(22))),
                        fixedSize: const Size(300, 60),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ReminderWidget()));
                      },
                      child: const Text('Set Reminder',
                          style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
