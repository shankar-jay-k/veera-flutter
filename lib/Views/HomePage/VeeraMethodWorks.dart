import 'package:flutter/material.dart';
import 'package:veera_education_flutter/Controllers/Colors.dart';
import 'package:video_player/video_player.dart';


class VeeraMethodWorks extends StatefulWidget {
  const VeeraMethodWorks({super.key});

  @override
  State<VeeraMethodWorks> createState() => _VeeraMethodWorksState();
}

class _VeeraMethodWorksState extends State<VeeraMethodWorks> {

  double width = 0;
  bool showVideo = false;

  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(
        'assets/Videoes/home.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.position == _videoPlayerController.value.duration) {
        setState(() {
          showVideo = !showVideo;
        });
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25,horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: appColors.Shadow_Clr2,
              offset: const Offset(
                1.0,
                3.0,
              ),
              blurRadius:10.0,
            ),         ],
        ),
        child: Column(
          children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Text('This is how',style: TextStyle(color: Colors.black,fontFamily: 'poppins-medium'),)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('VEERA`S ',style: TextStyle(color: Colors.black,fontFamily: 'poppins-bold'),),
                        Text('METHOD WORKS',style: TextStyle(color: Colors.black,fontFamily: 'poppins-medium',fontSize: 17),),
                      ],
                    )
                  ],
                ),
              ),
              Container(

                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12)),
                  color: appColors.ashGrey,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0,bottom: 10),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                            color: appColors.ashGrey,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 0.0, bottom: 10),
                            child: Center(
                              child: Stack(
                                children: [
                                  // Video Player
                                  if (showVideo)
                                    _videoPlayerController!.value.isInitialized
                                   ? InkWell(
                                      onTap: (){
                                        if (showVideo) {
                                          if (_videoPlayerController!.value.isPlaying) {
                                            _videoPlayerController?.pause();
                                          } else {
                                            _videoPlayerController?.play();
                                          }
                                        } else {
                                          showVideo = true;
                                          _videoPlayerController?.play();
                                        }
                                      },
                                     child: Container(
                                       width: screenUtils.getScreenWidth(context) > 500 ?  width * 0.9 :  width * 0.85,
                                       height: screenUtils.getScreenWidth(context) > 500 ?  280  : 200,
                                        child: VideoPlayer(_videoPlayerController!),
                                      ),
                                   )
                                   : InkWell(
                                      onTap: () {
                                        setState(() {
                                          showVideo = !showVideo;
                                        });
                                      },
                                      child: CircularProgressIndicator(),
                                    )
                                  else
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          showVideo = !showVideo;
                                          _videoPlayerController?.play();
                                        });
                                      },
                                      child: Image.asset(
                                        'assets/images/3.png',
                                        width: screenUtils.getScreenWidth(context) > 500 ?  width * 0.9 :  width * 0.85,
                                        height: screenUtils.getScreenWidth(context) > 500 ?  280  : 200,
                                      ),
                                    ),

                                  // Play/Pause Button
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: IconButton(
                                        icon: Icon(
                                          showVideo && _videoPlayerController!.value.isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          size: 45,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            if (showVideo) {
                                              if (_videoPlayerController!.value.isPlaying) {
                                                _videoPlayerController?.pause();
                                              } else {
                                                _videoPlayerController?.play();
                                              }
                                            } else {
                                              showVideo = true;
                                              _videoPlayerController?.play();
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 15,),
                      SizedBox(
                            width: width * 0.85,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(' DO NOT SKIP or MISS',style: TextStyle(fontFamily: 'poppins-bold',color: Color(
                                    0xffc2a66b),letterSpacing: 1.5),),
                                Visibility(
                                  visible: false,
                                  child: SizedBox(),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

