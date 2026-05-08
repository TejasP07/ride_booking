import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/snackbars.dart';

import '../../../core/widgets/primary_button.dart';

import '../../../generated/l10n/app_localizations.dart';
import '../../../routes/route_names.dart';

import '../provider/auth_provider.dart';

import '../widgets/otp_input_box.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otp1Controller = TextEditingController();

  final otp2Controller = TextEditingController();

  final otp3Controller = TextEditingController();

  final otp4Controller = TextEditingController();

  final focus1 = FocusNode();

  final focus2 = FocusNode();

  final focus3 = FocusNode();

  final focus4 = FocusNode();

  int seconds = 20;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  void startTimer() {
    timer?.cancel();

    seconds = 20;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          seconds--;
        });
      }
    });
  }

  String get otp {
    return otp1Controller.text +
        otp2Controller.text +
        otp3Controller.text +
        otp4Controller.text;
  }

  @override
  void dispose() {
    timer?.cancel();

    otp1Controller.dispose();
    otp2Controller.dispose();
    otp3Controller.dispose();
    otp4Controller.dispose();

    focus1.dispose();
    focus2.dispose();
    focus3.dispose();
    focus4.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    final size = MediaQuery.of(context).size;

    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      resizeToAvoidBottomInset: true,

      backgroundColor: Colors.white,

      body: Column(
        children: [
          /// TOP BLUE SECTION
          Container(
            width: double.infinity,

            padding: EdgeInsets.symmetric(
              horizontal: 24,

              vertical: size.height * 0.035,
            ),

            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,

                end: Alignment.bottomRight,

                colors: [
                  AppColors.primary,

                  AppColors.primary.withValues(alpha: 0.82),
                ],
              ),
            ),

            child: Stack(
              children: [
                /// DOTS
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.08,

                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),

                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 12,
                          ),

                      itemBuilder: (_, __) {
                        return const Center(
                          child: CircleAvatar(
                            radius: 1.5,

                            backgroundColor: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    SizedBox(height: size.height * 0.02),

                    /// BACK BUTTON
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },

                      child: Container(
                        width: 42,

                        height: 42,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),

                          border: Border.all(color: Colors.white),
                        ),

                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,

                          color: Colors.white,

                          size: 18,
                        ),
                      ),
                    ),

                    SizedBox(height: size.height * 0.07),

                    /// TITLE
                    Text(
                      AppLocalizations.of(context)!.enterCode,

                      style: const TextStyle(
                        color: Colors.white,

                        fontSize: 40,

                        fontWeight: FontWeight.w700,

                        fontFamily: 'PlusJakartaSans',

                        height: 1.1,
                      ),
                    ),

                    const SizedBox(height: 18),

                    /// SUBTITLE
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,

                          height: 1.6,
                        ),

                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!.otpDescription,
                          ),

                          TextSpan(
                            text: provider.mobile,

                            style: const TextStyle(
                              color: Colors.white,

                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: size.height * 0.05),
                  ],
                ),
              ],
            ),
          ),

          /// WHITE CARD
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),

              padding: const EdgeInsets.all(16),

              child: Container(
                width: double.infinity,

                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(24),
                ),

                child: Column(
                  children: [
                    /// OTP BOXES
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        OtpInputBox(
                          controller: otp1Controller,

                          focusNode: focus1,

                          nextFocus: focus2,
                        ),

                        OtpInputBox(
                          controller: otp2Controller,

                          focusNode: focus2,

                          nextFocus: focus3,

                          previousFocus: focus1,
                        ),

                        OtpInputBox(
                          controller: otp3Controller,

                          focusNode: focus3,

                          nextFocus: focus4,

                          previousFocus: focus2,
                        ),

                        OtpInputBox(
                          controller: otp4Controller,

                          focusNode: focus4,

                          previousFocus: focus3,
                        ),
                      ],
                    ),

                    const SizedBox(height: 26),

                    /// RESEND
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        GestureDetector(
                          onTap:
                              seconds == 0
                                  ? () async {
                                    final success = await provider.requestOtp(
                                      mobileNumber: provider.mobile,
                                    );

                                    if (!context.mounted) {
                                      return;
                                    }

                                    if (success) {
                                      startTimer();

                                      SnackbarHelper.showSuccess(
                                        context,

                                        AppLocalizations.of(
                                          context,
                                        )!.otpSentSuccessfully,
                                      );
                                    }
                                  }
                                  : null,

                          child: Text(
                            AppLocalizations.of(context)!.sendCodeAgain,

                            style: TextStyle(
                              color: AppColors.primary,

                              fontWeight: FontWeight.w700,

                              fontSize: 16,
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Text(
                          "00:$seconds",

                          style: const TextStyle(
                            fontSize: 16,

                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: keyboardOpen ? 30 : size.height * 0.08),

                    /// VERIFY BUTTON
                    PrimaryButton(
                      title:
                          otp.length == 4
                              ? AppLocalizations.of(context)!.verifyOtp
                              : AppLocalizations.of(context)!.enterOtp,

                      isLoading: provider.isLoading,

                      onTap: () async {
                        FocusScope.of(context).unfocus();

                        if (otp.length != 4) {
                          SnackbarHelper.showError(
                            context,

                            AppLocalizations.of(context)!.enterOtp,
                          );

                          return;
                        }

                        final success = await provider.verifyOtp(otp: otp);

                        if (!context.mounted) {
                          return;
                        }

                        if (success) {
                          SnackbarHelper.showSuccess(
                            context,

                            AppLocalizations.of(context)!.loginSuccessful,
                          );

                          context.go(RouteNames.home);
                        } else {
                          SnackbarHelper.showError(
                            context,

                            AppLocalizations.of(context)!.invalidOtp,
                          );
                        }
                      },
                    ),

                    SizedBox(height: keyboardOpen ? 20 : size.height * 0.18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
