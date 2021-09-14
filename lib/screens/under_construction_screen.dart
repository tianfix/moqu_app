import 'package:flutter/material.dart';
import 'package:moqu_app/theme.dart';

class UnderConstructionScreen extends StatelessWidget {

  final String pageName;

  UnderConstructionScreen({this.pageName});

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
              pageName,
              style: TextStyle(
                color: primaryColor
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 50),
          child: Text(
            'Sorry, $pageName page is under construction ⛏️',
            style: bodyText.copyWith(color: greyColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}