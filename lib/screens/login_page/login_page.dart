import 'package:donoridedrive/constants/App_constant.dart';
import 'package:donoridedrive/screens/otp/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isValidPhoneNumber = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_validatePhoneNumber);
  }

  @override
  void dispose() {
    _phoneController.removeListener(_validatePhoneNumber);
    _phoneController.dispose();
    super.dispose();
  }

  void _validatePhoneNumber() {
    String phoneNumber = _phoneController.text.trim();
    bool isValid =
        phoneNumber.length == 10 &&
        phoneNumber.isNotEmpty &&
        RegExp(r'^[0-9]+$').hasMatch(phoneNumber);

    if (_isValidPhoneNumber != isValid) {
      setState(() {
        _isValidPhoneNumber = isValid;
      });
    }
  }

  void _sendOTP() {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => 
              OtpScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Slide + Fade transition
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var slideTween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            var fadeAnimation = animation.drive(
              CurveTween(curve: curve),
            );

            return FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(
                position: animation.drive(slideTween),
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 600),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              const Text(
                "Welcome Back to",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Donoride",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.primaryColor,
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                height: 200,
                child: Image.asset(
                  "lib/assets/login/login.jpg",
                  fit: BoxFit.contain,
                ),
              ),

              const Spacer(),

              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Login with your Phone Number",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.phone, size: 20, color: Colors.black54),
                        SizedBox(width: 6),
                        Text(
                          "+91",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 8),
                      ],
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 0,
                    minHeight: 0,
                  ),
                  hintText: "936 353 9927",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 12.0,
                  ),
                  counterText: "",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color:
                          _phoneController.text.isNotEmpty &&
                              !_isValidPhoneNumber
                          ? Colors.red
                          : Colors.grey,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: _isValidPhoneNumber
                          ? AppConstants.primaryColor
                          : _phoneController.text.isNotEmpty
                          ? Colors.red
                          : AppConstants.primaryColor,
                      width: 1.2,
                    ),
                  ),
                  suffixIcon: _phoneController.text.isNotEmpty
                      ? Icon(
                          _isValidPhoneNumber
                              ? Icons.check_circle
                              : Icons.error,
                          color: _isValidPhoneNumber
                              ? Colors.green
                              : Colors.red,
                          size: 20,
                        )
                      : null,
                ),
              ),

              if (_phoneController.text.isNotEmpty && !_isValidPhoneNumber)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 8),
                  child: const Text(
                    "Please enter a valid 10-digit phone number",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isValidPhoneNumber ? _sendOTP : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isValidPhoneNumber
                        ? AppConstants.primaryColor
                        : Colors.grey.shade300,
                    foregroundColor: _isValidPhoneNumber
                        ? Colors.white
                        : Colors.grey.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: _isValidPhoneNumber ? 2 : 0,
                  ),
                  child: const Text(
                    "Send OTP",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: const [
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("Or sign Up"),
                  ),
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                ],
              ),

              const SizedBox(height: 20),

              Text.rich(
                TextSpan(
                  text: "By Continuing, You Agree to The Donoride ",
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                  children: [
                    TextSpan(
                      text: "Terms & Conditions ",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppConstants.primaryColor,
                      ),
                    ),
                    const TextSpan(text: "And "),
                    TextSpan(
                      text: "Privacy Policy",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppConstants.primaryColor,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
