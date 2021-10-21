import 'package:flutter/material.dart';
import 'notifications_helper.dart';
import 'main.dart';

class ReminderWidget extends StatefulWidget {
  const ReminderWidget({Key? key}) : super(key: key);

  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<ReminderWidget> {
  var _result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading:
            Image.asset('assets/tealth_logo_250.png', width: 40, height: 40),
        leadingWidth: 100,
        title: const Text(
          "Set Reminder",
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
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "It is important to check your Tealth regularly!\n\n",
                  style: TextStyle(
                    fontFamily: 'Average Sans',
                    color: Color(0xff34346E),
                    fontSize: 16,
                  ),
                ),
                const Text(
                  "Remind me to check my Tealth:",
                  style: TextStyle(
                    fontFamily: 'Average Sans',
                    color: Color(0xff34346E),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                RadioListTile(
                    title: const Text('No, I do not want any reminders'),
                    value: 0,
                    groupValue: _result,
                    onChanged: (value) {
                      setState(() {
                        _result = int.parse(value.toString());
                        sp.setInt("reminderValue", _result);
                      });
                }),
                RadioListTile(
                    title: const Text('Every day'),
                    value: 1,
                    groupValue: _result,
                    onChanged: (value) {
                      setState(() {
                        _result = int.parse(value.toString());
                        sp.setInt("reminderValue", _result);
                      });
                    }),
                RadioListTile(
                    title: const Text('Every 2 days'),
                    value: 2,
                    groupValue: _result,
                    onChanged: (value) {
                      setState(() {
                        _result = int.parse(value.toString());
                        sp.setInt("reminderValue", _result);
                      });
                    }),
                RadioListTile(
                    title: const Text('Every 3 days'),
                    value: 3,
                    groupValue: _result,
                    onChanged: (value) {
                      setState(() {
                        _result = int.parse(value.toString());
                        sp.setInt("reminderValue", _result);
                      });
                    }),
                RadioListTile(
                    title: const Text('Every week'),
                    value: 7,
                    groupValue: _result,
                    onChanged: (value) {
                      setState(() {
                        _result = int.parse(value.toString());
                        sp.setInt("reminderValue", _result);
                      });
                    }),
                RadioListTile(
                    title: const Text('Every 2 weeks'),
                    value: 14,
                    groupValue: _result,
                    onChanged: (value) {
                      setState(() {
                        _result = int.parse(value.toString());
                        sp.setInt("reminderValue", _result);
                      });
                    }),
                RadioListTile(
                    title: const Text('Every month'),
                    value: 30,
                    groupValue: _result,
                    onChanged: (value) {
                      setState(() {
                        _result = int.parse(value.toString());
                        sp.setInt("reminderValue", _result);
                      });
                    }),
                const SizedBox(height: 20),
                Center(child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: const Color(0xff34346E),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xffCCEFFC), width: 2),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22))),
                    fixedSize: const Size(100, 50),
                  ),
                  onPressed: () {
                    var reminderValue = sp.getInt("reminderValue");
                    print("reminderValue: $reminderValue");
                    if (reminderValue != 0) {
                      var currentDate = DateTime.now();
                      var scheduledDate = DateTime(currentDate.year, currentDate.month, currentDate.day + reminderValue!);
                      // var scheduledDate = DateTime.now(); // for testing purposes
                      scheduleNotification(
                          notifsPlugin: notifsPlugin,
                          id: DateTime.now().toString(),
                          title: "Tealth Reminder",
                          body: "Remember to check your Tealth!",
                          scheduledTime: scheduledDate);
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Save',
                      style: TextStyle(fontSize: 18)),
                ),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
