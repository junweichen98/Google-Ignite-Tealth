import 'package:flutter/material.dart';
import "dart:math";
import 'dart:async';
import 'results_widget.dart';
import 'dart:io';

class Loader extends StatefulWidget {
  final File imageFile;
  const Loader({Key? key, required this.imageFile}) : super(key: key);

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation_rotation;
  late Animation<double> animation_radius_in;
  late Animation<double> animation_radius_out;

  final double initialradius = 30.0;
  double radius = 50.0;

  @override
  void initState() {
    super.initState();
    startTime();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation_rotation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: controller, curve: const Interval(0.0, 1.0, curve: Curves.linear)));
    animation_radius_in = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.75, 1.0, curve: Curves.elasticIn)));

    animation_radius_out = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.25, curve: Curves.elasticOut)));

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0) {
          radius = animation_radius_in.value * initialradius;
        } else if (controller.value >= 0.0 && controller.value <= 0.25) {
          radius = animation_radius_out.value * initialradius;
        }
      });
    });
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  startTime() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ResultsWidget(imageFile: widget.imageFile)));
  }

  initScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffCCEFFC),
      appBar: AppBar(
        leading:
            Image.asset('assets/tealth_logo_250.png', width: 40, height: 40),
        leadingWidth: 100,
        title: const Text(
          "Analyzing Tealth...",
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
        child: RotationTransition(
          turns: animation_rotation,
          child: Stack(
            children: <Widget>[
              const Dot(radius: 30.0, color: Colors.black12),
              Transform.translate(
                  offset: Offset(radius * cos(pi / 4), radius * sin(pi / 4)),
                  child: const Dot(
                    radius: 5.0,
                    color: Colors.redAccent,
                  )),
              Transform.translate(
                  offset: Offset(
                      radius * cos(2 * pi / 4), radius * sin(2 * pi / 4)),
                  child: const Dot(
                    radius: 5.0,
                    color: Colors.green,
                  )),
              Transform.translate(
                  offset: Offset(
                      radius * cos(3 * pi / 4), radius * sin(3 * pi / 4)),
                  child: const Dot(radius: 5.0, color: Colors.yellowAccent)),
              Transform.translate(
                  offset: Offset(
                      radius * cos(4 * pi / 4), radius * sin(4 * pi / 4)),
                  child: const Dot(
                    radius: 5.0,
                    color: Colors.deepPurpleAccent,
                  )),
              Transform.translate(
                  offset: Offset(
                      radius * cos(5 * pi / 4), radius * sin(5 * pi / 4)),
                  child: const Dot(
                    radius: 5.0,
                    color: Colors.redAccent,
                  )),
              Transform.translate(
                  offset: Offset(
                      radius * cos(6 * pi / 4), radius * sin(6 * pi / 4)),
                  child: const Dot(
                    radius: 5.0,
                    color: Colors.purpleAccent,
                  )),
              Transform.translate(
                  offset: Offset(
                      radius * cos(7 * pi / 4), radius * sin(7 * pi / 4)),
                  child: const Dot(
                    radius: 5.0,
                    color: Colors.deepPurpleAccent,
                  )),
              Transform.translate(
                  offset: Offset(
                      radius * cos(8 * pi / 4), radius * sin(8 * pi / 4)),
                  child: const Dot(
                    radius: 5.0,
                    color: Colors.yellowAccent,
                  )),
            ],
          ),
        ),
      ),
    );
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffCCEFFC),
//       appBar: AppBar(
//         leading:
//         Image.asset('assets/tealth_logo_250.png', width: 40, height: 40),
//         leadingWidth: 100,
//         title: const Text(
//           "Analyzing Tealth\.\.\.",
//           style: TextStyle(
//             fontFamily: 'Average Sans',
//             color: Color(0xff34346E),
//             fontSize: 18,
//           ),
//         ),
//         elevation: 0,
//         backgroundColor: const Color(0xffCCEFFC),
//         toolbarHeight: 130,
//       ),
//       body: Center(
//         child: RotationTransition(
//           turns: animation_rotation,
//           child: Stack(
//             children: <Widget>[
//               Dot(radius: 30.0, color: Colors.black12),
//               Transform.translate(
//                   offset: Offset(radius * cos(pi / 4), radius * sin(pi / 4)),
//                   child: Dot(
//                     radius: 5.0,
//                     color: Colors.redAccent,
//                   )),
//               Transform.translate(
//                   offset: Offset(
//                       radius * cos(2 * pi / 4), radius * sin(2 * pi / 4)),
//                   child: Dot(
//                     radius: 5.0,
//                     color: Colors.green,
//                   )),
//               Transform.translate(
//                   offset: Offset(
//                       radius * cos(3 * pi / 4), radius * sin(3 * pi / 4)),
//                   child: Dot(radius: 5.0, color: Colors.yellowAccent)),
//               Transform.translate(
//                   offset: Offset(
//                       radius * cos(4 * pi / 4), radius * sin(4 * pi / 4)),
//                   child: Dot(
//                     radius: 5.0,
//                     color: Colors.deepPurpleAccent,
//                   )),
//               Transform.translate(
//                   offset: Offset(
//                       radius * cos(5 * pi / 4), radius * sin(5 * pi / 4)),
//                   child: Dot(
//                     radius: 5.0,
//                     color: Colors.redAccent,
//                   )),
//               Transform.translate(
//                   offset: Offset(
//                       radius * cos(6 * pi / 4), radius * sin(6 * pi / 4)),
//                   child: Dot(
//                     radius: 5.0,
//                     color: Colors.purpleAccent,
//                   )),
//               Transform.translate(
//                   offset: Offset(
//                       radius * cos(7 * pi / 4), radius * sin(7 * pi / 4)),
//                   child: Dot(
//                     radius: 5.0,
//                     color: Colors.deepPurpleAccent,
//                   )),
//               Transform.translate(
//                   offset: Offset(
//                       radius * cos(8 * pi / 4), radius * sin(8 * pi / 4)),
//                   child: Dot(
//                     radius: 5.0,
//                     color: Colors.yellowAccent,
//                   )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  const Dot({required this.radius, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}

class ImageDot extends StatelessWidget {
  final double radius;

  const ImageDot({required this.radius});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: radius,
        height: radius,
        child: Image.asset('assets/tealth_logo_250.png', width: 40, height: 40),
      ),
    );
  }
}
