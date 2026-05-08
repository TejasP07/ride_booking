import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

// import 'package:task_tejas/generated/l10n/app_localizations.dart';
import 'package:task_tejas/generated/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

import '../../../core/utils/snackbars.dart';
import '../../../core/utils/validators.dart';

import '../../../core/widgets/primary_button.dart';

import '../../../routes/route_names.dart';

import '../provider/auth_provider.dart';
import '../widgets/stars_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController mobileController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    mobileController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,

      resizeToAvoidBottomInset: true,

      body: Column(
        children: [
          /// TOP BLUE SECTION
          Container(
            width: double.infinity,

            // padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,

                end: Alignment.bottomRight,

                colors: [
                  AppColors.primary,

                  AppColors.primary.withValues(alpha: 0.85),
                ],
              ),
            ),

            child: Stack(
              children: [
                /// FULL BACKGROUND
                Positioned.fill(
                  child: Stack(
                    children: [
                      /// MAIN GRADIENT
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xff003CFF),
                              Color(0xff0A46FF),
                              Color(0xff2D63FF),
                              Color(0xff7FA2FF),
                            ],
                            stops: [0.0, 0.35, 0.72, 1.0],
                          ),
                        ),
                      ),

                      /// TOP RIGHT GLOW
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              center: const Alignment(0.78, -0.45),
                              radius: 1.15,
                              colors: [
                                Colors.white.withValues(alpha: 0.35),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),

                      /// GRID
                      Positioned.fill(
                        child: Opacity(
                          opacity: 0.08,
                          child: CustomPaint(painter: GridPainter()),
                        ),
                      ),

                      /// SMALL DOTS
                      Positioned.fill(
                        child: Opacity(
                          opacity: 0.15,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 12,
                                ),
                            itemBuilder: (_, __) {
                              return const Center(
                                child: CircleAvatar(
                                  radius: 1.4,
                                  backgroundColor: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// ACTUAL CONTENT
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 26,
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// LOGO
                      Container(
                        width: 52,
                        height: 52,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),

                          image: const DecorationImage(
                            image: AssetImage("assets/images/logo.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.06),

                      /// TITLE
                      Text(
                        AppLocalizations.of(context)!.signInToAccount,

                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          height: 1.15,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// SIGNUP
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.dontHaveAccount,

                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),

                          const SizedBox(width: 6),

                          GestureDetector(
                            onTap: () {},

                            child: Text(
                              AppLocalizations.of(context)!.signUp,

                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// FORM
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),

              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),

              child: Form(
                key: formKey,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 18),

                    /// MOBILE FIELD
                    Text(
                      AppLocalizations.of(context)!.enterMobile,

                      style: TextStyle(
                        color: AppColors.primary,

                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    /* Container(
                      height: 60,

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(16),

                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1.2,
                        ),
                      ),

                      child: Row(
                        children: [
                          /// COUNTRY CODE
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),

                            child: Row(
                              children: [
                                const Text(
                                  "🇮🇳",
                                  style: TextStyle(fontSize: 22),
                                ),

                                const SizedBox(width: 8),

                                Text(
                                  "+91",

                                  style: TextStyle(
                                    color: Colors.grey.shade800,

                                    fontSize: 16,

                                    fontWeight: FontWeight.w600,

                                    fontFamily: 'PlusJakartaSans',
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// DIVIDER
                          Container(
                            width: 1,
                            height: 28,
                            color: Colors.grey.shade300,
                          ),

                          /// INPUT
                          Expanded(
                            child: TextFormField(
                              controller: mobileController,

                              keyboardType: TextInputType.phone,

                              textAlignVertical: TextAlignVertical.center,

                              style: const TextStyle(
                                fontSize: 17,

                                fontWeight: FontWeight.w600,

                                fontFamily: 'PlusJakartaSans',
                              ),

                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,

                                LengthLimitingTextInputFormatter(10),
                              ],

                              validator: (value) {
                                return Validators.validateMobile(
                                  context,
                                  value,
                                );
                              },

                              */
                    /*  decoration: InputDecoration(
                                hintText:
                                    AppLocalizations.of(context)!.enterMobile,

                                hintStyle: TextStyle(
                                  color: Colors.grey.shade500,

                                  fontSize: 16,

                                  fontWeight: FontWeight.w500,
                                ),

                                border: InputBorder.none,

                                enabledBorder: InputBorder.none,

                                focusedBorder: InputBorder.none,

                                errorBorder: InputBorder.none,

                                focusedErrorBorder: InputBorder.none,

                                isCollapsed: true,

                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 20,
                                ),
                              ),*/
                    /*
                              decoration: InputDecoration(
                                hintText:
                                    AppLocalizations.of(context)!.enterMobile,

                                hintStyle: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),

                                border: InputBorder.none,

                                enabledBorder: InputBorder.none,

                                focusedBorder: InputBorder.none,

                                errorBorder: InputBorder.none,

                                focusedErrorBorder: InputBorder.none,

                                /// IMPORTANT
                                errorStyle: const TextStyle(
                                  height: 1.2,
                                  fontSize: 12,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),

                                /// IMPORTANT
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),*/
                    TextFormField(
                      controller: mobileController,

                      keyboardType: TextInputType.phone,

                      textAlignVertical: TextAlignVertical.center,

                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'PlusJakartaSans',
                      ),

                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,

                        LengthLimitingTextInputFormatter(10),
                      ],

                      validator: (value) {
                        return Validators.validateMobile(context, value);
                      },

                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.enterMobile,

                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),

                        /// REMOVE ALL BORDERS
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),

                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.2,
                          ),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),

                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.2,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),

                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 1.5,
                          ),
                        ),

                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),

                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.3,
                          ),
                        ),

                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),

                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.5,
                          ),
                        ),

                        /// THIS FIXES YOUR ISSUE
                        errorMaxLines: 2,

                        errorStyle: const TextStyle(
                          fontSize: 12,
                          height: 1.3,
                          fontWeight: FontWeight.w500,
                        ),

                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 10),

                          child: Row(
                            mainAxisSize: MainAxisSize.min,

                            children: [
                              const Text(
                                "🇮🇳",
                                style: TextStyle(fontSize: 22),
                              ),

                              const SizedBox(width: 8),

                              Text(
                                "+91",

                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'PlusJakartaSans',
                                ),
                              ),

                              const SizedBox(width: 12),

                              Container(
                                width: 1,
                                height: 28,
                                color: Colors.grey.shade300,
                              ),
                            ],
                          ),
                        ),

                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),

                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),

                    /// SEND OTP BUTTON
                    PrimaryButton(
                      title: AppLocalizations.of(context)!.sendOtp,

                      isLoading: provider.isLoading,

                      onTap: () async {
                        FocusScope.of(context).unfocus();

                        if (!formKey.currentState!.validate()) {
                          return;
                        }

                        final success = await provider.requestOtp(
                          mobileNumber: "+${mobileController.text}",
                        );

                        if (!context.mounted) {
                          return;
                        }

                        if (success) {
                          SnackbarHelper.showSuccess(
                            context,

                            AppLocalizations.of(context)!.otpSentSuccessfully,
                          );

                          context.push(RouteNames.otp);
                        } else {
                          SnackbarHelper.showError(
                            context,

                            provider.errorMessage.trim().isNotEmpty
                                ? provider.errorMessage
                                : AppLocalizations.of(context)!.failedToSendOtp,
                          );
                        }
                      },
                    ),

                    SizedBox(height: size.height * 0.05),

                    /// SIGNUP TEXT
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Text(
                          AppLocalizations.of(context)!.dontHaveAccount,

                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(width: 6),

                        GestureDetector(
                          onTap: () {},

                          child: Text(
                            AppLocalizations.of(context)!.signUp,

                            style: TextStyle(
                              color: AppColors.lightBlueColor,

                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: size.height * 0.22),

                    /// TERMS
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),

                      child: RichText(
                        textAlign: TextAlign.center,

                        text: TextSpan(
                          style: TextStyle(
                            color: AppColors.textSecondary,

                            fontSize: 12,

                            height: 1.6,
                          ),

                          children: [
                            TextSpan(
                              text: AppLocalizations.of(context)!.termsLine,
                            ),

                            TextSpan(
                              text:
                                  AppLocalizations.of(context)!.termsOfService,

                              style: TextStyle(
                                color: AppColors.textSecondary,

                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            TextSpan(
                              text: " ${AppLocalizations.of(context)!.and} ",
                            ),

                            TextSpan(
                              text: AppLocalizations.of(context)!.privacyPolicy,

                              style: TextStyle(
                                color: AppColors.textSecondary,

                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
