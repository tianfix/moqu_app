import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moqu_app/bottom_navigation.dart';
import 'package:moqu_app/screens/register_screen.dart';
import 'package:moqu_app/theme.dart';
import 'package:flushbar/flushbar.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
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
      messageText: Text(
        message,
        style: alertText,
      ),
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
                    'Welcome Back',
                    style: titleOnboarding,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'So happy to meet you again',
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
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: bodyText.copyWith(color: primaryColor),
                      )
                    ],
                  ),
                  SizedBox(height: 50),
                  InkWell(
                    onTap: () async {
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        await _firebaseAuth.signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text
                        ).then((value) => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BottomNavigation()), (route) => false)
                        );
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
                      : Text('Log In', style: buttonText)
                      )
                    ),
                  SizedBox(height: 110),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Haven't an account yet?",
                        style: bodyText.copyWith(color: primaryColor),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                        MaterialPageRoute(builder:
                          (context) => RegisterScreen())
                        );
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.w700
                          ),
                        )
                      )
                    ],
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
