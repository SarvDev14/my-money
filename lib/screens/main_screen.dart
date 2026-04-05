import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:my_money/widgets/bottom_nav_bar.dart';
import 'home_screen.dart';
import 'transactions_screen.dart';
import 'insights_screen.dart';

class MainScreen extends StatefulWidget {
  static void navigateToTab(BuildContext context, int index) {
    final state = context.findAncestorStateOfType<_MainScreenState>();
    state?._onItemTapped(index);
  }
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    InsightsScreen(),
    TransactionsScreen(),
    
  ];

  

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [

          // 🔹 Main Screen
          Positioned.fill(
            child: _screens[_selectedIndex],
          ),

          // 🔹 Floating Bottom Nav
          Positioned(
            bottom: 2,
            left: 16,
            right: 16,
            child: BottomNavBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}