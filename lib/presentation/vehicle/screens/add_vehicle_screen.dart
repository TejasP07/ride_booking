import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_tejas/generated/l10n/app_localizations.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/text_theme.dart';
import '../../../core/utils/snackbars.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/widgets/primary_button.dart';
import '../provider/vehicle_provider.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final regNoController = TextEditingController();

  final vehicleTypeController = TextEditingController();

  final vehicleNameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<VehicleProvider>();

      provider.resetVehicleForm();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VehicleProvider>();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.screenPadding),

        child: Form(
          key: formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 28),
              GestureDetector(
                onTap: () {
                  context.pop();
                },

                child: Container(
                  width: 52,

                  height: 52,

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(18),

                    border: Border.all(color: Colors.grey.shade300),
                  ),

                  child: Icon(Icons.arrow_back_ios_new_rounded, size: 22),
                ),
              ),

              SizedBox(height: 28),

              /// TITLE
              Text(
                AppLocalizations.of(context)!.addVehicle,

                style: AppTextTheme.headingLarge.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  FocusScope.of(context).unfocus();

                  await provider.pickImage();
                },

                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),

                  height: 220,

                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(24),

                    border: Border.all(color: AppColors.primary, width: 1.5),
                  ),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),

                    child: Builder(
                      builder: (_) {
                        /// LOADING
                        if (provider.isPickingImage) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              const CircularProgressIndicator(),

                              const SizedBox(height: 18),

                              Text(AppLocalizations.of(context)!.loading),
                            ],
                          );
                        }

                        /// EMPTY
                        if (provider.selectedImage == null) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Image.asset(
                                "assets/images/gallary_icon.png",

                                width: 42,
                                height: 42,
                              ),

                              const SizedBox(height: 16),

                              Text(
                                AppLocalizations.of(context)!.addCarImage,

                                style: AppTextTheme.bodyLarge.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                AppLocalizations.of(context)!.chooseFile,

                                style: TextStyle(
                                  color: AppColors.primary,

                                  fontSize: 16,

                                  fontWeight: FontWeight.w700,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                AppLocalizations.of(context)!.imageFormats,

                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          );
                        }

                        /// IMAGE
                        return Stack(
                          fit: StackFit.expand,

                          children: [
                            Image.file(
                              provider.selectedImage!,
                              fit: BoxFit.cover,
                            ),

                            Positioned(
                              top: 14,
                              right: 14,

                              child: Container(
                                width: 42,
                                height: 42,

                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.5),

                                  shape: BoxShape.circle,
                                ),

                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                AppLocalizations.of(context)!.registrationNumber,

                style: AppTextTheme.bodyLarge,
              ),
              const SizedBox(height: 3),

              CustomTextField(
                controller: regNoController,

                hintText: AppLocalizations.of(context)!.registrationNumber,

                keyboardType: TextInputType.text,

                validator:
                    (value) => Validators.validateVehicleNumber(context, value),
              ),

              const SizedBox(height: 18),

              Text(
                AppLocalizations.of(context)!.vehicleName,

                style: AppTextTheme.bodyLarge,
              ),

              const SizedBox(height: 10),

              CustomTextField(
                controller: vehicleNameController,

                hintText: AppLocalizations.of(context)!.enterVehicleName,

                keyboardType: TextInputType.text,

                validator: (value) {
                  return Validators.validateRequired(context, value);
                },
              ),

              const SizedBox(height: 34),

              PrimaryButton(
                title: AppLocalizations.of(context)!.addVehicle,

                isLoading: provider.isAddingVehicle,

                onTap: () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }

                  if (provider.selectedImage == null) {
                    SnackbarHelper.showWarning(
                      context,
                      AppLocalizations.of(context)!.selectVehicleImage,
                    );

                    return;
                  }
                  final success = await provider.addVehicle(
                    regNo: regNoController.text,

                    vehicleType: provider.selectedVehicleType,

                    vehicleName: vehicleNameController.text,
                  );

                  if (!context.mounted) return;

                  if (success) {
                    SnackbarHelper.showSuccess(
                      context,
                      AppLocalizations.of(context)!.vehicleAddedSuccessfully,
                    );

                    context.pop();
                  } else {
                    SnackbarHelper.showError(context, 'Failed to add vehicle');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
