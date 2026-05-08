import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

import 'package:task_tejas/generated/l10n/app_localizations.dart';

import 'package:task_tejas/core/api/api_constants.dart';

import '../../../core/constants/app_colors.dart';

import '../../../core/theme/text_theme.dart';
import '../../../core/utils/snackbars.dart';

import '../../../routes/route_names.dart';

import '../provider/vehicle_provider.dart';

import '../widgets/vehicle_card_shimmer.dart';

class VehicleListScreen extends StatefulWidget {
  const VehicleListScreen({super.key});

  @override
  State<VehicleListScreen> createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<VehicleProvider>().getVehicles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VehicleProvider>();

    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 700;

    final cardAspectRatio =
        size.width < 360
            ? 0.70
            : size.width < 420
            ? 0.74
            : 0.78;

    final imageHeight = isTablet ? 180.0 : 140.0;

    final crossAxisCount = size.width > 700 ? 3 : 2;

    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },

                    child: Container(
                      width: 42,

                      height: 42,

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(14),

                        border: Border.all(color: Colors.grey.shade300),
                      ),

                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,

                        size: 18,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    AppLocalizations.of(context)!.myVehicles,

                    style: AppTextTheme.headingLarge.copyWith(
                      fontSize: isTablet ? 34 : 28,
                    ),
                  ),
                ],
              ),
            ),

            /// BODY
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await provider.getVehicles();
                },

                child: Builder(
                  builder: (_) {
                    switch (provider.state) {
                      /// LOADING
                      case VehicleState.loading:
                        return GridView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),

                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,

                            vertical: 8,
                          ),

                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,

                                crossAxisSpacing: 16,

                                mainAxisSpacing: 16,

                                childAspectRatio: 0.9,
                              ),

                          itemCount: 6,

                          itemBuilder: (context, index) {
                            return const VehicleCardShimmer();
                          },
                        );

                      /// EMPTY
                      case VehicleState.empty:
                        return SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),

                          child: SizedBox(
                            height: size.height * 0.7,

                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Icon(
                                    Icons.directions_car_filled_rounded,

                                    size: 80,

                                    color: Colors.grey.shade400,
                                  ),

                                  const SizedBox(height: 18),

                                  Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.noVehiclesFound,

                                    style: const TextStyle(
                                      fontSize: 18,

                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  const SizedBox(height: 24),

                                  ElevatedButton(
                                    onPressed: () {
                                      context.push(
                                        RouteNames.selectVehicleType,
                                      );
                                    },

                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,

                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 26,

                                        vertical: 16,
                                      ),

                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),

                                    child: Text(
                                      AppLocalizations.of(context)!.addVehicle,

                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );

                      /// ERROR
                      case VehicleState.error:
                        return SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),

                          child: SizedBox(
                            height: size.height * 0.7,

                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  const Icon(
                                    Icons.wifi_off_rounded,

                                    size: 70,

                                    color: Colors.red,
                                  ),

                                  const SizedBox(height: 18),

                                  Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.somethingWentWrong,

                                    style: const TextStyle(
                                      fontSize: 18,

                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  const SizedBox(height: 24),

                                  ElevatedButton(
                                    onPressed: () {
                                      provider.getVehicles();
                                    },

                                    child: Text(
                                      AppLocalizations.of(context)!.retry,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );

                      /// LOADED
                      case VehicleState.loaded:
                        return GridView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),

                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),

                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,

                                crossAxisSpacing: size.width < 360 ? 12 : 12,

                                mainAxisSpacing: size.width < 360 ? 12 : 10,
                                childAspectRatio: cardAspectRatio,
                              ),

                          itemCount: provider.vehicles.length,

                          itemBuilder: (context, index) {
                            final vehicle = provider.vehicles[index];

                            final imageUrl =
                                vehicle.vehicleImages.isNotEmpty
                                    ? "${ApiConstants.imageBaseUrl}${vehicle.vehicleImages.first}"
                                    : "";

                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(24),

                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 18,

                                    offset: const Offset(0, 8),

                                    color: Colors.black.withValues(alpha: 0.04),
                                  ),
                                ],
                              ),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  /// IMAGE
                                  SizedBox(
                                    height: imageHeight,

                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(24),
                                      ),

                                      child: CachedNetworkImage(
                                        imageUrl: imageUrl,

                                        width: double.infinity,

                                        fit: BoxFit.cover,

                                        placeholder: (context, url) {
                                          return Container(
                                            color: Colors.grey.shade200,

                                            child: const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        },

                                        errorWidget: (context, url, error) {
                                          return Container(
                                            color: Colors.grey.shade200,

                                            child: const Icon(
                                              Icons.image_not_supported,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),

                                  /// CONTENT
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                        size.width < 360 ? 10 : 10,
                                      ),

                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,

                                        children: [
                                          /// TOP
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 10,

                                                      vertical: 5,
                                                    ),

                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xffFFD60A,
                                                  ),

                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),

                                                child: Text(
                                                  vehicle.vehicleType ==
                                                          "two_wheeler"
                                                      ? "Bike"
                                                      : "Car",

                                                  style: AppTextTheme.bodyMedium
                                                      .copyWith(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w700,

                                                        color: Colors.black,
                                                      ),
                                                ),
                                              ),

                                              const Spacer(),

                                              provider.deletingVehicleId ==
                                                      vehicle.id
                                                  ? const SizedBox(
                                                    width: 18,

                                                    height: 18,

                                                    child:
                                                        CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                        ),
                                                  )
                                                  : GestureDetector(
                                                    onTap: () async {
                                                      final confirm = await showDialog(
                                                        context: context,

                                                        builder: (_) {
                                                          return AlertDialog(
                                                            title: Text(
                                                              AppLocalizations.of(
                                                                context,
                                                              )!.deleteVehicle,
                                                            ),

                                                            content: Text(
                                                              AppLocalizations.of(
                                                                context,
                                                              )!.areYouSure,
                                                            ),

                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                    context,
                                                                    false,
                                                                  );
                                                                },

                                                                child: Text(
                                                                  AppLocalizations.of(
                                                                    context,
                                                                  )!.cancel,
                                                                ),
                                                              ),

                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                    context,
                                                                    true,
                                                                  );
                                                                },

                                                                child: Text(
                                                                  AppLocalizations.of(
                                                                    context,
                                                                  )!.delete,
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );

                                                      if (confirm != true) {
                                                        return;
                                                      }

                                                      try {
                                                        await provider
                                                            .deleteVehicle(
                                                              vehicle.id,
                                                            );

                                                        if (!context.mounted) {
                                                          return;
                                                        }

                                                        SnackbarHelper.showSuccess(
                                                          context,

                                                          AppLocalizations.of(
                                                            context,
                                                          )!.vehicleDeletedSuccessfully,
                                                        );
                                                      } catch (e) {
                                                        if (!context.mounted) {
                                                          return;
                                                        }

                                                        SnackbarHelper.showError(
                                                          context,

                                                          AppLocalizations.of(
                                                            context,
                                                          )!.failedToDeleteVehicle,
                                                        );
                                                      }
                                                    },

                                                    child: const Icon(
                                                      Icons
                                                          .delete_outline_rounded,

                                                      size: 22,
                                                    ),
                                                  ),
                                            ],
                                          ),

                                          const SizedBox(height: 1),

                                          /// NAME
                                          Text(
                                            vehicle.vehicleName,

                                            maxLines: 1,

                                            overflow: TextOverflow.ellipsis,

                                            style: AppTextTheme.bodyLarge
                                                .copyWith(
                                                  fontSize: isTablet ? 18 : 15,

                                                  fontWeight: FontWeight.w700,
                                                ),
                                          ),

                                          const SizedBox(height: 2),

                                          /// NUMBER
                                          Text(
                                            vehicle.regNo,

                                            maxLines: 1,

                                            overflow: TextOverflow.ellipsis,

                                            style: AppTextTheme.bodyMedium
                                                .copyWith(
                                                  fontSize: isTablet ? 15 : 13,

                                                  color: Colors.grey.shade700,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      /// BOTTOM BUTTON
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),

          child: SizedBox(
            height: 58,

            child: ElevatedButton(
              onPressed: () {
                context.push(RouteNames.selectVehicleType);
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,

                elevation: 0,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),

              child: Text(
                AppLocalizations.of(context)!.addVehicle,

                style: AppTextTheme.buttonText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
