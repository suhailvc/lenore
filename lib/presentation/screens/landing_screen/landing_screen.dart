import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/login_screen/mobile_number_screen/mobile_number_screen.dart';
import 'package:lenore/presentation/screens/persistant_bottom_nav_bar/persistant_bottom_nav_bar.dart';
import 'package:video_player/video_player.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late final VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    videoPlayerController =
        VideoPlayerController.asset('assets/images/landing_screen_video.mp4');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var querySize = MediaQuery.of(context).size;
      setState(() {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          aspectRatio: querySize.aspectRatio, // Use the screen's aspect ratio
          autoPlay: true,
          looping: true,
          showControls: false,
        );
      });
    });
  }

  @override
  void dispose() {
    // Pause the video before disposing
    videoPlayerController.pause();

    // Dispose of controllers if they are not null
    chewieController?.dispose();
    videoPlayerController.dispose();

    super.dispose();
  }

  // @override
  // void dispose() {
  //   videoPlayerController.dispose();
  //   chewieController?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Full-screen background video
          Positioned.fill(
            child: chewieController != null
                ? Chewie(controller: chewieController!)
                : Center(child: CircularProgressIndicator()),
          ),
          // Logo positioned at the top left
          Positioned(
            top: querySize.height * 0.059,
            left: querySize.width * 0.059,
            child: Image.asset(
              "assets/images/white_logo_image.png",
              width: querySize.width * 0.1,
              height: querySize.height * 0.1,
            ),
          ),
          // Welcome text and tagline
          Positioned(
            bottom: querySize.height * 0.28,
            left: querySize.width * 0.12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Discover Timeless\n         Elegance',
                  style: TextStyle(
                    fontFamily: 'ElMessiri',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: querySize.width * 0.085,
                  ),
                ),
                SizedBox(height: querySize.height * 0.018),
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
            ),
          ),
          // "GET STARTED" button
          Positioned(
            bottom: querySize.height * 0.18,
            left: querySize.width * 0.14,
            child: GestureDetector(
              onTap: () {
                videoPlayerController.pause();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MobileNumberInputScreen(),
                    ));
              },
              child: Container(
                height: querySize.height * 0.06,
                width: querySize.width * 0.7,
                decoration: BoxDecoration(
                  color: appColor,
                  borderRadius: BorderRadius.circular(querySize.width * 0.059),
                ),
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
              ),
            ),
          ),
          // "CONTINUE AS GUEST" text
          Positioned(
            bottom: querySize.height * 0.13,
            left: querySize.width * 0.33,
            child: GestureDetector(
              onTap: () {
                // Handle "CONTINUE AS GUEST" button tap here
              },
              child: GestureDetector(
                onTap: () {
                  videoPlayerController.pause();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersistantBottomNavBarScreen(),
                      ));
                },
                child: Text(
                  "CONTINUE AS GUEST",
                  style: TextStyle(
                    fontFamily: 'Segoe',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: querySize.width * 0.034,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:lenore/core/constant.dart';
// import 'package:video_player/video_player.dart';

// class LandingScreen extends StatefulWidget {
//   const LandingScreen({super.key});

//   @override
//   State<LandingScreen> createState() => _LandingScreenState();
// }

// class _LandingScreenState extends State<LandingScreen> {
//   late final VideoPlayerController videoPlayerController;
//   ChewieController? chewieController;

//   @override
//   void initState() {
//     super.initState();
//     videoPlayerController =
//         VideoPlayerController.asset('assets/images/landing_screen_video.mp4');
//     chewieController = ChewieController(
//       videoPlayerController: videoPlayerController,
//       aspectRatio:
//           MediaQuery.of(context).size.aspectRatio, // Match screen aspect ratio
//       autoPlay: true,
//       looping: true,
//       autoInitialize: true,
//       showControls: false,
//     );
//   }

//   @override
//   void dispose() {
//     videoPlayerController.dispose();
//     chewieController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: Colors.amber,
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: chewieController != null
//                 ? Chewie(controller: chewieController!)
//                 : Center(child: CircularProgressIndicator()),
//           ),
//           Positioned(
//             top: querySize.height * 0.059,
//             left: querySize.width * 0.059,
//             child: Image.asset(
//               "assets/images/white_logo_image.png",
//               width: querySize.width * 0.1,
//               height: querySize.height * 0.1,
//             ),
//           ),
//           Positioned(
//             bottom: querySize.height * 0.28,
//             left: querySize.width * 0.12,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   'Discover Timeless\n         Elegance',
//                   style: TextStyle(
//                     fontFamily: 'ElMessiri',
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontSize: querySize.width * 0.085,
//                   ),
//                 ),
//                 SizedBox(height: querySize.height * 0.018),
//                 Text(
//                   "Welcome to Lenore, your gateway to timeless\n              elegance and exquisite jewelry",
//                   style: TextStyle(
//                     fontFamily: 'Segoe',
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontSize: querySize.width * 0.034,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: querySize.height * 0.18,
//             left: querySize.width * 0.14,
//             child: GestureDetector(
//               onTap: () {
//                 // Handle "GET STARTED" button tap here
//               },
//               child: Container(
//                 height: querySize.height * 0.06,
//                 width: querySize.width * 0.7,
//                 decoration: BoxDecoration(
//                   color: appColor,
//                   borderRadius: BorderRadius.circular(querySize.width * 0.059),
//                 ),
//                 child: Center(
//                   child: Text(
//                     "GET STARTED",
//                     style: TextStyle(
//                       fontFamily: 'Segoe',
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                       fontSize: querySize.width * 0.034,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: querySize.height * 0.13,
//             left: querySize.width * 0.33,
//             child: GestureDetector(
//               onTap: () {
//                 // Handle "CONTINUE AS GUEST" button tap here
//               },
//               child: Text(
//                 "CONTINUE AS GUEST",
//                 style: TextStyle(
//                   fontFamily: 'Segoe',
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                   fontSize: querySize.width * 0.034,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class LandingScreen extends StatefulWidget {
//   const LandingScreen({super.key});

//   @override
//   State<LandingScreen> createState() => _LandingScreenState();
// }

// class _LandingScreenState extends State<LandingScreen> {
//   late final VideoPlayerController videoPlayerController;
//   ChewieController? chewieController;

//   @override
//   void initState() {
//     super.initState();
//     videoPlayerController =
//         VideoPlayerController.asset('assets/images/landing_screen_video.mp4');
//     chewieController = ChewieController(
//       videoPlayerController: videoPlayerController,
//       aspectRatio: 9 / 20,
//       autoPlay: true,
//       looping: true,
//       autoInitialize: true,
//       showControls: false,
//     );
//   }

//   @override
//   void dispose() {
//     videoPlayerController.dispose();
//     chewieController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: Colors.amber,
//       body: Stack(
//         children: [
//           if (chewieController != null)
//             Chewie(controller: chewieController!)
//           else
//             Center(child: CircularProgressIndicator()),
//           Positioned(
//             top: querySize.height * 0.059,
//             left: querySize.width * 0.059,
//             child: Image.asset(
//               "assets/images/white_logo_image.png",
//               width: querySize.width * 0.1,
//               height: querySize.height * 0.1,
//             ),
//           ),
//           Positioned(
//             bottom: querySize.height * 0.28,
//             left: querySize.width * 0.12,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   'Discover Timeless\n         Elegance',
//                   style: TextStyle(
//                     fontFamily: 'ElMessiri',
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontSize: querySize.width * 0.085,
//                   ),
//                 ),
//                 SizedBox(height: querySize.height * 0.018),
//                 Text(
//                   "Welcome to Lenore, your gateway to timeless\n              elegance and exquisite jewelry",
//                   style: TextStyle(
//                     fontFamily: 'Segoe',
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontSize: querySize.width * 0.034,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: querySize.height * 0.18,
//             left: querySize.width * 0.14,
//             child: GestureDetector(
//               onTap: () {
//                 // Handle "GET STARTED" button tap here
//               },
//               child: Container(
//                 height: querySize.height * 0.06,
//                 width: querySize.width * 0.7,
//                 decoration: BoxDecoration(
//                   color: appColor,
//                   borderRadius: BorderRadius.circular(querySize.width * 0.059),
//                 ),
//                 child: Center(
//                   child: Text(
//                     "GET STARTED",
//                     style: TextStyle(
//                       fontFamily: 'Segoe',
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                       fontSize: querySize.width * 0.034,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: querySize.height * 0.13,
//             left: querySize.width * 0.33,
//             child: GestureDetector(
//               onTap: () {
//                 // Handle "CONTINUE AS GUEST" button tap here
//               },
//               child: Text(
//                 "CONTINUE AS GUEST",
//                 style: TextStyle(
//                   fontFamily: 'Segoe',
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                   fontSize: querySize.width * 0.034,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class LandingScreen extends StatefulWidget {
//   const LandingScreen({super.key});

//   @override
//   State<LandingScreen> createState() => _LandingScreenState();
// }

// class _LandingScreenState extends State<LandingScreen> {
//   final VideoPlayerController videoPlayerController =
//       VideoPlayerController.asset('assets/images/landing screen video.mp4');
//   ChewieController? chewieController;
//   @override
//   void initState() {
//     chewieController = ChewieController(
//         videoPlayerController: videoPlayerController,
//         aspectRatio: 9 / 20,
//         autoPlay: true,
//         looping: true,
//         autoInitialize: true,
//         showControls: false);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     videoPlayerController.dispose();
//     chewieController!.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: Colors.amber,
//       body: Stack(
//         children: [
//           //Expanded(child:
//           Chewie(controller: chewieController!),
//           //),
//           Positioned(
//               top: querySize.height * 0.059,
//               left: querySize.width * 0.059,
//               child: Image.asset(
//                 "assets/images/white_logo_image.png",
//                 width: querySize.width * 0.1,
//                 height: querySize.height * 0.1,
//               )),
//           Positioned(
//               bottom: querySize.height * 0.28,
//               left: querySize.width * 0.12,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Discover Timeless\n         Elegence',
//                     style: TextStyle(
//                       fontFamily: 'ElMessiri',
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                       fontSize: querySize.width * 0.085,
//                     ),
//                   ),
//                   SizedBox(
//                     height: querySize.height * 0.018,
//                   ),
//                   Text(
//                     "Welcome to Lenore, your gateway to timeless\n              elegance and exquisite jewelry",
//                     style: TextStyle(
//                       fontFamily: 'Segoe',
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                       fontSize: querySize.width * 0.034,
//                     ),
//                   ),
//                 ],
//               )),
//           Positioned(
//               bottom: querySize.height * 0.18,
//               left: querySize.width * 0.14,
//               child: Container(
//                 height: querySize.height * 0.06,
//                 width: querySize.width * 0.7,
//                 decoration: BoxDecoration(
//                     color: appColor,
//                     borderRadius:
//                         BorderRadius.circular(querySize.width * 0.059)),
//                 child: Center(
//                   child: Text(
//                     "GET STARTED",
//                     style: TextStyle(
//                       fontFamily: 'Segoe',
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                       fontSize: querySize.width * 0.034,
//                     ),
//                   ),
//                 ),
//               )),
//           Positioned(
//             bottom: querySize.height * 0.13,
//             left: querySize.width * 0.33,
//             child: Text(
//               "CONTINUE AS GUEST",
//               style: TextStyle(
//                 fontFamily: 'Segoe',
//                 color: Colors.white,
//                 fontWeight: FontWeight.w600,
//                 fontSize: querySize.width * 0.034,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
