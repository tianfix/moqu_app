import 'package:flutter/material.dart';
import 'package:moqu_app/bottom_navigation.dart';
import 'package:moqu_app/screens/login_screen.dart';
import 'package:moqu_app/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool isLoading = false;
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {

    void showTopSnackBar(BuildContext context, var message) => Flushbar(
      icon: Icon(
        Icons.error,
        color: Colors.white,
      ),
      shouldIconPulse: false,
      message: message,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.red,
      margin: EdgeInsets.only(top: 10, right: 10, left: 10),
      borderRadius: 10,
    )..show(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 56, 20, 45),
              child: Column(
                children: [
                  Text(
                    'Create Account',
                    style: titleOnboarding,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'So happy to know you',
                    style: bodyText.copyWith(color: greyColor),
                  ),
                  SizedBox(height: 40),
                  TextFormField(
                    controller: _emailController,
                    style: TextStyle(color: primaryColor),
                    decoration: InputDecoration(
                      fillColor: primaryColor.withOpacity(0.1),
                      filled: true,
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.3)
                      ),
                      contentPadding: EdgeInsets.only(left: 20, top: 12, bottom: 12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: primaryColor.withOpacity(0.2)
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: primaryColor,
                          width: 2
                        )
                      )
                    ),
                  ),
                  SizedBox(height: 14),
                  TextFormField(
                    controller: _passwordController,
                    style: TextStyle(color: primaryColor),
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                      fillColor: primaryColor.withOpacity(0.1),
                      filled: true,
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.3)
                      ),
                      contentPadding: EdgeInsets.only(left: 20, top: 12, bottom: 12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: primaryColor.withOpacity(0.2)
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                          BorderSide(color: primaryColor, width: 2)
                      ),
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                        icon: Icon(
                          passwordVisible ?
                          Icons.visibility_off
                          : Icons.visibility,
                          size: 20,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      )
                    ),
                  ),
                  SizedBox(height: 50),
                  InkWell(
                    onTap: () async {
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        await _firebaseAuth.createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text
                        ).then((value) => Navigator.of(context).pushReplacement(
                         MaterialPageRoute(builder: (context) => LoginScreen()) 
                        ));
                      } catch (e) {
                        setState(() {
                          isLoading = false;
                        });
                        showTopSnackBar(context, e.message);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: isLoading == true ?
                      CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                      : Text('Register', style: buttonText)
                      )
                    ),
                  SizedBox(height: 138),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                      MaterialPageRoute(builder:
                        (context) => LoginScreen())
                      );
                    },
                    child: Text(
                      'Back to Log In',
                      style: TextStyle(
                        color: primaryColor
                      ),
                    )
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