import 'package:doggy_date/utils/alerts.dart';
import 'package:doggy_date/utils/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'login_screen.dart';
import 'package:doggy_date/utils/custom_colors.dart';
import 'package:doggy_date/utils/custome_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  int _selectedTab = 0;
  bool _isProcessing = false;
  final _lookingForMate = 'looking for a mate';
  final _notLookingForMate = 'not looking for a mate';

  // TODO: use firebase to access this info
  Image _profileImage = Image.asset('assets/image/dolce.png');
  bool _isFemale = false;
  String _username = 'monanina13';
  String _currentStatus = 'looking for a mate';
  String _dogName = 'Dolce';
  String _dogBreed = 'Toy Poodle';
  // currentStatus can be: looking for a mate, not looking for a mate

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  _changeStatus(String status) {
    setState(() {
      _currentStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Color> femaleColors = [femaleDarkPink, femaleLightPink];
    List<Color> maleColors = [maleDarkBlue, maleLightBlue];
    List<Color> getProfileBorderColors = _isFemale ? femaleColors : maleColors;
    String getOppositeStatus = _currentStatus == _lookingForMate
        ? _notLookingForMate
        : _lookingForMate;
    Icon currentStatusIcon = _currentStatus == _lookingForMate
        ? Icon(Icons.favorite, color: loginBackground, size: 13)
        : Icon(CustomIcons.paw, color: loginBackground, size: 13);

    return Scaffold(
      key: _key,
      drawer: settingsDrawer,
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: _isFemale ? femaleDarkPink : maleDarkBlue,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 2),
            child: GestureDetector(
              onTap: () async {
                setState(() => _isProcessing = true);
                await FirebaseAuth.instance.signOut();
                await showLogoutAlert(context);
                setState(() => _isProcessing = false);
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: LoginScreen(),
                    type: PageTransitionType.leftToRightJoined,
                    childCurrent: HomeScreen(),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.logout),
                  GestureDetector(child: const Text('Log Out')),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: homeBackground,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: getProfileBorderColors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.elliptical(250, 100), //Radius.circular(350),
                bottomRight:
                    Radius.elliptical(250, 100), //Radius.circular(350),
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 35,
                  spreadRadius: 1,
                ),
              ],
            ),
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(height: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('assets/image/dolce.png'),
                    radius: 75,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Text(
                        _dogName,
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Shantell',
                          fontWeight: FontWeight.bold,
                          color: loginBackground,
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Text(
                        ', $_dogBreed',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Shantell',
                          fontWeight: FontWeight.w400,
                          color: loginBackground,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    currentStatusIcon,
                    Text(
                      _currentStatus,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Shantell',
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: loginBackground,
                      ),
                    ),
                    currentStatusIcon,
                  ],
                ),
                const SizedBox(height: 55),
                circleButton(CustomIcons.paw, () {}),
                const SizedBox(height: 15),
                circleButtonText('FIND A MATE', 16, color: white),
                const SizedBox(height: 25),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  circleButton(Icons.favorite, () {}),
                  const SizedBox(height: 15),
                  circleButtonText('BREEDING', 13),
                ],
              ),
              Column(
                // Center Button
                children: [
                  const SizedBox(height: 55),
                  circleButton(Icons.check_box_rounded, () {}),
                  const SizedBox(height: 15),
                  circleButtonText('LEGAL', 13),
                ],
              ),
              Column(
                children: [
                  circleButton(Icons.tips_and_updates, () {}),
                  const SizedBox(height: 15),
                  circleButtonText('TIPS', 13),
                ],
              ),
            ],
          ),
        ],
      ),

      // SizedBox(
      //   height: 40.0,
      //   width: 40.0,
      //   child: _isProcessing ? const CircularProgressIndicator() : null,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_rounded),
            label: 'inbox',
          )
        ],
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
      ),
    );
  }
}
