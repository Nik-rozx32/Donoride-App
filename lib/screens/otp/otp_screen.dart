import 'package:donoridedrive/constants/App_constant.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with TickerProviderStateMixin {
  String verificationCode = '';
  List<String> code = ['', '', '', '']; // Changed to 4 digits to match UI
  int currentIndex = 0;
  
  late AnimationController _timerController;
  late Animation<int> _timerAnimation;
  
  @override
  void initState() {
    super.initState();
    _timerController = AnimationController(
      duration: Duration(seconds: 60), // 1 minute countdown
      vsync: this,
    );
    
    _timerAnimation = IntTween(
      begin: 60,
      end: 0,
    ).animate(_timerController);
    
    _timerController.forward(); // Start the countdown
  }
  
  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  void _onNumberTap(String number) {
    if (currentIndex < 4) { // Changed from 6 to 4
      setState(() {
        code[currentIndex] = number;
        currentIndex++;
        verificationCode = code.join('');
      });
    }
  }

  void _onBackspaceTap() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        code[currentIndex] = '';
        verificationCode = code.join('');
      });
    }
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
              const SizedBox(height: 60),

              Container(
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  bool isSelected = index == currentIndex && currentIndex < 4; // Changed from 6 to 4
                  bool hasCode = code[index].isNotEmpty;

                  return Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? AppConstants.primaryColor
                            : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        hasCode ? code[index] : '',
                        style: TextStyle(
                          fontSize: hasCode ? 24 : 16,
                          color: AppConstants.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }),
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
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),
                  
                  GestureDetector(
                    child: Text("Resend OTP?",style: TextStyle(fontSize: 18,
                            color: AppConstants.primaryColor,
                            fontWeight: FontWeight.w500,),),
                  )
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
      child: Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
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
      child: Container(
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