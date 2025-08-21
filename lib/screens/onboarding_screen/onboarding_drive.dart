import 'package:donoridedrive/screens/location_access/location_access_screen.dart';
import 'package:flutter/material.dart';
import 'package:donoridedrive/constants/App_constant.dart';

class OnboardingData {
  final String title;
  final String subtitle;
  final String description;
  final String imagePath;
  final String primaryButtonText;
  final bool showSkipButton;

  OnboardingData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imagePath,
    required this.primaryButtonText,
    this.showSkipButton = true,
  });
}

class OnboardingFlow extends StatefulWidget {
  @override
  _OnboardingFlowState createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  int currentIndex = 0;

  final List<OnboardingData> screens = [
    OnboardingData(
      title: "Welcome to dono ride Driver",
      subtitle: "Drive. Earn. Repeat.",
      description:
          "Join thousands of drivers earning on their own schedule with dono ride.",
      imagePath: "lib/assets/onboarding-images/onboarding_1.png",
      primaryButtonText: "Get Start",
    ),
    OnboardingData(
      title: "Real-Time Navigation",
      subtitle: "Built-in GPS Navigation",
      description:
          "Get the fastest route with real-time traffic, updates and in-app directions.",
      imagePath: "lib/assets/onboarding-images/onboarding_2.png",
      primaryButtonText: "Next",
    ),
    OnboardingData(
      title: "Easy Ride Requests",
      subtitle: "Get Ride Requests Instantly",
      description:
          "Accept nearby ride requests and start earning - no waiting, no stress.",
      imagePath: "lib/assets/onboarding-images/onboarding_3.png",
      primaryButtonText: "Let's Go",
      showSkipButton: false,
    ),
  ];

  void _handlePrimaryAction() {
    if (currentIndex < screens.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      _completeOnboarding();
    }
  }

  void _handleSkipAction() {
    _completeOnboarding();
  }

  void _completeOnboarding() {
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LocationAccessScreen()),
  );
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingScreen(
      data: screens[currentIndex],
      onPrimaryPressed: _handlePrimaryAction,
      onSkipPressed: _handleSkipAction,
      currentStep: currentIndex,
      totalSteps: screens.length,
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  final OnboardingData data;
  final VoidCallback onPrimaryPressed;
  final VoidCallback? onSkipPressed;
  final int currentStep;
  final int totalSteps;

  const OnboardingScreen({
    Key? key,
    required this.data,
    required this.onPrimaryPressed,
    this.onSkipPressed,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    child: Image.asset(data.imagePath),
                  ),
                ),
              ),

              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      data.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),

                    Text(
                      data.subtitle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    Text(
                      data.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(totalSteps, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == currentStep
                          ? Colors
                                .white 
                          : AppConstants.primaryColor, 
                      border: Border.all(
                        color: AppConstants.primaryColor, 
                        width: 1.0,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 40),

              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: onPrimaryPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        data.primaryButtonText,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  if (data.showSkipButton) ...[
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        onPressed: onSkipPressed,
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.grey.shade600,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
