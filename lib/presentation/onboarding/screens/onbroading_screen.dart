import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/text_theme.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../generated/l10n/app_localizations.dart';
import '../../../routes/route_names.dart';
import '../provider/onboarding_provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OnboardingProvider>().initialize(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();

    final localizations = AppLocalizations.of(context)!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final height = constraints.maxHeight;

        final isTablet = width > 700;

        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,

          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// TOP SKIP

              /// PAGEVIEW
              Expanded(
                child: PageView.builder(
                  controller: provider.pageController,

                  onPageChanged: provider.updateIndex,

                  itemCount: provider.pages.length,

                  itemBuilder: (context, index) {
                    final item = provider.pages[index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        /// FULL WIDTH HERO
                        SizedBox(
                          height: height * 0.48,

                          width: double.infinity,

                          child: Stack(
                            alignment: Alignment.center,

                            children: [
                              /// BLUE BACKGROUND
                              Positioned.fill(
                                top: 0,

                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    bottom: Radius.circular(180),
                                  ),

                                  child: Image.asset(
                                    item.image,

                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),

                              /// FOREGROUND IMAGE
                              Positioned(
                                bottom: 0,

                                child: Image.asset(
                                  item.image2,

                                  width: isTablet ? width * 0.42 : width * 0.82,

                                  fit: BoxFit.contain,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 0.08 * height,

                                  right: isTablet ? 32 : 22,
                                ),
                                child: Align(
                                  alignment: Alignment.topRight,

                                  child: GestureDetector(
                                    onTap: () async {
                                      await provider.completeOnboarding();

                                      if (!context.mounted) {
                                        return;
                                      }

                                      context.go(RouteNames.login);
                                    },

                                    child: Text(
                                      localizations.skip,

                                      style: TextStyle(
                                        fontSize: isTablet ? 18 : 15,

                                        fontWeight: FontWeight.w700,

                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// CONTENT AREA
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isTablet ? 40 : 24,
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                SizedBox(height: isTablet ? 30 : 24),

                                /// TITLE
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: item.highlightTitle,

                                        style: AppTextTheme.headingLarge
                                            .copyWith(
                                              fontSize: isTablet ? 44 : 28,

                                              color: AppColors.primary,

                                              height: 1.1,
                                            ),
                                      ),

                                      TextSpan(
                                        text: item.normalTitle,

                                        style: AppTextTheme.headingLarge
                                            .copyWith(
                                              fontSize: isTablet ? 44 : 28,

                                              color: Colors.black,

                                              height: 1.1,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: isTablet ? 24 : 14),

                                /// DESCRIPTION
                                Text(
                                  item.subtitle,

                                  style: AppTextTheme.bodyLarge.copyWith(
                                    fontSize: isTablet ? 19 : 15,

                                    height: 1.6,

                                    color: Colors.grey.shade600,
                                  ),
                                ),

                                const Spacer(),

                                /// INDICATORS
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: List.generate(
                                    provider.pages.length,

                                    (index) {
                                      final isActive =
                                          provider.currentIndex == index;

                                      return AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 250,
                                        ),

                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),

                                        width: isActive ? 26 : 8,

                                        height: 8,

                                        decoration: BoxDecoration(
                                          color:
                                              isActive
                                                  ? const Color(0xffFFD400)
                                                  : Colors.grey.shade400,

                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                SizedBox(height: isTablet ? 34 : 24),

                                /// BUTTON
                                PrimaryButton(
                                  title:
                                      provider.currentIndex == 2
                                          ? localizations.getStarted
                                          : localizations.next,

                                  isLoading: false,

                                  onTap: () async {
                                    if (provider.currentIndex == 2) {
                                      await provider.completeOnboarding();

                                      if (!context.mounted) {
                                        return;
                                      }

                                      context.go(RouteNames.login);
                                    } else {
                                      provider.nextPage();
                                    }
                                  },
                                ),

                                SizedBox(height: isTablet ? 36 : 24),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
