import 'package:flutter/material.dart';
import 'package:moqu_app/screens/about_developer_screen.dart';
import 'package:moqu_app/screens/login_screen.dart';
import 'package:moqu_app/screens/under_construction_screen.dart';
import 'package:moqu_app/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 20,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(
            color: primaryColor
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Image.asset(
                'assets/images/profile_picture.png',
                width: 60,
              ),
              SizedBox(height: 10),
              Text(
                auth.currentUser.email,
                style: TextStyle(
                fontSize: 12,
                color: greyColor,
                fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(height: 24),
              createLine(),
              SizedBox(height: 24),
              cardTile('assets/images/personal_icon.png', 'Personal Data'),
              SizedBox(height: 12),
              cardTile('assets/images/setting_icon.png', 'Setting'),
              SizedBox(height: 24),
              createLine(),
              SizedBox(height: 24),
              cardTile('assets/images/faq_icon.png', 'FAQs'),
              SizedBox(height: 12),
              cardTile('assets/images/community_icon.png', 'Community'),
              SizedBox(height: 24),
              createLine(),
              SizedBox(height: 24),
              InkWell(
                onTap: () async {
                  auth.signOut().whenComplete((){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                  });
                },
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w700
                  )
                ),
              ),
              SizedBox(height: 12),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutDeveloper()
                    )
                  );
                },
                child: Text(
                  'About Developer',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w700
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container createLine() {
    return Container(
      height: 1,
      width: double.infinity,
      color: Colors.black.withOpacity(0.1),
    );
  }

  Row cardTile(String imageUrl, String pageName) {
    return Row(
      children: [
        Image.asset(
          imageUrl,
          width: 34,
        ),
        SizedBox(width: 10),
        Text(
          pageName,
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w500
          ),
        ),
        Spacer(),
        InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UnderConstructionScreen(pageName: pageName,)
            )
          );
          },
          child: Icon(
            Icons.chevron_right,
            size: 24,
            color: greyColor,
          ),
        )
      ],
    );
  }
}