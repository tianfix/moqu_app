import 'package:flutter/material.dart';
import 'package:moqu_app/screens/quote_screen.dart';
import 'package:moqu_app/screens/profile_screen.dart';
import 'package:moqu_app/screens/saved_screen.dart';
import 'package:moqu_app/theme.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  int currentIndex = 0;
  final List<Widget> activePage = [
    QuoteScreen(),
    SavedScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: activePage[currentIndex],
      bottomNavigationBar: Container(
        height: 72,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              spreadRadius: 0,
              blurRadius: 20,
              offset: Offset(0, -1)
            )
          ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30)
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: screenTap,
            selectedItemColor: primaryColor,
            selectedFontSize: 12,
            unselectedItemColor: Colors.black.withOpacity(0.2),
            unselectedFontSize: 12,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/quote_icon.png',
                  height: 24,
                ),
                activeIcon: Image.asset(
                  'assets/images/quote_active_icon.png',
                  height: 24,
                ),
                label: 'Quote'
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/saved_icon.png',
                  width: 24,
                ),
                activeIcon: Image.asset(
                  'assets/images/saved_active_icon.png',
                  width: 24,
                ),
                label: 'Saved'
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/profile_icon.png',
                  width: 24,
                ),
                activeIcon: Image.asset(
                  'assets/images/profile_active_icon.png',
                  width: 24,
                ),
                label: 'Profile'
              )
            ],
          ),
        ),
      ),
    );
  }

  void screenTap (int index) {
    setState(() {
      currentIndex = index;
    });
  }

}