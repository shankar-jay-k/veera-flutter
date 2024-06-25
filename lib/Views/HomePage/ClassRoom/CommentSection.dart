import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:veera_education_flutter/Controllers/Colors.dart';

class CommentSection extends StatefulWidget {
  const CommentSection({super.key});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  String user = 'learner';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 0,horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(0xffeeeae3),
            border: Border.all(color: Color(0xffad9b78)),
          ),
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            child: Text('ALL COMMENTS & DISCUSSIONS',style: TextStyle(fontFamily: 'poppins-semibold',color: Colors.black,fontSize: 17),),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: appColors.Shadow_Clr,
                offset: const Offset(
                  1.0,
                  3.0,
                ),
                blurRadius:10.0,
              ),         ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0,horizontal: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 35,width: 35,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset('assets/images/user.png',fit: BoxFit.cover,)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Tamizh',style: TextStyle(fontFamily: 'poppins-medium',fontSize: 15),),
                                  if(user == 'learner')
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Color(0xffdcdcdc),

                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 2.5,horizontal: 8),
                                        child: Center(
                                          child: Text('Learner',style: TextStyle( color: Color(0xff000000),fontSize: 15),),
                                        ),
                                      ),
                                    ),

                                ],
                              ),
                              SizedBox(height: 2,),
                              Text('Business,Chidhambaram ',style: TextStyle(fontSize: 13,color: Colors.black54),),

                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){

                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              color:   Colors.grey[350],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              child: Center(
                                child: Text('REPLY',style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w600,  ),),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Icon(Icons.schedule_outlined,size: 16,color: Colors.black45,),
                            Text(' 10 Mins ago ',style: TextStyle(fontSize: 13.5,color: Colors.black54),),

                          ],
                        )
                      ],
                    )
                  ],
                ),
                Divider(indent: 15,endIndent: 15,thickness: 1.1,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Text("I am learning hindi through your videos .It's very helpful and easiest way to learn.But now you're deleted all video without intimation sir. we are upset now. Please release the video, All are expecting your videos those who are all learning hindi"
                    ,style: TextStyle(fontWeight: FontWeight.w600,color: Color(0xc7101010),height: 1.4,),textAlign: TextAlign.justify,),
                ),

                SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: ExpandableNotifier(
                    child: ScrollOnExpand(
                      scrollOnExpand: true,
                      scrollOnCollapse: false,
                      child: ExpandablePanel(
                        theme: const ExpandableThemeData(
                          hasIcon: false,
                          headerAlignment: ExpandablePanelHeaderAlignment.center,
                          tapBodyToCollapse: true,
                        ),
                        header: Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Container(
                                margin:EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: appColors.lightGold,
                                    borderRadius: BorderRadius.circular(35)
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text("Show more replies",
                                      style: TextStyle(color:Colors.black,fontFamily: 'poppins-medium'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        collapsed:SizedBox(),
                        expanded: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            for (var _ in Iterable.generate(5))
                              Container(
                                width: screenUtils.getScreenWidth(context),
                                margin: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                                decoration: BoxDecoration(
                                  color: Color(0xfff1f1f1),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: appColors.Shadow_Clr,
                                      offset: const Offset(
                                        1.0,
                                        3.0,
                                      ),
                                      blurRadius:10.0,
                                    ),         ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 18.0,horizontal: 8),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 50,width: 50,
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(100),
                                                    child: Image.asset('assets/images/admin.png',fit: BoxFit.cover,)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text('Veeras',style: TextStyle(fontFamily: 'poppins-medium',fontSize: 15),),
                                                        if(user == 'learner')
                                                          Container(
                                                            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(5),
                                                              color: Color(0xffad8078),
                                                              border: Border.all(color: Color(0xffad9b78)),

                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 5),
                                                              child: Center(
                                                                child: Text('Admin',style: TextStyle( color: Color(0xffffffff),fontSize: 13),),
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                    Text('Founder',style: TextStyle(fontSize: 13,color: Colors.black54),),

                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(80),
                                                    color:   Colors.grey[350],
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                                    child: Center(
                                                      child: Text('REPLY',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w600,  ),),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5,),
                                              Row(
                                                children: [
                                                  Icon(Icons.schedule_outlined,size: 16,color: Colors.black45,),
                                                  Text(' 10 Mins ago ',style: TextStyle(fontSize: 13.5,color: Colors.black54),),

                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      Divider(indent: 15,endIndent: 15,thickness: 1.1,height: 25,),


                                      Text('Thank you for your comment',style: TextStyle(color: Colors.black54,fontFamily: 'poppins-medium',fontSize: 16),)
                                    ],
                                  ),
                                ),
                              )
                          ],
                        ),
                        builder: (_, collapsed, expanded) {
                          return Padding(
                            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                            child: Expandable(
                              collapsed: collapsed,
                              expanded: expanded,
                              theme: const ExpandableThemeData(crossFadePoint: 0),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: appColors.Shadow_Clr,
                offset: const Offset(
                  1.0,
                  3.0,
                ),
                blurRadius:10.0,
              ),         ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0,horizontal: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,width: 40,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset('assets/images/user.png',fit: BoxFit.cover,)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Tamizh',style: TextStyle(fontFamily: 'poppins-medium',fontSize: 15),),
                                  if(user == 'learner')
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Color(0xffdcdcdc),

                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 2.5,horizontal: 6),
                                        child: Center(
                                          child: Text('Learner',style: TextStyle( color: Color(0xff000000),fontSize: 13),),
                                        ),
                                      ),
                                    ),

                                ],
                              ),
                              SizedBox(height: 2,),
                              Text('Business,Chidhambaram ',style: TextStyle(fontSize: 13,color: Colors.black54),),

                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){

                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              color:   Colors.grey[350],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              child: Center(
                                child: Text('REPLY',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w600,  ),),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Icon(Icons.schedule_outlined,size: 16,color: Colors.black45,),
                            Text(' 10 Mins ago ',style: TextStyle(fontSize: 13.5,color: Colors.black54),),

                          ],
                        )
                      ],
                    )
                  ],
                ),
                Divider(indent: 15,endIndent: 15,thickness: 1.1,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Text("I am learning hindi through your videos .It's very helpful and easiest way to learn.But now you're deleted all video without intimation sir. we are upset now. Please release the video, All are expecting your videos those who are all learning hindi"
                    ,style: TextStyle(fontWeight: FontWeight.w600,color: Color(0xc7101010),height: 1.4,),textAlign: TextAlign.justify,),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xfff1f1f1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: appColors.Shadow_Clr,
                        offset: const Offset(
                          1.0,
                          3.0,
                        ),
                        blurRadius:10.0,
                      ),         ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0,horizontal: 8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 40,width: 40,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.asset('assets/images/admin.png',fit: BoxFit.cover,)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Veeras',style: TextStyle(fontFamily: 'poppins-medium',fontSize: 15),),
                                          if(user == 'learner')
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Color(0xffad8078),
                                                border: Border.all(color: Color(0xffad9b78)),

                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 6),
                                                child: Center(
                                                  child: Text('Admin',style: TextStyle( color: Color(0xffffffff),fontSize: 14),),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      Text('Founder',style: TextStyle(fontSize: 13,color: Colors.black54),),

                                    ],
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: (){
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80),
                                      color:   Colors.grey[350],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 10),
                                      child: Center(
                                        child: Text('REPLY',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w600,  ),),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Icon(Icons.schedule_outlined,size: 16,color: Colors.black45,),
                                    Text(' 10 Mins ago ',style: TextStyle(fontSize: 13.5,color: Colors.black54),),

                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        Divider(indent: 15,endIndent: 15,thickness: 1.1,height: 25,),


                        Text('Thank you for your comment',style: TextStyle(color: Colors.black54,fontFamily: 'poppins-medium',fontSize: 16),)
                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: appColors.Shadow_Clr,
                offset: const Offset(
                  1.0,
                  3.0,
                ),
                blurRadius:10.0,
              ),         ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0,horizontal: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 45,width: 45,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset('assets/images/user.png',fit: BoxFit.cover,)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Tamizh',style: TextStyle(fontFamily: 'poppins-medium',fontSize: 15),),
                                  if(user == 'learner')
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Color(0xffdcdcdc),

                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 2.5,horizontal: 8),
                                        child: Center(
                                          child: Text('Learner',style: TextStyle( color: Color(0xff000000),fontSize: 15),),
                                        ),
                                      ),
                                    ),

                                ],
                              ),
                              SizedBox(height: 2,),
                              Text('Business,Chidhambaram ',style: TextStyle(fontSize: 13,color: Colors.black54),),

                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){

                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              color:   Colors.grey[350],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                              child: Center(
                                child: Text('REPLY',style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w600,  ),),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Icon(Icons.schedule_outlined,size: 16,color: Colors.black45,),
                            Text(' 10 Mins ago ',style: TextStyle(fontSize: 13.5,color: Colors.black54),),

                          ],
                        )
                      ],
                    )
                  ],
                ),
                Divider(indent: 15,endIndent: 15,thickness: 1.1,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Text("I am learning hindi through your videos .It's very helpful and easiest way to learn.But now you're deleted all video without intimation sir. we are upset now. Please release the video, All are expecting your videos those who are all learning hindi"
                    ,style: TextStyle(fontWeight: FontWeight.w600,color: Color(0xc7101010),height: 1.4,),textAlign: TextAlign.justify,),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xfff1f1f1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: appColors.Shadow_Clr,
                        offset: const Offset(
                          1.0,
                          3.0,
                        ),
                        blurRadius:10.0,
                      ),         ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0,horizontal: 8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: screenUtils.getScreenWidth(context) > 500 ? 50 : 30,
                                  width: screenUtils.getScreenWidth(context) > 500 ? 50 : 30,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.asset('assets/images/admin.png',fit: BoxFit.cover,)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Veeras',style: TextStyle(fontFamily: 'poppins-medium',fontSize: 15),),
                                          if(user == 'learner')
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Color(0xffad8078),
                                                border: Border.all(color: Color(0xffad9b78)),

                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 8),
                                                child: Center(
                                                  child: Text('Admin',style: TextStyle( color: Color(0xffffffff),fontSize: 17),),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      Text('Founder',style: TextStyle(fontSize: 13,color: Colors.black54),),

                                    ],
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: (){
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80),
                                      color:   Colors.grey[350],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                      child: Center(
                                        child: Text('REPLY',style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w600,  ),),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Icon(Icons.schedule_outlined,size: 16,color: Colors.black45,),
                                    Text(' 10 Mins ago ',style: TextStyle(fontSize: 13.5,color: Colors.black54),),

                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        Divider(indent: 15,endIndent: 15,thickness: 1.1,height: 25,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding:EdgeInsets.only(left:15),
                              width: screenUtils.getScreenWidth(context) * 0.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey,width: 0.4),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: ' Write your answer here',
                                    hintStyle: TextStyle(fontSize: 14,fontFamily: 'poppins-medium',color: Colors.grey),
                                    suffixIcon: Icon(Icons.mic_none_outlined,color: Colors.grey,size: 28,)
                                ),
                              ),
                            ),
                            Container(
                              height: 48,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xffad9b78),
                              ),
                              child: Center(
                                child: Text('POST',style: TextStyle(fontFamily: 'poppins-medium',color: Colors.white,),),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
        ),


        Container(
          margin: EdgeInsets.only(top: 25,bottom: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(150),
            color: Color(0xffad9b78),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 30),
            child: Text('See more comments',style: TextStyle(fontFamily: 'poppins-medium',color: Colors.white,fontSize: 18),),
          ),
        )
      ],
    );
  }
}

// commentCardBox for dynamic generation

//  commentCardBox(index){
//
//   return Container(
//     margin: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(20),
//       boxShadow: [
//         BoxShadow(
//           color: appColors.Shadow_Clr,
//           offset: const Offset(
//             1.0,
//             3.0,
//           ),
//           blurRadius:10.0,
//         ),         ],
//     ),
//     child: Padding(
//       padding: const EdgeInsets.symmetric(vertical: 18.0,horizontal: 8),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     height: 45,width: 45,
//                     child: ClipRRect(
//                         borderRadius: BorderRadius.circular(100),
//                         child: Image.asset('assets/images/user.png',fit: BoxFit.cover,)),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 5.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Text('Tamizh',style: TextStyle(fontFamily: 'poppins-medium',fontSize: 15),),
//                             if(user == 'learner')
//                               Container(
//                                 margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: Color(0xffdcdcdc),
//
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(vertical: 2.5,horizontal: 8),
//                                   child: Center(
//                                     child: Text('Learner',style: TextStyle( color: Color(0xff000000),fontSize: 15),),
//                                   ),
//                                 ),
//                               ),
//
//                           ],
//                         ),
//                         SizedBox(height: 2,),
//                         Text('Business,Chidhambaram ',style: TextStyle(fontSize: 13,color: Colors.black54),),
//
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   InkWell(
//                     onTap: (){
//                        if(user == 'admin'){
//                          id = index;
//                          setState(() {
//                          });
//                        }
//                        else{
//                          errorToast('You can`t reply your own comment');
//                        }
//                         print('selected id:${id}');
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(80),
//                         color:   Colors.grey[350],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
//                         child: Center(
//                           child: Text('REPLY',style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w600,  ),),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 5,),
//                   Row(
//                     children: [
//                       Icon(Icons.schedule_outlined,size: 16,color: Colors.black45,),
//                       Text(' 10 Mins ago ',style: TextStyle(fontSize: 13.5,color: Colors.black54),),
//
//                     ],
//                   )
//                 ],
//               )
//             ],
//           ),
//           Divider(indent: 15,endIndent: 15,thickness: 1.1,),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 3.0),
//             child: Text("I am learning hindi through your videos .It's very helpful and easiest way to learn.But now you're deleted all video without intimation sir. we are upset now. Please release the video, All are expecting your videos those who are all learning hindi"
//               ,style: TextStyle(fontWeight: FontWeight.w600,color: Color(0xc7101010),height: 1.4,),textAlign: TextAlign.justify,),
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
//             decoration: BoxDecoration(
//               color: Color(0xfff1f1f1),
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color: appColors.Shadow_Clr,
//                   offset: const Offset(
//                     1.0,
//                     3.0,
//                   ),
//                   blurRadius:10.0,
//                 ),         ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 18.0,horizontal: 8),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                             height: 50,width: 50,
//                             child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(100),
//                                 child: Image.asset('assets/images/admin.png',fit: BoxFit.cover,)),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 5.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text('Veeras',style: TextStyle(fontFamily: 'poppins-medium',fontSize: 15),),
//                                     if(user == 'learner')
//                                       Container(
//                                         margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(5),
//                                           color: Color(0xffad8078),
//                                           border: Border.all(color: Color(0xffad9b78)),
//
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 8),
//                                           child: Center(
//                                             child: Text('Admin',style: TextStyle( color: Color(0xffffffff),fontSize: 17),),
//                                           ),
//                                         ),
//                                       ),
//                                   ],
//                                 ),
//                                 Text('Founder',style: TextStyle(fontSize: 13,color: Colors.black54),),
//
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           InkWell(
//                             onTap: (){
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(80),
//                                 color:   Colors.grey[350],
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
//                                 child: Center(
//                                   child: Text('REPLY',style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w600,  ),),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 5,),
//                           Row(
//                             children: [
//                               Icon(Icons.schedule_outlined,size: 16,color: Colors.black45,),
//                               Text(' 10 Mins ago ',style: TextStyle(fontSize: 13.5,color: Colors.black54),),
//
//                             ],
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                   Divider(indent: 15,endIndent: 15,thickness: 1.1,height: 25,),
//
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Container(
//                           padding:EdgeInsets.only(left:15),
//                           width: screenUtils.getScreenWidth(context) * 0.6,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             border: Border.all(color: Colors.grey,width: 0.4),
//                             color: Colors.white,
//                           ),
//                           child: TextFormField(
//                             decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: ' Write your answer here',
//                                 hintStyle: TextStyle(fontSize: 14,fontFamily: 'poppins-medium',color: Colors.grey),
//                                 suffixIcon: Icon(Icons.mic_none_outlined,color: Colors.grey,size: 28,)
//                             ),
//                           ),
//                         ),
//                         Container(
//                           height: 48,
//                           width: 55,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             color: Color(0xffad9b78),
//                           ),
//                           child: Center(
//                             child: Text('POST',style: TextStyle(fontFamily: 'poppins-medium',color: Colors.white,),),
//                           ),
//                         )
//                       ],
//                     ),
//                     Text('Thank you for your comment',style: TextStyle(color: Colors.black54,fontFamily: 'poppins-medium',fontSize: 16),)
//                 ],
//               ),
//             ),
//           )
//
//         ],
//       ),
//     ),
//   );
//
// }