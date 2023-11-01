import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scalpinspector_app/animation.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
    animationController.forward();
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/3.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeAnimation(
                delay: 1,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 80.0), // Adjust the padding value as needed
                  child: Image.asset(
                    'assets/scalp_logo.png', // Replace with the path to your image
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
              FadeAnimation(
                delay: 2,
                child: Text(
                  'SCALP INSPECTOR',
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedGradient extends StatefulWidget {
  @override
  _AnimatedGradientState createState() => _AnimatedGradientState();
}

class _AnimatedGradientState extends State<AnimatedGradient> {
  List<HexColor> colorList = [
    HexColor('fccc8c'),
    HexColor('fab67e'),
    HexColor('f89f6f'),
    HexColor('f78961'),
  ];
  List<Alignment> alignmentList = [
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topRight,
    Alignment.topLeft,
  ];
  int index = 0;
  Color bottomColor = HexColor('fccc8c');
  Color topColor = HexColor('f78961');
  Alignment begin = Alignment.bottomLeft;
  Alignment end = Alignment.topRight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        AnimatedContainer(
          duration: Duration(seconds: 2),
          onEnd: () {
            setState(() {
              index = index + 1;

              bottomColor = colorList[index % colorList.length];
              topColor = colorList[(index + 1) % colorList.length];
            });
          },
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: begin, end: end, colors: [bottomColor, topColor])),
        ),
        Positioned(
          top: 150,
          left: 80,
          right: 80,
          child: Image.asset(
            'assets/scalp_logo.png',
          ),
        ),
        Positioned(
          bottom: 180,
          left: 50,
          right: 50,
          child: Text(
            'SCALP\n INSPECTOR',
            style: TextStyle(
                fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ));
  }
}

class AnimatingBg1 extends StatefulWidget {
  @override
  _AnimatingBg1State createState() => _AnimatingBg1State();
}

class _AnimatingBg1State extends State<AnimatingBg1>
    with TickerProviderStateMixin {
  List<Color> colorList = [
    HexColor('fccc8c'),
    HexColor('fab67e'),
    HexColor('f89f6f'),
    HexColor('f78961'),
  ];
  List<Alignment> alignmentList = [Alignment.topCenter, Alignment.bottomCenter];
  int index = 0;
  Color bottomColor = HexColor('f78961');
  Color topColor = HexColor('fccc8c');
  Alignment begin = Alignment.bottomCenter;
  Alignment end = Alignment.topCenter;

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(microseconds: 0),
      () {
        setState(
          () {
            bottomColor = HexColor('f78961');
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      onEnd: () {
        setState(
          () {
            index = index + 1;
            bottomColor = colorList[index % colorList.length];
            topColor = colorList[(index + 1) % colorList.length];
          },
        );
      },
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: [bottomColor, topColor],
        ),
      ),
      child: Stack(children: [
        Positioned(
          top: 150,
          left: 80,
          right: 80,
          child: FadeAnimation(
            delay: 2,
            child: Image.asset(
              'assets/scalplogo.png',
            ),
          ),
        ),
      ]),
    );
  }
}
