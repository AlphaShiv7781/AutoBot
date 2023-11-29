import 'package:chat_bot/home_page.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';

class ResultPage extends StatefulWidget {
  ResultPage({Key? key, required this.imageURl}) : super(key: key);
  final String imageURl;
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Future<void> downloadAndSaveImage(String imageUrl) async {
    try {
      // Make a GET request to the image URL
      var response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Get the app's local documents directory
        var appDocumentsDirectory = await getApplicationDocumentsDirectory();
        var filePath = appDocumentsDirectory.path + '/downloaded_image.png';

        // Write the image data to a file
        await File(filePath).writeAsBytes(response.bodyBytes);

        print('Image downloaded and saved to: $filePath');
      } else {
        print('Failed to download image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error downloading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 200.0, horizontal: 20),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                // child: Image.network(widget.imageURl,fit: BoxFit.fill,)),
                child: CachedNetworkImage(
                  imageUrl: widget.imageURl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.fill,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 20.0),
              //   child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //           backgroundColor: Colors.redAccent
              //       ),
              //       onPressed: () {
              //
              //       },
              //       child: Text(
              //         'Download',
              //         style: TextStyle(
              //             fontSize: 20,
              //             color: Colors.white,
              //             fontWeight: FontWeight.bold),
              //       )),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent),
                    onPressed: () {

                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomePage()));
                    },
                    child: Text(
                      'Go Back',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
