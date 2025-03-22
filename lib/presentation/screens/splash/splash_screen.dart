import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

import 'package:lenore/presentation/screens/splash/widgets/custom_timer.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
    wait(context);
  }

  Future<void> _initializeVideo() async {
    videoPlayerController =
        VideoPlayerController.asset("assets/images/story.mp4");

    // Wait for the video to be initialized before creating the ChewieController
    await videoPlayerController.initialize();

    // Only proceed if the widget is still mounted
    if (!mounted) return;

    final querySize = MediaQuery.of(context).size;

    setState(() {
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: querySize.aspectRatio,
        autoPlay: true,
        looping: true,
        showControls: false,
        // Add a placeholder builder to show while video loads
        placeholder: Container(
          color: Colors
              .black, // Or any other color that matches your video's first frame
        ),
      );
      _isVideoInitialized = true;
    });

    // Optional: Preload the next video frame
    await videoPlayerController.setLooping(true);
    await videoPlayerController.play();
  }

  @override
  void dispose() {
    videoPlayerController.pause();
    chewieController?.dispose();
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Change to match your video's background
      body: AnimatedOpacity(
        opacity: _isVideoInitialized ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: SizedBox.expand(
          child: chewieController != null
              ? Chewie(controller: chewieController!)
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white, // Adjust color as needed
                  ),
                ),
        ),
      ),
    );
  }
}
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   late final VideoPlayerController videoPlayerController;
//   ChewieController? chewieController;

//   @override
//   void initState() {
//     super.initState();
//     videoPlayerController =
//         VideoPlayerController.asset("assets/images/story.mp4");
//     // VideoPlayerController.asset('assets/images/landing_screen_video.mp4');
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       var querySize = MediaQuery.of(context).size;
//       setState(() {
//         chewieController = ChewieController(
//           videoPlayerController: videoPlayerController,
//           aspectRatio: querySize.aspectRatio, // Use the screen's aspect ratio
//           autoPlay: true,
//           looping: true,
//           showControls: false,
//         );
//       });
//     });
//     wait(context);
//   }

//   @override
//   void dispose() {
//     // Pause the video before disposing
//     videoPlayerController.pause();

//     // Dispose of controllers if they are not null
//     chewieController?.dispose();
//     videoPlayerController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Positioned.fill(
//         child: chewieController != null
//             ? Chewie(controller: chewieController!)
//             : Center(child: CircularProgressIndicator()),
//       ),
//     );
//   }
//   // @override
//   // void initState() {
//   //   wait(context);
//   //   super.initState();
//   // }

//   // @override
//   // Widget build(BuildContext context) {
//   //   var querySize = MediaQuery.of(context).size;
//   //   return Container(
//   //     color: Colors.white,
//   //     child: Column(
//   //       mainAxisAlignment: MainAxisAlignment.center,
//   //       //crossAxisAlignment: CrossAxisAlignment.center,
//   //       children: [
//   //         Image.asset(
//   //           "assets/images/splash.png",
//   //           width: querySize.width * 0.45, // Set the desired width
//   //           height: querySize.height * 0.4,
//   //         )
//   //       ],
//   //     ),
//   //   );
//   // }
// }
