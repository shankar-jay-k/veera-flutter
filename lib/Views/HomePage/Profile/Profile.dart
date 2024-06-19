import 'package:flutter/material.dart';
import 'package:veera_education_flutter/Controllers/Colors.dart';
import 'package:veera_education_flutter/Views/HomePage/Profile/LinkDevice.dart';
import 'package:veera_education_flutter/testFile.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Profile',style: TextStyle(color: Colors.black,fontFamily: 'Poppins-Medium',letterSpacing: 2),),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 25),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 105,width: 105,
                  margin: EdgeInsets.only(bottom: 8),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset('assets/images/user.png',fit: BoxFit.cover,)),
                ),
                Text('SHANKAR',style: TextStyle(fontFamily: 'Poppins-Medium',fontSize: 18),),
                Text('+91-9344451201',style: TextStyle(fontFamily: 'Poppins-Light',fontSize: 15,color: Colors.black),)
              ],
            ),
            SizedBox(height: 15,),
            Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>LocationDetails()));

                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: appColors.ashGrey
                    ),
                    child: ListTile(

                      title: Text('Find location',style: TextStyle(color: Colors.black,fontFamily: 'Poppins-Medium'),),
                      trailing: Icon(Icons.arrow_forward_ios,color: appColors.white),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){

                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: appColors.lightGold
                    ),
                    child: ListTile(
                      leading: Icon(Icons.calendar_month_outlined,color: Color(0xff9b9b9b),),
                      title: Text('Attendance',style: TextStyle(color: Colors.black,fontFamily: 'Poppins-Medium'),),
                      trailing: Icon(Icons.arrow_forward_ios,color: appColors.white),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>LinkDevice()));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: appColors.lightGold
                    ),
                    child: ListTile(
                      leading: Icon(Icons.laptop_outlined,color: Color(0xff9b9b9b),),
                      title: Text('Connected device',style: TextStyle(color: Colors.black,fontFamily: 'Poppins-Medium'),),
                      trailing: Icon(Icons.arrow_forward_ios,color: appColors.white),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: appColors.error
                  ),
                  child: ListTile( 
                    title: Text('Logout',style: TextStyle(color: Colors.white,fontFamily: 'Poppins-Bold'),),
                    trailing: Icon(Icons.logout_outlined,color: appColors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15,),

          ],
        ),
      )
    );
  }
}
