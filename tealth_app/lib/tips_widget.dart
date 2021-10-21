import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TipsWidget extends StatefulWidget {
  const TipsWidget({Key? key}) : super(key: key);

  @override
  _TipsState createState() => _TipsState();
}

class _TipsState extends State<TipsWidget> {
  List<String> _questions = [];

  Future<List<String>> _loadQuestions() async {
    List<String> questions = [];
    await rootBundle.loadString('assets/tips.txt').then((q) {
      for (String i in const LineSplitter().convert(q)) {
        questions.add(i);
      }
    });
    return questions;
  }

  @override
  void initState() {
    _setup();
    super.initState();
  }

  _setup() async {
    // Retrieve the questions (Processed in the background)
    List<String> questions = await _loadQuestions();

    // Notify the UI and display the questions
    setState(() {
      _questions = questions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading:
            Image.asset('assets/tealth_logo_250.png', width: 40, height: 40),
        leadingWidth: 100,
        title: const Text(
          "Dental Hygiene Tips",
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
      body: SafeArea(
        child: ListView.builder(
          itemCount: _questions.length,
          itemBuilder: (context, index) => Card(
            elevation: 0,
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  (index + 1).toString(),
                  style: const TextStyle(
                    fontFamily: 'Average Sans',
                    color: Color(0xff34346E),
                  ),
                ),
                backgroundColor: const Color(0xffCCEFFC),
              ),
              title: Text(
                _questions[index],
                style: const TextStyle(
                  fontFamily: 'Average Sans',
                  color: Color(0xff34346E),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
