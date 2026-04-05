import 'package:flutter/material.dart';

class OtherInsights extends StatelessWidget {
  final String title;
  final String subt;
  final bool isExp;
  const OtherInsights({super.key,required this.title,required this.subt, required this.isExp});



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 300,
      decoration: BoxDecoration(
        color: isExp? const Color.fromARGB(255, 255, 165, 165) : const Color.fromARGB(255, 192, 255, 176),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
        
          children: [
            Text(title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),

            Text(subt, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),)
          ],
        ),
      ),
    );
  }
}