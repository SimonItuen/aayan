import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/home/HomeScreen.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/screens/parent/ParentScreen.dart';
import 'package:Aayan/screens/register/RegisterScreen.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:Aayan/widgets/app_transparent_button.dart';
import 'package:Aayan/widgets/sliding_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatefulWidget {
  static final String routeName = '/on-boarding';

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  final PageController pageController = PageController();

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
                'assets/images/on_boarding_backdrop.png',
                fit: BoxFit.fill,
              )),
          Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
              )),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      physics: AlwaysScrollableScrollPhysics(),
                      onPageChanged: onPageChanged,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et d',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 5; i++)
                          SlidingTile(
                            isActive: i == currentIndex,
                          )
                      ],
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200), child:currentIndex != 4
                      ? Row(
                    children: [
                      Expanded(
                          child: AppTransparentButton(
                            onPressed:(){
                              Provider.of<AppProvider>(context, listen: false).setIsLoggedIn(false);
                              Navigator.of(context).pushNamed(ParentScreen.routeName);
                            },
                            child: Text(
                              'Skip',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                      Expanded(
                          child: AppFilledButton(
                            onPressed: () {
                              pageController.animateToPage(currentIndex + 1,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Next',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white,
                                  size: 18,
                                )
                              ],
                            ),
                          ))
                    ],
                  )
                      : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: AppFilledButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                LoginScreen.routeName);
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: AppFilledButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                RegisterScreen.routeName);
                          },
                          fillColor: Colors.white,
                          child: Text(
                            'Register',
                            style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: AppTransparentButton(
                          onPressed:(){
                            Provider.of<AppProvider>(context, listen: false).setIsLoggedIn(false);
                            Navigator.of(context).pushNamed(ParentScreen.routeName);
                          },
                          child: Text(
                            'Skip',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
