import 'package:flutter/material.dart';
import 'package:moqu_app/component/slider.dart';
import 'package:moqu_app/screens/login_screen.dart';
import 'package:moqu_app/theme.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  PageController _controller = PageController();

  List<Widget> _pages = [
    SliderPage(
      imageUrl: 'assets/images/ilustrasi.png',
      title: 'Find Unlimited Motivational Quotes',
      subTitle:
          'There are thousands quotes from popular people over the world to become your daily motivation',
    ),
    SliderPage(
      imageUrl: 'assets/images/ilustrasi2.png',
      title: 'Get Notifify of Your Favorite Quotes',
      subTitle:
          'Save or add your favourite quotes and get notify of them to motivate you everyday',
    ),
    SliderPage(
      imageUrl: 'assets/images/ilustrasi3.png',
      title: 'Share Quotes Wherever You Are',
      subTitle:
          'Now it’s easy to share motivational quotes to your friends wherever and whenever',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _controller,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, int index) => _pages[index],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 34, left: 20, right: 20,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => buildDot(index: index)
                    )
                  ),
                  SizedBox(height: 19),
                  InkWell(
                    onTap: (){
                      _currentPage == (_pages.length - 1) ?
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen()
                        )
                      )
                      : _controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOutQuint
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                          _currentPage == (_pages.length - 1) ? 'Get Started' : 'Next',
                          style: buttonText,
                        )
                      ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.only(right: 4),
      height: 6,
      width: index == _currentPage ? 14 : 6,
      decoration: BoxDecoration(
        color: index == _currentPage ? primaryColor : primaryColor.withOpacity(0.35),
        borderRadius: BorderRadius.circular(3)
      ),
    );
  }
}
