import 'package:expandable/expandable.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:veera_education_flutter/Controllers/Colors.dart';
import 'package:veera_education_flutter/Models/Toasts.dart';
import 'package:veera_education_flutter/Views/HomePage/ClassRoom/CommentSection.dart';
import 'package:video_player/video_player.dart';


class IndexForClassRoom extends StatefulWidget {
  const IndexForClassRoom({super.key});

  @override
  State<IndexForClassRoom> createState() => _IndexForClassRoomState();
}

class _IndexForClassRoomState extends State<IndexForClassRoom> {
  int id = -1;
  String comment = 'All';
  ScrollController _scrollController = ScrollController();
  String user = 'learner';
  late FlickManager flickManager;
  String sectionShowing = 'index';
  ExpandableController? expandableController;
  List segments = ['Pronoun','Grammar','Sentence','Grammar','Grammar'];

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      autoPlay: false,

      videoPlayerController:
      VideoPlayerController.asset('assets/Videoes/home.mp4'),
    );
  }

  @override
  void dispose() {

    flickManager.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: appColors.scaffold,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        elevation: 0.5,
        leadingWidth: 80,
        leading: InkWell(
          onTap: (){
            setState(() {
              if(user == 'learner'){
                user = 'admin';
              }
              else{
                 user = 'learner';
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffeeeae3),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Icon(Icons.menu,color: Colors.black,),
              ),
            ),
          ),
        ),
        title: Image.asset(
          'assets/images/newLogo.png',
          width: MediaQuery.of(context).size.width * 0.45,
          fit: BoxFit.cover,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                color: appColors.white,
                boxShadow: [
                  BoxShadow(
                    color: appColors.Shadow_Clr2,
                    offset: const Offset(
                      1.0,
                      3.0,
                    ),
                    blurRadius:5.0,
                  ),         ],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15,),
                child: Center(child: Text('Practical',style: TextStyle(color: Colors.black),)),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25,),
              Center(
                child: Text('SEGMENT - 1',style: TextStyle(fontSize: 17,fontFamily: 'poppins-semibold'),),
              ),
              SizedBox(height: 25,),

              ///image banner
              Container(
               margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Video Player
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: FlickVideoPlayer(
                          flickManager: flickManager,
                          flickVideoWithControls: FlickVideoWithControls(

                            controls: FlickPortraitControls(),
                            playerLoadingFallback: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          flickVideoWithControlsFullscreen: FlickVideoWithControls(
                            controls: FlickLandscapeControls(),
                          ),

                        ),
                      ),

                      // Play/Pause Button
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// next segment
              Container(
                margin: EdgeInsets.only(top: 25,bottom: 5),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        VideoPlayIcon(40),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Next',style: TextStyle(fontFamily: 'poppins-medium'),),
                            Text('SEGMENT 1.2',style: TextStyle(fontFamily: 'poppins-semibold'),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(),
                    SizedBox(),
                    SizedBox(),
                  ],
                ),
              ),

              ///post your doubts
              if(user == 'learner')
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      border:Border.symmetric(horizontal: BorderSide(color: Color(0x4ad9d9d9),width: 3,))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            sectionShowing = 'index';
                          });
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: 15),
                            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color:sectionShowing == 'index' ?  Color(0xc7e5d1aa) : appColors.Shadow_Clr2,
                                  offset: const Offset(
                                    1.0,
                                    2.0,
                                  ),
                                  blurRadius:10.0,
                                ),         ],
                              border: Border.all(color:sectionShowing == 'index' ? Colors.transparent :  Color(0xffe0dacd),width: 1.5),
                              borderRadius: BorderRadius.circular(50),
                              color:sectionShowing == 'index' ? Color(0xffe0dacd) : Colors.white70,
                            ),
                            child: Text('INDEX',style: TextStyle(fontFamily: 'poppins-semibold', ),)),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            sectionShowing = 'doubts';
                          });
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: 15),
                              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color:sectionShowing == 'doubts' ?  Color(0xc7e5d1aa) : appColors.Shadow_Clr2,
                                    offset: const Offset(
                                      1.0,
                                      2.0,
                                    ),
                                    blurRadius:10.0,
                                  ),         ],
                                border: Border.all(color:sectionShowing == 'doubts' ? Colors.transparent :  Color(0xffe0dacd),width: 1.5),
                                borderRadius: BorderRadius.circular(50),
                                color:sectionShowing == 'doubts'
                                    ? Color(0xd2e0dacd)
                                    : Colors.white70,
                              ),
                            child: Text('Post Your Doubts',style: TextStyle(fontFamily: 'poppins-semibold', ),)),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            sectionShowing = 'notes';
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color:sectionShowing == 'notes' ?  Color(0xc7e5d1aa) : appColors.Shadow_Clr2,
                                  offset: const Offset(
                                    1.0,
                                    2.0,
                                  ),
                                  blurRadius:10.0,
                                ),         ],
                              border: Border.all(color:sectionShowing == 'notes' ? Colors.transparent :  Color(0xffe0dacd),width: 1.5),
                              borderRadius: BorderRadius.circular(50),
                              color:sectionShowing == 'notes' ? Color(0xffe0dacd) : Colors.white70,
                            ),
                            child: Text('Notes',style: TextStyle(fontFamily: 'poppins-semibold', ),)),
                      ),
                    ],
                  ),
                ),

                if(sectionShowing == 'index')
                Column(
                  children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 23,horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xffeeeae3),
                      border: Border.all(color: Color(0xffad9b78)),
                    ),
                     alignment: Alignment.center,
                     child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                      child: Center(child: Text('Total number of segments : 200 videos',style: TextStyle(fontFamily: 'poppins-light',color: Colors.black,fontSize: 15,),textAlign: TextAlign.center,)),
                    ),
                    ),
                    for (int i = 1; i < segments.length; i++)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: appColors.Shadow_Clr2,
                              offset: const Offset(1.0, 3.0),
                              blurRadius: 10.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ExpandableNotifier(
                          initialExpanded: i == 1 ? true : false,
                          child: Column(
                            children: [
                              ExpandablePanel(
                                theme: ExpandableThemeData(
                                  iconPadding: EdgeInsets.all(0),
                                  iconSize: 0,
                                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                                ),
                                header: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color(0xffe4e4e4),
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(20), bottom: Radius.circular(0)),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        VideoPlayIcon(40),
                                        Text(
                                          'SEGMENT $i - ${segments[i]}',
                                          style: TextStyle(
                                            fontFamily: 'poppins-semibold',
                                            color: Colors.black,
                                            fontSize: 17,
                                          ),
                                        ),
                                        ExpandableIcon(
                                          theme: ExpandableThemeData(
                                            expandIcon: Icons.add_circle_outline_outlined,
                                            collapseIcon: Icons.remove_circle_outline_outlined,
                                            iconColor: Colors.black,
                                            iconSize: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                expanded: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    for (int j = 1; j < 6; j++)
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          padding: const EdgeInsets.all(15.0),
                                          width: MediaQuery.of(context).size.width > 500
                                              ? MediaQuery.of(context).size.width * 0.6
                                              : MediaQuery.of(context).size.width * 0.8,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Color(0x4ad9d9d9),
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              VideoPlayIcon(30),
                                              Text(
                                                'Segment $i.$j',
                                                style: TextStyle(
                                                  fontFamily: 'poppins-medium',
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                ),
                                              ),
                                              j == 1 && i == 1
                                                  ? Container(
                                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(25),
                                                  color: Colors.grey[200],
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Watching ',
                                                      style: TextStyle(
                                                        fontFamily: 'poppins-medium',
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.fiber_manual_record,
                                                      size: 20,
                                                      color: Colors.green,
                                                    ),
                                                  ],
                                                ),
                                              )
                                                  : SizedBox(width: 90),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ), collapsed:  Container(),

                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),

              if(sectionShowing == 'doubts')
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  width: screenUtils.getScreenWidth(context) * 0.95,
                  decoration: BoxDecoration(
                    border: Border.all(color: appColors.lightGold),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Post your doubts here through text or voice chat',style: TextStyle(fontFamily: 'poppins-medium'),textAlign: TextAlign.center,),
                      ),
                      Divider(color: appColors.lightGold,thickness: 1,height: 1,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: screenUtils.getScreenWidth(context) * 0.58,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border:InputBorder.none,
                                      hintText: 'Type your doubts here..'
                                  ),
                                ),
                              )),
                          Container(
                            margin: EdgeInsets.only(right: 20,top: 10,bottom: 10,),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(105),
                              color: Color(0xffad9b78),
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
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Icon(Icons.mic_none_outlined,color: Colors.white,size: 20,),
                              ),
                            ),
                          )

                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 15,bottom: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xffad9b78),
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
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
                                child: Center(
                                  child: Text('Post question',style: TextStyle(fontFamily: 'poppins-medium',color: Colors.white,fontSize: 17),),
                                ),
                              ),
                            ),


                          ],
                        ),
                      ),
                      SizedBox(height: 5,)
                    ],
                  ),
                ),


              ///comments choosing
              if(user == 'admin' && sectionShowing == 'doubts')
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              _scrollController.animateTo(
                                _scrollController.position.minScrollExtent,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            if(comment != 'All'){
                              comment = 'All';
                            }
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              color: comment == 'All' ? Color(0xffad9b78) : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: appColors.Shadow_Clr2,
                                  offset: const Offset(
                                    1.0,
                                    3.0,
                                  ),
                                  blurRadius:5.0,
                                ),         ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 20),
                              child: Center(
                                child: Text('All comments',style: TextStyle(color:comment == 'All' ? Colors.white : Colors.black54,fontSize: 16),),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              if(comment != 'Unread'){
                                comment = 'Unread';
                              }
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              color: comment == 'Unread' ? Color(0xffad9b78) : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: appColors.Shadow_Clr2,
                                  offset: const Offset(
                                    1.0,
                                    3.0,
                                  ),
                                  blurRadius:5.0,
                                ),         ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 20),
                              child: Center(
                                child: Text('Unread comments',style: TextStyle(color:comment == 'Unread' ? Colors.white : Colors.black54,fontSize: 16 ),),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );

                              if(comment != 'Replied'){
                                comment = 'Replied';
                              }

                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              color: comment == 'Replied' ? Color(0xffad9b78) : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: appColors.Shadow_Clr2,
                                  offset: const Offset(
                                    1.0,
                                    3.0,
                                  ),
                                  blurRadius:5.0,
                                ),         ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 20),
                              child: Center(
                                child: Text('Replied comments',style: TextStyle(color:comment == 'Replied' ? Colors.white : Colors.black54,fontSize: 16),),
                              ),
                            ),
                          ),
                        ),




                      ],
                    ),
                  ),
                ),
              ),

              ///comments card
              if(sectionShowing == 'doubts')
              CommentSection(),

              if(sectionShowing == 'notes')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: appColors.ashGrey
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Notes',style: TextStyle(fontFamily: 'Poppins-SemiBold',fontSize: 18),),
                            TextButton(
                              onPressed: (){
                                },
                                child: Text('View all',style: TextStyle(fontFamily: 'Poppins-SemiBold'),)),
                          ],
                        ),
                      ),
                      Divider(
                        height: 10,
                      ),
                      MaterialButton(
                         elevation: 5,
                        color: appColors.lightGoldSec,
                        onPressed: (){
                           functionToAddNote();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add,color: Colors.white,size: 20,),
                            Text(' Add note',style: TextStyle(color: Colors.white,fontFamily: 'Poppins-SemiBold',fontSize: 13),)
                          ],
                        ),
                      ),


                    ],
                  ),
                )
            ],
          )),
    );
  }
  functionToAddNote(){
    showDialog(
      context: context,
      builder: (context) =>  Dialog(
        child:  SafeArea(
          child: Container(
            width: screenUtils.getScreenWidth(context),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 10,
                    width: screenUtils.getScreenWidth(context) * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0,left: 15,right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          decoration: BoxDecoration(
                              color:  Color(0x96f8ebcd),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Color(0xffe3d8be))
                          ),
                          child: Text('Add note at 3:25'),
                        ),
                        TextButton(
                            onPressed: (){Navigator.of(context).pop();},
                            child: Text('Cancel',style: TextStyle(color: Colors.red,fontFamily: 'Poppins-SemiBold'),))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      autofocus: true,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

  VideoPlayIcon(double iconSize) {
  return  Card(
    elevation: 5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
    child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: Icon(Icons.play_arrow_rounded,color: appColors.lightGold,size: iconSize,),
    ),
  );
}

