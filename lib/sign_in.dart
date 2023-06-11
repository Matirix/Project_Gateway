import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/navigation_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _bottomColorAnimation;
  late Animation<Color?> _topColorAnimation;
  late Animation<Color?> _textColorAnimation;
  late Animation<double> _logoAnimation;
  late Animation<double> _buttonAnimation;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4));

    _bottomColorAnimation = TweenSequence(
      [
        TweenSequenceItem(
          tween: ColorTween(begin: Color(0xFFFFFFFF), end: Color(0xFFD1CFE8)),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Color(0xFFD1CFE8), end: Color(0xFFFFFFFF)),
          weight: 1,
        ),
      ],
    ).animate(_controller);

    _topColorAnimation = TweenSequence(
      [
        TweenSequenceItem(
          tween: ColorTween(begin: Color(0xFFD1CFE8), end: Color(0xFFFFFFFF)),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Color(0xFFFFFFFF), end: Color(0xFFD1CFE8)),
          weight: 1,
        ),
      ],
    ).animate(_controller);

    _textColorAnimation = ColorTween(begin: Colors.white, end: Colors.black).animate(_controller);

    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut), // Adjust the duration here
      ),
    );

    _buttonAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.9, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String getLogoPath() {
    if (_logoAnimation.value >= 0.7) {
      return 'assets/logo_black.svg';
    } else {
      return 'assets/logo_white.svg';
    }
  }

  void _showPopupWindow(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.8,
            decoration: BoxDecoration(
              color: const Color(0xFF187187),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0.00),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Log Into Gateway',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 10.0),
                  child: Text(
                    'Click Face Detection Icon to Begin',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLoading = true;
                    });
                    _showPopupWindow(context);
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavigationPage()));
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: isLoading ? LoadingAnimationWidget.prograssiveDots(
                      color: Colors.white,
                      size: 100,
                    ) : SvgPicture.asset(
                        'assets/face_cta.svg',
                        width: 100,
                        height: 100,
                    )

                  )
                )

              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [_bottomColorAnimation.value!, _topColorAnimation.value!],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 250),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return Opacity(
                        opacity: _logoAnimation.value,
                        child: SvgPicture.asset(
                          getLogoPath(),
                          width: 20,
                          height: 20,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return Opacity(
                        opacity: _logoAnimation.value,
                        child: Text(
                          'GATEWAY',
                          style: TextStyle(
                            fontFamily: 'Barlow',
                            fontSize: 50,
                            color: _textColorAnimation.value,
                            letterSpacing: 4.0,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return Opacity(
                        opacity: _buttonAnimation.value, // Use the button animation
                        child: _controller.value >= 0.7 ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(300, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: const Color(0xFF187187),
                          ),
                          onPressed: () {
                            _showPopupWindow(context);
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => NavigationPage()),
                            // );
                          },
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        )
                            : const SizedBox(),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}