import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'package:task_tejas/generated/l10n/app_localizations.dart';

import 'package:provider/provider.dart';

import '../../../core/api/api_constants.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

import '../../../core/utils/snackbars.dart';

import '../../auth/provider/auth_provider.dart';
import '../../auth/widgets/stars_widget.dart';
import '../provider/active_services_provider.dart';

import '../widgets/service_card.dart';
import '../widgets/service_card_shimmer.dart';

class ActiveServicesScreen extends StatefulWidget {
  const ActiveServicesScreen({super.key});

  @override
  State<ActiveServicesScreen> createState() => _ActiveServicesScreenState();
}

class _ActiveServicesScreenState extends State<ActiveServicesScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ActiveServicesProvider>().getServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ActiveServicesProvider>();

    final authProvider = context.watch<AuthProvider>();

    final user = authProvider.currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,

      /* appBar: AppBar(
        elevation: 0,

        centerTitle: false,

        backgroundColor: AppColors.background,

        title: Text(
          AppLocalizations.of(context)!.activeServices,

          style: const TextStyle(
            fontSize: 24,

            fontWeight: FontWeight.w700,

            fontFamily: 'PlusJakartaSans',
          ),
        ),
      ),*/
      body: RefreshIndicator(
        onRefresh: () async {
          await provider.getServices();

          if (!context.mounted) {
            return;
          }

          SnackbarHelper.showSuccess(context, "Updated");
        },

        child: Builder(
          builder: (_) {
            switch (provider.state) {
              /// LOADING
              case ServiceState.loading:
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),

                  padding: const EdgeInsets.all(AppSizes.screenPadding),

                  itemCount: 6,

                  separatorBuilder: (_, __) => const SizedBox(height: 18),

                  itemBuilder: (_, __) => const ServiceCardShimmer(),
                );

              /// EMPTY
              case ServiceState.empty:
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40),

                    child: Column(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        Icon(
                          Icons.cleaning_services_rounded,

                          size: 70,

                          color: AppColors.textSecondary,
                        ),

                        const SizedBox(height: 16),

                        Text(
                          AppLocalizations.of(context)!.noServicesFound,

                          style: const TextStyle(
                            fontSize: 18,

                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );

              /// ERROR
              case ServiceState.error:
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40),

                    child: Column(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        const Icon(
                          Icons.wifi_off_rounded,

                          size: 70,

                          color: Colors.red,
                        ),

                        const SizedBox(height: 16),

                        Text(
                          AppLocalizations.of(context)!.somethingWentWrong,

                          textAlign: TextAlign.center,

                          style: const TextStyle(
                            fontSize: 18,

                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 24),

                        ElevatedButton(
                          onPressed: () {
                            provider.getServices();
                          },

                          child: Text(AppLocalizations.of(context)!.retry),
                        ),
                      ],
                    ),
                  ),
                );

              /// LOADED
              case ServiceState.loaded:
                final size = MediaQuery.of(context).size;

                final isTablet = size.width > 700;

                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),

                  slivers: [
                    /// TOP HEADER
                    SliverToBoxAdapter(
                      child: Container(
                        width: double.infinity,

                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(30),
                          ),
                        ),

                        child: Stack(
                          children: [
                            /// BACKGROUND
                            Positioned.fill(
                              child: ClipRRect(
                                child: Stack(
                                  fit: StackFit.expand,

                                  children: [
                                    /// BACKGROUND IMAGE
                                    Image.asset(
                                      "assets/images/bg_image.png",

                                      fit: BoxFit.cover,
                                    ),

                                    /// DARK/BLUE OVERLAY

                                    /// GLOW EFFECT

                                    /// GRID EFFECT
                                    Positioned.fill(
                                      child: Opacity(
                                        opacity: 0.08,

                                        child: CustomPaint(
                                          painter: GridPainter(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            /// CONTENT
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                20,
                                60,
                                20,
                                isTablet ? 28 : 22,
                              ),

                              child: Column(
                                children: [
                                  /// PROFILE
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 28,

                                        backgroundColor: Colors.white,

                                        backgroundImage:
                                            (user?.profilePhoto != null &&
                                                    user!
                                                        .profilePhoto!
                                                        .isNotEmpty)
                                                ? NetworkImage(
                                                  "${ApiConstants.imageBaseUrl}${user.profilePhoto}",
                                                )
                                                : null,

                                        child:
                                            (user?.profilePhoto == null ||
                                                    user!.profilePhoto!.isEmpty)
                                                ? Icon(
                                                  Icons.person,
                                                  color: AppColors.primary,
                                                )
                                                : null,
                                      ),
                                      const SizedBox(width: 12),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,

                                          children: [
                                            /// USER NAME
                                            Text(
                                              user?.fullName?.isNotEmpty == true
                                                  ? user!.fullName
                                                  : AppLocalizations.of(
                                                    context,
                                                  )!.welcome,

                                              maxLines: 1,

                                              overflow: TextOverflow.ellipsis,

                                              style: TextStyle(
                                                color: Colors.white,

                                                fontWeight: FontWeight.w700,

                                                fontSize: isTablet ? 22 : 18,
                                              ),
                                            ),

                                            const SizedBox(height: 2),

                                            /// ADDRESS
                                            Text(
                                              user?.addresses?.isNotEmpty ==
                                                      true
                                                  ? user!
                                                      .addresses!
                                                      .first
                                                      .fullAddress
                                                  : "Location unavailable",

                                              maxLines: 1,

                                              overflow: TextOverflow.ellipsis,

                                              style: TextStyle(
                                                color: Colors.white70,

                                                fontSize: isTablet ? 15 : 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Container(
                                        width: isTablet ? 54 : 48,

                                        height: isTablet ? 54 : 48,

                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(
                                            alpha: 0.18,
                                          ),

                                          shape: BoxShape.circle,
                                        ),

                                        child: const Icon(
                                          Icons.notifications_none_rounded,

                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: isTablet ? 28 : 22),

                                  /// SEARCH
                                  Container(
                                    height: isTablet ? 68 : 60,

                                    decoration: BoxDecoration(
                                      color: Colors.white,

                                      borderRadius: BorderRadius.circular(18),
                                    ),

                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,

                                        prefixIcon: Icon(
                                          Icons.search,
                                          size: isTablet ? 30 : 26,
                                        ),

                                        hintText:
                                            "Search services car wash, sofa cleaning",

                                        hintStyle: TextStyle(
                                          color: Colors.grey.shade500,

                                          fontSize: isTablet ? 16 : 14,
                                        ),

                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              vertical: 18,
                                            ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: isTablet ? 24 : 18),

                                  /// TABS
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,

                                              children: [
                                                Icon(
                                                  Icons.verified_rounded,

                                                  color: AppColors.primary,
                                                ),

                                                const SizedBox(width: 8),

                                                Text(
                                                  "Fixed Price",

                                                  style: TextStyle(
                                                    color: AppColors.primary,

                                                    fontWeight: FontWeight.w700,

                                                    fontSize:
                                                        isTablet ? 22 : 18,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            const SizedBox(height: 14),

                                            Container(
                                              height: 3,

                                              decoration: BoxDecoration(
                                                color: AppColors.primary,

                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,

                                              children: [
                                                Icon(
                                                  Icons.request_quote_outlined,

                                                  color: Colors.grey,
                                                ),

                                                const SizedBox(width: 8),

                                                Text(
                                                  "Get a Quote",

                                                  style: TextStyle(
                                                    color: Colors.grey,

                                                    fontWeight: FontWeight.w600,

                                                    fontSize:
                                                        isTablet ? 22 : 18,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            const SizedBox(height: 14),

                                            Container(
                                              height: 3,
                                              color: Colors.grey.shade300,
                                            ),
                                          ],
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
                    ),

                    /// TITLE
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),

                        child: Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.activeServices,

                              style: TextStyle(
                                fontSize: isTablet ? 28 : 22,

                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            const Spacer(),

                            Text(
                              "View All",

                              style: TextStyle(
                                color: AppColors.primary,

                                fontWeight: FontWeight.w700,

                                fontSize: isTablet ? 18 : 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// GRID
                    /*  Expanded(
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),

                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),

                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isTablet ? 3 : 2,

                          mainAxisSpacing: 18,

                          crossAxisSpacing: 18,

                          childAspectRatio: isTablet ? 0.72 : 0.68,
                        ),

                        itemCount: provider.services.length,

                        itemBuilder: (context, index) {
                          final service = provider.services[index];

                          final imageUrl =
                              service.serviceImages.isNotEmpty
                                  ? "${ApiConstants.imageBaseUrl}${service.serviceImages.first}"
                                  : "";

                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(24),

                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 18,
                                  offset: const Offset(0, 8),

                                  color: Colors.black.withValues(alpha: 0.05),
                                ),
                              ],
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                /// IMAGE
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(24),
                                      ),

                                      child: CachedNetworkImage(
                                        imageUrl: imageUrl,

                                        height: isTablet ? 190 : 130,

                                        width: double.infinity,

                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    Positioned(
                                      top: 10,
                                      left: 10,

                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),

                                        decoration: BoxDecoration(
                                          color: const Color(0xffFFD500),

                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                        ),

                                        child: const Text(
                                          "Fixed price",

                                          style: TextStyle(
                                            fontSize: 11,

                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(14),

                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [
                                        /// TITLE
                                        Text(
                                          service.serviceTitle,

                                          maxLines: 2,

                                          overflow: TextOverflow.ellipsis,

                                          style: TextStyle(
                                            fontSize: isTablet ? 20 : 16,

                                            height: 1.2,

                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),

                                        const Spacer(),

                                        /// PRICE + TIME
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10,

                                                    vertical: 6,
                                                  ),

                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade100,

                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),

                                              child: Text(
                                                "CFA ${service.price}",

                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),

                                            const Spacer(),

                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10,

                                                    vertical: 6,
                                                  ),

                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey.shade300,
                                                ),

                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),

                                              child: Text(
                                                service.duration,

                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 14),

                                        /// BUTTON
                                        Container(
                                          height: isTablet ? 58 : 50,

                                          decoration: BoxDecoration(
                                            color: AppColors.primary,

                                            borderRadius: BorderRadius.circular(
                                              18,
                                            ),
                                          ),

                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,

                                            children: [
                                              Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!.bookNow,

                                                style: TextStyle(
                                                  color: Colors.white,

                                                  fontWeight: FontWeight.w700,

                                                  fontSize: isTablet ? 22 : 16,
                                                ),
                                              ),

                                              const SizedBox(width: 10),

                                              Container(
                                                width: 30,

                                                height: 30,

                                                decoration: const BoxDecoration(
                                                  color: Colors.white,

                                                  shape: BoxShape.circle,
                                                ),

                                                child: Icon(
                                                  Icons.arrow_outward_rounded,

                                                  size: 18,

                                                  color: AppColors.primary,
                                                ),
                                              ),
                                            ],
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
                      ),
                    ),*/
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),

                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final service = provider.services[index];

                          final imageUrl =
                              service.serviceImages.isNotEmpty
                                  ? "${ApiConstants.imageBaseUrl}${service.serviceImages.first}"
                                  : "";

                          return ServiceCard(
                            service: service,
                            imageUrl: imageUrl,
                            isTablet: isTablet,
                          );
                        }, childCount: provider.services.length),

                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isTablet ? 3 : 2,

                          mainAxisSpacing: isTablet ? 22 : 16,

                          crossAxisSpacing: isTablet ? 22 : 16,

                          childAspectRatio:
                              isTablet
                                  ? 0.68
                                  : size.width < 380
                                  ? 0.60
                                  : 0.64,
                        ),
                      ),
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
