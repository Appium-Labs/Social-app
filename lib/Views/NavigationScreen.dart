import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/Views/HomeScreen/HomeScreen.dart';
import 'package:social_app/Views/PostScreen/PostScreen.dart';
import 'package:social_app/Views/SearchScreen/SearchScreen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SearchScreen(),
    PostScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              "assets/icons/home-filled.svg",
            ),
            icon: SvgPicture.asset(
              "assets/icons/home-unfilled.svg",
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              "assets/icons/explore-filled.svg",
            ),
            icon: SvgPicture.asset("assets/icons/explore-unfilled.svg"),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              "assets/icons/upload-filled.svg",
            ),
            icon: SvgPicture.asset("assets/icons/upload-unfilled.svg"),
            label: 'Request',
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              "assets/icons/chat-filled.svg",
            ),
            icon: SvgPicture.asset("assets/icons/chat-unfilled.svg"),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              "assets/icons/profile-filled.svg",
            ),
            icon: SvgPicture.asset(
              "assets/icons/profile-unfilled.svg",
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }
}
