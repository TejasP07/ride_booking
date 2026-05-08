import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/text_theme.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../generated/l10n/app_localizations.dart';
import '../../../routes/route_names.dart';
import '../provider/vehicle_provider.dart';
import '../provider/vehicle_type_provider.dart';

class SelectVehicleTypeScreen extends StatelessWidget {
  const SelectVehicleTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VehicleProvider>();

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            final height = constraints.maxHeight;

            final isTablet = width > 700;

            final horizontalPadding = isTablet ? 32.0 : 22.0;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),

              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                18,
                horizontalPadding,
                26,
              ),

              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: height - 40),

                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      /// BACK BUTTON
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },

                        child: Container(
                          width: isTablet ? 64 : 52,

                          height: isTablet ? 64 : 52,

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(18),

                            border: Border.all(color: Colors.grey.shade300),
                          ),

                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,

                            size: isTablet ? 26 : 22,
                          ),
                        ),
                      ),

                      SizedBox(height: isTablet ? 42 : 28),

                      /// TITLE
                      Text(
                        AppLocalizations.of(context)!.addVehicle,

                        style: AppTextTheme.headingLarge.copyWith(
                          fontSize: isTablet ? 20 : 20,
                        ),
                      ),

                      SizedBox(height: isTablet ? 42 : 30),

                      /// SUBTITLE
                      Text(
                        AppLocalizations.of(context)!.chooseVehicleType,

                        style: AppTextTheme.headingMedium.copyWith(
                          fontSize: isTablet ? 30 : 18,

                          color: Colors.black87,
                        ),
                      ),

                      SizedBox(height: isTablet ? 34 : 24),

                      /// FOUR WHEELER
                      _VehicleTypeCard(
                        title: AppLocalizations.of(context)!.fourWheeler,

                        image: "assets/images/car.png",

                        isSelected: provider.selectedVehicleType == "Car",

                        isTablet: isTablet,

                        onTap: () {
                          provider.selectVehicleType("Car");
                        },
                      ),

                      SizedBox(height: isTablet ? 28 : 20),

                      /// TWO WHEELER
                      _VehicleTypeCard(
                        title: AppLocalizations.of(context)!.twoWheeler,

                        image: "assets/images/bike.png",

                        isSelected: provider.selectedVehicleType == "Bike",

                        isTablet: isTablet,

                        onTap: () {
                          provider.selectVehicleType("Bike");
                        },
                      ),

                      const Spacer(),

                      SizedBox(height: isTablet ? 42 : 28),

                      /// BUTTON
                      PrimaryButton(
                        title: AppLocalizations.of(context)!.continueText,

                        isLoading: false,

                        isEnabled: provider.selectedVehicleType.isNotEmpty,

                        onTap: () {
                          if (provider.selectedVehicleType.isEmpty) {
                            return;
                          }
                          final vehicleProvider =
                              context.read<VehicleProvider>();

                          vehicleProvider.resetVehicleForm();

                          vehicleProvider.selectVehicleType(
                            provider.selectedVehicleType,
                          );

                          context.pushReplacement(RouteNames.addVehicle);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _VehicleTypeCard extends StatelessWidget {
  final String title;

  final String image;

  final bool isSelected;

  final bool isTablet;

  final VoidCallback onTap;

  const _VehicleTypeCard({
    required this.title,
    required this.image,
    required this.isSelected,
    required this.isTablet,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),

        curve: Curves.easeInOut,

        height: isTablet ? 260 : 190,

        width: double.infinity,

        padding: EdgeInsets.all(isTablet ? 24 : 18),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(32),

          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,

            width: isSelected ? 2 : 1.2,
          ),

          boxShadow: [
            BoxShadow(
              blurRadius: isSelected ? 24 : 12,

              offset: const Offset(0, 8),

              color: Colors.black.withValues(alpha: isSelected ? 0.08 : 0.04),
            ),
          ],
        ),

        child: Stack(
          children: [
            /// IMAGE
            Positioned(
              right: 0,
              bottom: 0,

              child: Image.asset(
                image,

                height: isTablet ? 185 : 130,

                fit: BoxFit.contain,
              ),
            ),

            /// CONTENT
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style: TextStyle(
                    fontSize: isTablet ? 30 : 20,

                    fontWeight: FontWeight.w700,

                    fontFamily: 'PlusJakartaSans',

                    color: Colors.black87,
                  ),
                ),

                const Spacer(),

                /// RADIO
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),

                  width: isTablet ? 34 : 28,

                  height: isTablet ? 34 : 28,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    border: Border.all(
                      color: isSelected ? AppColors.primary : Colors.black,

                      width: 2,
                    ),
                  ),

                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),

                    margin: const EdgeInsets.all(5),

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      color:
                          isSelected ? AppColors.primary : Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
