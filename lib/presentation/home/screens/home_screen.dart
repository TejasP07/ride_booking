import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:task_tejas/generated/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/api/api_constants.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/text_theme.dart';
import '../../../routes/route_names.dart';
import '../../auth/provider/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authProvider = context.watch<AuthProvider>();

    final user = authProvider.currentUser;
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            /// HEADER
            _buildHeader(context, user?.fullName ?? "", user?.profilePhoto),

            const SizedBox(height: 26),

            /// HERO CARD
            _buildHeroCard(context),

            const SizedBox(height: 30),

            /// QUICK ACTIONS
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.screenPadding,
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    AppLocalizations.of(context)!.quickActions,

                    style: AppTextTheme.headingMedium,
                  ),

                  Text(
                    "Explore",

                    style: TextStyle(
                      color: AppColors.primary,

                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            /// ACTION GRID
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.screenPadding,
              ),

              child: GridView.count(
                crossAxisCount: 2,

                shrinkWrap: true,

                physics: const NeverScrollableScrollPhysics(),

                crossAxisSpacing: 16,

                mainAxisSpacing: 16,

                childAspectRatio: 1.04,

                children: [
                  _actionCard(
                    context: context,

                    icon: Icons.directions_car,

                    title: AppLocalizations.of(context)!.vehicles,

                    subtitle: "Manage your vehicles",

                    colors: [const Color(0xff0057FF), const Color(0xff5B8CFF)],

                    onTap: () {
                      context.push(RouteNames.vehicles);
                    },
                  ),

                  _actionCard(
                    context: context,

                    icon: Icons.miscellaneous_services_rounded,

                    title: AppLocalizations.of(context)!.services,

                    subtitle: "Explore services",

                    colors: [const Color(0xff00A86B), const Color(0xff54D2A0)],

                    onTap: () {
                      context.push(RouteNames.services);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            /// RECENT SERVICES
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.screenPadding,
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text("Popular Services", style: AppTextTheme.headingMedium),

                  GestureDetector(
                    onTap: () {
                      context.push(RouteNames.services);
                    },

                    child: Text(
                      "View All",

                      style: TextStyle(
                        color: AppColors.primary,

                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            SizedBox(
              height: 210,

              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.screenPadding,
                ),

                scrollDirection: Axis.horizontal,

                itemCount: 4,

                separatorBuilder: (_, __) => const SizedBox(width: 16),

                itemBuilder: (_, index) {
                  return _servicePreviewCard();
                },
              ),
            ),

            const SizedBox(height: 34),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String name, profilePhoto) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 28),

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,

          end: Alignment.bottomRight,

          colors: [Color(0xff003CFF), Color(0xff7FA2FF)],
        ),

        borderRadius: BorderRadius.vertical(bottom: Radius.circular(34)),
      ),

      child: SafeArea(
        bottom: false,

        child: Row(
          children: [
            CircleAvatar(
              radius: 28,

              backgroundColor: Colors.white,

              backgroundImage:
                  (profilePhoto != null && profilePhoto.isNotEmpty)
                      ? NetworkImage(
                        "${ApiConstants.imageBaseUrl}${profilePhoto}",
                      )
                      : null,

              child:
                  (profilePhoto == null || profilePhoto.isEmpty)
                      ? Icon(Icons.person, color: AppColors.primary)
                      : null,
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    AppLocalizations.of(context)!.welcome,

                    style: const TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    name ?? "",
                    maxLines: 1,

                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      color: Colors.white,

                      fontSize: 20,

                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: 52,
              height: 52,

              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),

                shape: BoxShape.circle,
              ),

              child: const Icon(Icons.notifications_none, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),

      child: Container(
        width: double.infinity,

        padding: const EdgeInsets.all(24),

        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,

            end: Alignment.bottomRight,

            colors: [Color(0xff101010), Color(0xff2B2B2B)],
          ),

          borderRadius: BorderRadius.circular(30),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),

                borderRadius: BorderRadius.circular(100),
              ),

              child: const Text(
                "Premium Services",

                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              AppLocalizations.of(context)!.smartVehicle,

              style: const TextStyle(
                color: Colors.white,

                fontSize: 25,

                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              AppLocalizations.of(context)!.manageServices,

              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),

            const SizedBox(height: 22),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

              decoration: BoxDecoration(
                color: AppColors.primary,

                borderRadius: BorderRadius.circular(16),
              ),

              child: const Text(
                "Book Service",

                style: TextStyle(
                  color: Colors.white,

                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionCard({
    required BuildContext context,

    required IconData icon,

    required String title,

    required String subtitle,

    required List<Color> colors,

    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),

          borderRadius: BorderRadius.circular(28),

          boxShadow: [
            BoxShadow(
              blurRadius: 18,

              offset: const Offset(0, 10),

              color: colors.first.withValues(alpha: 0.24),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              width: 54,
              height: 54,

              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.16),

                borderRadius: BorderRadius.circular(18),
              ),

              child: Icon(icon, color: Colors.white, size: 28),
            ),

            const Spacer(),

            Text(
              title,

              style: const TextStyle(
                color: Colors.white,

                fontSize: 16,

                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              subtitle,
              style: const TextStyle(fontSize: 13, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _servicePreviewCard() {
    return Container(
      width: 180,

      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(24),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            height: 100,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,

              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Text(
                  "Car Wash",

                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),

                const SizedBox(height: 1),

                Text(
                  "Premium exterior cleaning",

                  style: TextStyle(color: Colors.grey.shade600),
                ),

                const SizedBox(height: 1),

                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 18),

                    const SizedBox(width: 4),

                    const Text("4.9"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
