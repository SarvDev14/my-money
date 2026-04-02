import 'package:flutter/material.dart';

class InsightsCard extends StatelessWidget {
  final String title;
  final String subtitle;
  const InsightsCard({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: 180,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 48, 82, 255),
        borderRadius: BorderRadius.circular(15),
        
      ),
     
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
        
          children: [
            Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
            SizedBox(height: 10,),
            Text(subtitle, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),)
        
          ],
        ),
      ),
    );
  }
}