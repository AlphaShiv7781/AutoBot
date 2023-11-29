import 'package:chat_bot/chatGPT/screens/chat_screen.dart';
import 'package:chat_bot/color_pallete.dart';
import 'package:chat_bot/image_gen/dash_screen.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);


  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

   void Selector(int index){
     if(index==1)
     {
       Navigator.push(context, MaterialPageRoute(builder: (context)=>const ChatScreen()));
     }
     else
     {
       Navigator.push(context, MaterialPageRoute(builder: (context)=>const ImageGenerator()));
     }
   }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Pallete.firstSuggestionBoxColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 120.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [

            const CircleAvatar(
              radius: 50,
              backgroundColor: Pallete.blackColor,
              foregroundImage: AssetImage('assets/image/person.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0,bottom: 10),
              child: Text('More features...',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0,left: 20,right: 20),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Selector(1);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Pallete.whiteColor,
                  ),
                  child: const Text('ChatGPT',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'Cera Pro',color: Pallete.blackColor),),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0,left: 20,right: 20),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                     Selector(2);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Pallete.whiteColor,
                  ),
                  child: const Text('Image Genarator', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'Cera Pro',color: Pallete.blackColor),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
