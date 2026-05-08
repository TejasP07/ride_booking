import 'package:flutter/material.dart';

import '../../../core/services/secure_storage_service.dart';

import '../model/onboarding_model.dart';

class OnboardingProvider extends ChangeNotifier {
  final SecureStorageService secureStorageService;

  OnboardingProvider({required this.secureStorageService});

  final PageController pageController = PageController();

  int currentIndex = 0;

  List<OnboardingModel> pages = [];

  void initialize(BuildContext context) {
    pages = [
      /// PAGE 1
      OnboardingModel(
        image: "assets/images/onboarding_1.png",
        image2: "assets/images/onboarding_1A.png",

        highlightTitle: "Professional ",

        normalTitle: "Cleaning, Simplified",

        subtitle:
            "Book vehicle and professional cleaning services managed end-to-end by a verified system no guesswork, no compromises.",
      ),

      /// PAGE 2
      OnboardingModel(
        image: "assets/images/onboarding_2.png",
        image2: "assets/images/onboarding_2A.png",

        highlightTitle: "Live Tracking & ",

        normalTitle: "Transparency",

        subtitle:
            "From booking to completion, track your service in real time and view verified before-and-after proof.",
      ),

      /// PAGE 3
      OnboardingModel(
        image: "assets/images/onboarding_3.png",
        image2: "assets/images/onboarding_3A.png",
        highlightTitle: "Quality ",

        normalTitle: "You Can Trust and Validate",

        subtitle:
            "Every job is assigned, monitored, and validated by an admin-controlled system to ensure quality and reliable service.",
      ),
    ];

    notifyListeners();
  }

  void updateIndex(int index) {
    currentIndex = index;

    notifyListeners();
  }

  Future<void> nextPage() async {
    if (currentIndex < pages.length - 1) {
      await pageController.nextPage(
        duration: const Duration(milliseconds: 300),

        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> completeOnboarding() async {
    await secureStorageService.saveOnboardingDone();
  }

  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }
}
