// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/navigation_page.dart';
// import '../api/auth.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<Color?> _bottomColorAnimation;
  late Animation<Color?> _topColorAnimation;
  late Animation<Color?> _textColorAnimation;
  late Animation<double> _logoAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4));

    _bottomColorAnimation = TweenSequence(
      [
        TweenSequenceItem(
          tween: ColorTween(begin: Color(0xFFFFFFFF), end: Color(0xFF549DC6)),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Color(0xFF549DC6), end: Color(0xFFFFFFFF)),
          weight: 1,
        ),
      ],
    ).animate(_controller);

    _topColorAnimation = TweenSequence(
      [
        TweenSequenceItem(
          tween: ColorTween(begin: Color(0xFF549DC6), end: Color(0xFFFFFFFF)),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Color(0xFFFFFFFF), end: Color(0xFF549DC6)),
          weight: 1,
        ),
      ],
    ).animate(_controller);

    _textColorAnimation = ColorTween(begin: Colors.white, end: Colors.black).animate(_controller);

    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // _logoAnimation = Tween<String>(begin: 'assets/logo_white.svg', end: 'assets/logo_black.svg')
    //     .animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the animation controller when the widget is removed from the tree
    super.dispose();
  }

  String getLogoPath() {
    if (_logoAnimation.value >= 0.5) {
      return 'assets/logo_black.svg';
    } else {
      return 'assets/logo_white.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context,_) {
            return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [_bottomColorAnimation.value!, _topColorAnimation.value!],
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 250,
                    ),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, _) {
                        return SvgPicture.asset(
                          getLogoPath(),
                          width: 20,
                          height: 20,
                          color: _textColorAnimation.value,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, _) {
                        return Text(
                          'GATEWAY',
                          style: TextStyle(
                            fontFamily: 'Barlow',
                            fontSize: 50,
                            color: _textColorAnimation.value,
                            letterSpacing: 4.0,
                          ),
                        );
                      }
                    )
                  ],
                )
            );
          }


        )

      ),
    );
  }
}
