import 'package:flutter/material.dart';
import 'package:moqu_app/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SavedScreen extends StatefulWidget {
  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
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
          'Saved Quotes',
          style: TextStyle(
            color: primaryColor
          ),
        ),
      ),
      body: new Stack(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Saved Quotes').where('email', isEqualTo: auth.currentUser.email).snapshots(),
            builder: (context, snapshot){
              
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                          width: 2,
                          color: primaryColor
                          )
                        ),
                        child: Container(
                          padding: EdgeInsets.only(top: 10, left: 14, bottom: 10, right: 14),
                          color: secondaryColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                documentSnapshot['text'],
                                style: bodyText.copyWith(color: primaryColor),
                              ),
                              SizedBox(height: 6),
                              Text(
                                '- ' + documentSnapshot['author'],
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                );
              }
              
              return Center(
                child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(primaryColor))
              );
            }
          )
        ],
      )
    );
  }
}