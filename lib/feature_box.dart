import 'package:chat_bot/color_pallete.dart';
import 'package:flutter/material.dart';
class FeatureBox extends StatelessWidget {
  const FeatureBox({Key? key, required this.color, required this.headerText, required this.descriptText}) : super(key: key);
  final Color color;
  final String headerText;
  final String descriptText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35,vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0).copyWith(left: 15),
        child: Column(
          children: [
            Align(alignment: Alignment.centerLeft,child: Text(headerText,style: const TextStyle(fontFamily: 'Cera Pro',fontSize: 18,color: Pallete.blackColor,fontWeight: FontWeight.bold),)),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(descriptText,style: const TextStyle(fontFamily: 'Cera Pro',fontSize: 14,color: Pallete.blackColor,),),
            ),
          ],
        ),
      ),
    );
  }
}
