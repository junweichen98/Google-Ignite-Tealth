import 'package:flutter/material.dart';
import 'main.dart';
import 'reminder_widget.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsWidget> {
  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading:
              Image.asset('assets/tealth_logo_250.png', width: 40, height: 40),
          leadingWidth: 100,
          title: const Text(
            "My Settings",
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
            SwitchListTile(
              title: const Text('Upload image permission'),
              value: (sp.containsKey("uploadPermission")) ? checkedValue = sp.getBool("uploadPermission")! : false,
              onChanged: (bool value) {
                setState(() {
                  checkedValue = value;
                  print("checkedValue: $checkedValue");
                  sp.setBool('uploadPermission', checkedValue);
                });
              },
              secondary: const Icon(Icons.photo_camera_front_outlined),
            ),
            ListTile(
                leading: const Icon(Icons.notifications_active_outlined),
                title:
                    const Text('Set Tealth Reminder', style: TextStyle(fontSize: 16)),
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ReminderWidget()))),
          ],
        ));
  }
}
