import 'package:doggy_date/utils/alerts.dart';
import 'package:doggy_date/utils/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'login_screen.dart';
import 'package:doggy_date/utils/custom_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;
  bool _isProcessing = false;
  final _lookingForMate = 'looking for a mate';
  final _notLookingForMate = 'not looking for a mate';

  // TODO: use firebase to access this info
  Image _profileImage = Image.asset('assets/image/dolce.png');
  bool _isFemale = true;
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
    Color pawIconColor = _isFemale ? femaleIconPink : maleIconBlue;
    String getOppositeStatus = _currentStatus == _lookingForMate
        ? _notLookingForMate
        : _lookingForMate;
    Icon currentStatusIcon = _currentStatus == _lookingForMate
        ? Icon(Icons.favorite, color: loginBackround, size: 13)
        : Icon(CustomIcons.paw, color: loginBackround, size: 13);

    return Scaffold(
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
                bottomLeft: Radius.elliptical(300, 85), //Radius.circular(350),
                bottomRight: Radius.elliptical(300, 85), //Radius.circular(350),
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 35,
                  spreadRadius: 5,
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
                          color: loginBackround,
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
                          color: loginBackround,
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
                        color: loginBackround,
                      ),
                    ),
                    currentStatusIcon,
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.settings, size: 30, color: white),
                        Text(
                          'Settings',
                          style: TextStyle(
                            fontFamily: 'Shantell',
                            fontSize: 15,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        Icon(Icons.home, size: 30, color: white),
                        Text(
                          'Home',
                          style: TextStyle(
                            fontFamily: 'Shantell',
                            fontSize: 15,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(Icons.phone, size: 30, color: loginBackround),
                SizedBox(height: 15),
              ],
            ),
          ),
          SizedBox(
            height: 40.0,
            width: 40.0,
            child: _isProcessing ? const CircularProgressIndicator() : null,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.paw, color: pawIconColor),
            label: 'find a mate©',
          ),
          const BottomNavigationBarItem(
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
