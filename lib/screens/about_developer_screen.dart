import 'package:flutter/material.dart';
import 'package:moqu_app/theme.dart';

class AboutDeveloper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              icon: Icon(
              Icons.arrow_back,
              color: primaryColor,
              ),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            Text(
              'About Developer',
              style: TextStyle(
                color: primaryColor
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Image.asset(
              'assets/images/foto_chrystian.png',
              height: 160,
            ),
            SizedBox(height: 16),
            Text(
              'Helooo 👋\nPerkenalkan saya Chrystian!',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Saya merupakan mahasiswa Teknik Informatika di Universitas Esa Unggul.',
              style: bodyText.copyWith(color: greyColor)
            ),
            SizedBox(height: 10),
            Text(
              'Project akhir ini saya kerjakan selama 6 hari lamanya, semoga Anda menyukainya 😁.',
              style: bodyText.copyWith(color: greyColor)
            ),
            SizedBox(height: 22),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.black.withOpacity(0.1),
            ),
            SizedBox(height: 22),
            socmedTile('assets/images/linkedin_icon.png', 'Chrystian Dwi Putra Yunus'),
            SizedBox(height: 12),
            socmedTile('assets/images/instagram_icon.png', '@tianfix'),
          ],
        ),
      ),
    );
  }

  Row socmedTile(String imageUrl, String text) {
    return Row(
      children: [
        Image.asset(
          imageUrl,
          width: 22,
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: bodyText.copyWith(color: primaryColor),
        )
      ],
    );
  }
}