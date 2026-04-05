import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  final void Function(int)? onItemTapped;
  final int selectedIndex;
  const BottomNavBar({super.key, required this.onItemTapped, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: GNav(
            selectedIndex: selectedIndex,
            onTabChange: onItemTapped,
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            padding: EdgeInsets.all(15),
            
            gap: 7,
            tabs:[
              GButton(icon: Icons.home, iconColor: Colors.white, text: "Home", textColor: Colors.white,),
              GButton(icon: Icons.trending_up,text: "Insights", iconColor: Colors.white,textColor: Colors.white),
              GButton(icon: Icons.currency_rupee, text: "History", iconColor: Colors.white,textColor: Colors.white)
          
            ]),
        ),
      );
  }
}