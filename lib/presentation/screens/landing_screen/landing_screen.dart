// import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  // final VideoPlayerController videoPlayerController =
  //     VideoPlayerController.asset('assets/images/landing screen video.mp4');
  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    //  ChewieController? chewieController;
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Stack(
        children: [
          Positioned(
              top: querySize.height * 0.045,
              left: querySize.width * 0.038,
              child: Image.asset(
                "assets/images/white_logo_image.png",
                width: querySize.width * 0.1,
                height: querySize.height * 0.1,
              )),
          Positioned(
              bottom: querySize.height * 0.28,
              left: querySize.width * 0.13,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Discover Timeless\nElegence',
                    style: TextStyle(
                      fontFamily: 'ElMessiri',
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: querySize.width * 0.08,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
