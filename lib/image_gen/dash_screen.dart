import 'package:chat_bot/color_pallete.dart';
import 'package:chat_bot/image_gen/result_page.dart';
import 'package:chat_bot/loader.dart';
import 'package:chat_bot/open_ai_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ImageGenerator extends StatefulWidget {
  const ImageGenerator({Key? key}) : super(key: key);

  @override
  State<ImageGenerator> createState() => _ImageGeneratorState();
}

class _ImageGeneratorState extends State<ImageGenerator> {
  TextEditingController textEditingController= TextEditingController();
  OpenAIService DallE=OpenAIService();
   late final String imageURl;
  final formKey = GlobalKey<FormState>();

  String? Validator(String? text) {
    if(text==null){
      return 'Enter correct image description ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Gen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 100),
              height: 123,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/image/Autobot.png'),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 80),
              child: TextFormField(
                key: formKey,
                controller: textEditingController,
                validator: Validator,
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'ENTER IMAGE INFORMATION ',
                  hintStyle: TextStyle(color: Colors.white),
                  fillColor: Pallete.firstSuggestionBoxColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent
                ),
                onPressed: ()async{
                  ShowModal.showLoadingModal(context);
                      imageURl= await DallE.dallEAPI(textEditingController.text.trim());
                      textEditingController.clear();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ResultPage(imageURl: imageURl)));
                },
                child: Text('Generate Image',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
