import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:moqu_app/theme.dart';
import 'package:http/http.dart' as http;
import 'package:moqu_app/model/quote_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';

Future<List<QuoteModel>> fetchQuote() async {
    final response = await http.get(Uri.parse('https://type.fit/api/quotes'));

    if (response.statusCode == 200){
      List<QuoteModel> quotes = [];
      final jsonresponse = json.decode(response.body);
      jsonresponse.forEach((quote) { 
          quotes.add(QuoteModel.fromJson(quote));
      });
      return quotes;
    } else {
      throw Exception('Failed to load data');
    }
}

class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  Future<List<QuoteModel>> futureQuote;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    futureQuote = fetchQuote();
  }

  void showTopSnackBar(BuildContext context, var message) => Flushbar(
      icon: Icon(
        Icons.check,
        color: Colors.white,
      ),
      shouldIconPulse: false,
      messageText: Text(
        message,
        style: alertText,
      ),
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.green,
      margin: EdgeInsets.only(top: 10, right: 10, left: 10),
      borderRadius: 10,
  )..show(context);

  void addData(String text, String author){
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = FirebaseFirestore.instance.collection('Saved Quotes');
      await reference.add(
        {
          'email' : auth.currentUser.email,
          'text' : text,
          'author' : author
        }
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget quoteContent(String text, String author) {
      return Column(
        children: [
          Text(
            text,
            style: quoteCard,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          Text(
            author,
            style: authorCard,
            textAlign: TextAlign.center,
          )
        ],
      );
    }

    return Scaffold(
      body: Container(
          child: TinderSwapCard(
            totalNum: 1000,
            stackNum: 3,
            swipeEdge: 2.0,
            maxHeight: MediaQuery.of(context).size.height * 0.75,
            maxWidth: MediaQuery.of(context).size.width - 40,
            minHeight: MediaQuery.of(context).size.height * 0.6,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            cardBuilder: (context, index) => Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                  color: primaryColor
                )
              ),
              child: FutureBuilder<List<QuoteModel>>(
                future: futureQuote,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onDoubleTap: (){
                            setState(() {
                              addData(snapshot.data[index].text, snapshot.data[index].author);
                            });
                            showTopSnackBar(context, 'The selected quote is saved sucessfully');
                          },
                          child: quoteContent(snapshot.data[index].text, snapshot.data[index].author)),
                      ],
                    );
                  }

                  return Center(
                    child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(primaryColor))
                  );
                },
              )
            ),
          ),
        ),
      );
  }
}