import 'package:animate_do/animate_do.dart';
import 'package:chat_bot/color_pallete.dart';
import 'package:chat_bot/custom_drawer.dart';
import 'package:chat_bot/feature_box.dart';
import 'package:chat_bot/open_ai_service.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  OpenAIService openAIService = OpenAIService();

  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  final player = AudioPlayer();
  String lastWords = '';
  String? generatedImageUrl;
  String? generateContent;
  
  int start = 300;
  int delay = 300;

  @override
  void initState() {
    initSpeechToText();
    initSpeechToText();
    super.initState();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }


  Future<void> initSpeechToText() async {
    speechToText.initialize();
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> _stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
    // print(lastWords);
  }

  Future<void> systemSpeaks(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    speechToText.stop();
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(lastWords);
    return Scaffold(
      appBar: AppBar(
        title: FadeInRight(child: const Text('AutoBot')),
        centerTitle: true,
        leading: SlideInLeft(
          child: Builder(builder: (context) {
            return InkWell(
              child: const Icon(
                Icons.menu,
              ),
               onTap: (){
                 Scaffold.of(context).openDrawer();
               }
            );
          }),
        ),
      ),
      drawer:  const CustomDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ZoomIn(
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 120,
                        width: 120,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          // color: Pallete.assistantCircleColor,
                          color: Colors.transparent
                        ),
                      ),
                    ),
                    Container(
                      height: 123,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/image/Autobot.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FadeInRightBig(
                child: Padding(
                  padding: const EdgeInsets.only(bottom:20),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(
                      top: 30,
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.black, width: 0.9),
                          bottom: BorderSide(color: Colors.black, width: 0.9),
                          left: BorderSide(color: Colors.black, width: 0.9),
                          right: BorderSide(color: Colors.black, width: 0.9)),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      generateContent == null
                          ? 'AutoBot Here!, what task can i do for you ?'
                          : generateContent!,
                      style: TextStyle(
                          fontSize: generateContent == null ? 22 : 18,
                          color: Pallete.blackColor,
                          fontFamily: 'Cera Pro'),
                    ),
                  ),
                ),
              ),
              SlideInLeft(
                child: Visibility(
                  visible: generateContent==null?true:false,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 10, left: 22),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Here are a few features',
                      style: TextStyle(
                          fontSize: 18,
                          color: Pallete.mainFontColor,
                          fontFamily: 'Cera Pro',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              //  Feature List
               Visibility(
                 visible: generateContent==null?true:false,
                 child: Column(
                  children: [
                    SlideInLeft(
                      delay: Duration(milliseconds: start),
                      child: const FeatureBox(
                          color: Pallete.firstSuggestionBoxColor,
                          headerText: 'ChatGPT',
                          descriptText:
                              'A smarter way to stay organized and informed with ChatGPT'),
                    ),
                    SlideInRight(
                      delay: Duration(milliseconds: start+delay),
                      child: const FeatureBox(
                          color: Pallete.secondSuggestionBoxColor,
                          headerText: 'Dall-E',
                          descriptText:
                              'Get inspired and stay creative with your personal assistant powered by Dall-E'),
                    ),
                    SlideInLeft(
                      delay: Duration(milliseconds: start + 2*delay),
                      child: const FeatureBox(
                          color: Pallete.thirdSuggestionBoxColor,
                          headerText: 'Smart Voice Assistant',
                          descriptText:
                              'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT'),
                    ),
                  ],
              ),
               ),
            ],
          ),
        ),
      ),
      floatingActionButton: ZoomIn(
        child: FloatingActionButton(
          onPressed: () async {
            if (await speechToText.hasPermission && speechToText.isNotListening) {
              await startListening();
            } else if (speechToText.isListening) {
              // print(lastWords);
              final speech = await openAIService.chatGPTAPI(lastWords);

              if (speech.contains('https')) {
                generatedImageUrl = speech;
                print(generatedImageUrl);
                generateContent = null;
                setState(() {});
              } else {
                generatedImageUrl = null;
                generateContent = speech;
                setState(() {});
                await systemSpeaks(speech);
              }
              await _stopListening();
            } else {
              initSpeechToText();
            }
          },
          // backgroundColor: Pallete.firstSuggestionBoxColor,
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.mic,color: Colors.white,),
        ),
      ),
    );
  }
}


