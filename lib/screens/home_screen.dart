import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:scalpinspector_app/help.dart';
import 'package:scalpinspector_app/history.dart';
import 'package:scalpinspector_app/screens/chatbot_screen.dart';
import 'package:scalpinspector_app/screens/diagnose_screen.dart';

import 'package:scalpinspector_app/screens/feedback_screen.dart';
import 'package:scalpinspector_app/screens/profile_screen.dart';
import 'package:scalpinspector_app/screens/reminder_screen.dart';

import 'package:scalpinspector_app/services.dart';
import 'package:scalpinspector_app/about.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  User? user = FirebaseAuth.instance.currentUser;
  final List<Widget> _screens = [
    HomeContent(),
    HelpScreen(),
    ProfileScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0
          ? AppBar(
              backgroundColor: HexColor('fccc8c'),
              toolbarHeight: 50,
              automaticallyImplyLeading: true,
              iconTheme: const IconThemeData(
                size: 35,
                color: Colors.white,
              ),
            )
          : null,
      // Show app bar only on the home screen
      body: _screens[_currentIndex],
      drawer: _currentIndex == 0 ? _buildDrawer() : null,
      // Show drawer only on the home screen
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        onTap: _onTabSelected,
        items: const [
          Icon(
            Icons.home,
            size: 35,
            color: Colors.white,
          ),
          Icon(
            Icons.help,
            size: 35,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 35,
            color: Colors.white,
          ),
        ],
        color: HexColor('f78961'),
        backgroundColor: Colors.white,
        buttonBackgroundColor: HexColor('f78961'),
        height: 50,
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      width: 200.0,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/robot_pic.png',
                        width: 100.0,
                        height: 100.0,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'hi, ${FirebaseAuth.instance.currentUser!.displayName}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AboutScreen()), // Open the Services screen
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: const Text('Services'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ServicesScreen()), // Open the Services screen
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Feedback'),
            onTap: () {
              // Navigate to the Feedback screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FeedbackScreen()),
              );
            },
          ),

          //logout
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              //make a dialoge
              Get.dialog(AlertDialog(
                title: const Text('Logout'),
                content: const Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      if (!mounted) return;
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                    child: const Text('Yes'),
                  ),
                ],
              ));
            },
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List<Color> customColor = <Color>[
    Colors.blue.shade200,
    Colors.orange.shade200,
    Colors.pink.shade200,
    Colors.green.shade200
  ];

  List<Color> textColor = <Color>[
    Colors.blue,
    Colors.orange,
    Colors.pink,
    Colors.green
  ];

  List<String> images = [
    'https://cdn-icons-png.flaticon.com/128/9733/9733578.png',
    'https://cdn-icons-png.flaticon.com/128/1147/1147509.png',
    'https://cdn-icons-png.flaticon.com/128/6784/6784507.png',
    'https://cdn-icons-png.flaticon.com/128/2707/2707335.png',
  ];

  List<String> titles = [
    'Diagnosis',
    'Reminder',
    'DocAssist',
    'History',
  ];

  void _navigateToScreen(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DiagnoseScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReminderScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatbotScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HistoryScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 250,
                // color: Colors.blue,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      HexColor('fccc8c'),
                      HexColor('fab67e'),
                      HexColor('f89f6f'),
                      HexColor('f78961'),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                          'https://www.revixpert.ch/app/uploads/portrait-placeholder.jpg'),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      '${FirebaseAuth.instance.currentUser!.displayName}',
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              )),
          Positioned(
            top: 200,
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(30))),
              child: Column(
                children: [
                  StaggeredGridView.countBuilder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          _navigateToScreen(index);
                        },
                        child: Stack(
                          children: [
                            Container(
                              color: Colors.white,
                              height: 200,
                            ),
                            Positioned(
                              top: 20,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 150,
                                padding: const EdgeInsets.all(10),
                                decoration: ShapeDecoration(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  color: customColor[index],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          titles[index],
                                          style: GoogleFonts.robotoCondensed(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 3,
                                          ),
                                        ),
                                        const Gutter(),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                    const Gutter(),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 50,
                              child: Image.network(
                                images[index],
                                height: 90,
                                width: 90,
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                    mainAxisSpacing: 30.0,
                    crossAxisSpacing: 16.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}