import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';
import 'package:video_player/video_player.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final VideoPlayerController videoPlayerController =
      VideoPlayerController.asset('assets/images/landing screen video.mp4');
  ChewieController? chewieController;
  @override
  void initState() {
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: 9 / 20,
        autoPlay: true,
        looping: true,
        autoInitialize: true,
        showControls: false);
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.amber,
      body: Stack(
        children: [
          Expanded(child: Chewie(controller: chewieController!)),
          Positioned(
              top: querySize.height * 0.059,
              left: querySize.width * 0.059,
              child: Image.asset(
                "assets/images/white_logo_image.png",
                width: querySize.width * 0.1,
                height: querySize.height * 0.1,
              )),
          Positioned(
              bottom: querySize.height * 0.28,
              left: querySize.width * 0.12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Discover Timeless\n         Elegence',
                    style: TextStyle(
                      fontFamily: 'ElMessiri',
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: querySize.width * 0.085,
                    ),
                  ),
                  SizedBox(
                    height: querySize.height * 0.018,
                  ),
                  Text(
                    "Welcome to Lenore, your gateway to timeless\n              elegance and exquisite jewelry",
                    style: TextStyle(
                      fontFamily: 'Segoe',
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: querySize.width * 0.034,
                    ),
                  ),
                ],
              )),
          Positioned(
              bottom: querySize.height * 0.18,
              left: querySize.width * 0.14,
              child: Container(
                height: querySize.height * 0.06,
                width: querySize.width * 0.7,
                decoration: BoxDecoration(
                    color: appColor,
                    borderRadius:
                        BorderRadius.circular(querySize.width * 0.059)),
                child: Center(
                  child: Text(
                    "GET STARTED",
                    style: TextStyle(
                      fontFamily: 'Segoe',
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: querySize.width * 0.034,
                    ),
                  ),
                ),
              )),
          Positioned(
            bottom: querySize.height * 0.13,
            left: querySize.width * 0.33,
            child: Text(
              "CONTINUE AS GUEST",
              style: TextStyle(
                fontFamily: 'Segoe',
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: querySize.width * 0.034,
              ),
            ),
          )
        ],
      ),
    );
  }
}
