import 'package:donoridedrive/constants/App_constant.dart';
import 'package:donoridedrive/screens/register_page/register_screen.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with TickerProviderStateMixin {
  String verificationCode = '';
  List<String> code = ['', '', '', ''];
  int currentIndex = 0;

  late AnimationController _timerController;
  late Animation<int> _timerAnimation;

  late List<AnimationController> _digitControllers;
  late List<Animation<double>> _digitAnimations;
  late List<Animation<Color?>> _colorAnimations;
  late AnimationController _completeController;
  late Animation<double> _completeAnimation;

  @override
  void initState() {
    super.initState();
    _timerController = AnimationController(
      duration: Duration(seconds: 60),
      vsync: this,
    );

    _timerAnimation = IntTween(begin: 60, end: 0).animate(_timerController);

    _timerController.forward();

    _digitControllers = List.generate(
      4,
      (index) => AnimationController(
        duration: Duration(milliseconds: 300),
        vsync: this,
      ),
    );

    _digitAnimations = _digitControllers
        .map(
          (controller) => Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: controller, curve: Curves.elasticOut),
          ),
        )
        .toList();

    _colorAnimations = _digitControllers
        .map(
          (controller) =>
              ColorTween(
                begin: Colors.grey.shade300,
                end: AppConstants.primaryColor,
              ).animate(
                CurvedAnimation(parent: controller, curve: Curves.easeInOut),
              ),
        )
        .toList();

    _completeController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _completeAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _completeController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _timerController.dispose();
    _completeController.dispose();
    for (var controller in _digitControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onNumberTap(String number) {
    if (currentIndex < 4) {
      setState(() {
        code[currentIndex] = number;
        verificationCode = code.join('');
      });

      _digitControllers[currentIndex].forward();

      currentIndex++;

      if (currentIndex == 4) {
        _completeController.forward().then((_) {
          _handleOtpComplete();
        });
      }
    }
  }

  void _onBackspaceTap() {
    if (currentIndex > 0) {
      currentIndex--;

      _digitControllers[currentIndex].reverse();

      setState(() {
        code[currentIndex] = '';
        verificationCode = code.join('');
      });

      if (currentIndex == 3) {
        _completeController.reset();
      }
    }
  }

  void _handleOtpComplete() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('OTP Verified Successfully!'),
          ],
        ),
        backgroundColor: AppConstants.primaryColor,
        duration: Duration(milliseconds: 1200),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    Future.delayed(Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RegistrationScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 800),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: AppConstants.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.email_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 32),

              const Text(
                'Verification Code',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Please type the verification code\nsent to +91 636 353 9927',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.4),
              ),

              const SizedBox(height: 48),

              AnimatedBuilder(
                animation: _completeAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _completeAnimation.value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        bool isSelected =
                            index == currentIndex && currentIndex < 4;
                        bool hasCode = code[index].isNotEmpty;

                        return AnimatedBuilder(
                          animation: _digitAnimations[index],
                          builder: (context, child) {
                            return AnimatedBuilder(
                              animation: _colorAnimations[index],
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: hasCode
                                      ? (1.0 +
                                            (_digitAnimations[index].value *
                                                0.2))
                                      : 1.0,
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: hasCode
                                            ? _colorAnimations[index].value ??
                                                  AppConstants.primaryColor
                                            : (isSelected
                                                  ? AppConstants.primaryColor
                                                  : Colors.grey.shade300),
                                        width: isSelected || hasCode ? 1 : 1,
                                      ),
                                      color: Colors.white,
                                     
                                    ),
                                    child: Center(
                                      child: AnimatedDefaultTextStyle(
                                        duration: Duration(milliseconds: 200),
                                        style: TextStyle(
                                          fontSize: hasCode ? 24 : 16,
                                          color: hasCode
                                              ? AppConstants.primaryColor
                                              : Colors.grey,
                                          
                                        ),
                                        child: Text(hasCode ? code[index] : ''),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AnimatedBuilder(
                    animation: _timerAnimation,
                    builder: (context, child) {
                      int minutes = _timerAnimation.value ~/ 60;
                      int seconds = _timerAnimation.value % 60;
                      return Text(
                        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppConstants.primaryColor,
                        ),
                      );
                    },
                  ),

                  GestureDetector(
                    onTap: () {
                      _timerController.reset();
                      _timerController.forward();
                      setState(() {
                        code = ['', '', '', ''];
                        currentIndex = 0;
                        verificationCode = '';
                      });

                      for (var controller in _digitControllers) {
                        controller.reset();
                      }
                      _completeController.reset();
                    },
                    child: Text(
                      "Resend OTP?",
                      style: TextStyle(
                        fontSize: 18,
                        color: AppConstants.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNumberButton('1'),
                        _buildNumberButton('2'),
                        _buildNumberButton('3'),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNumberButton('4'),
                        _buildNumberButton('5'),
                        _buildNumberButton('6'),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNumberButton('7'),
                        _buildNumberButton('8'),
                        _buildNumberButton('9'),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(width: 60),
                        _buildNumberButton('0'),
                        _buildBackspaceButton(),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return GestureDetector(
      onTap: () => _onNumberTap(number),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: Center(
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    return GestureDetector(
      onTap: _onBackspaceTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black87,
        ),
        child: const Icon(
          Icons.arrow_left_rounded,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
