import 'package:flutter/material.dart';

import 'package:task_tejas/generated/l10n/app_localizations.dart';

import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

import '../../../core/api/api_constants.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

import '../../../core/services/localization_service.dart';
import '../../../core/services/secure_storage_service.dart';

import '../../../routes/route_names.dart';

import '../../auth/provider/auth_provider.dart';
import '../provider/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    final settingsProvider = context.watch<SettingsProvider>();

    final localizationService = settingsProvider.localizationService;

    final user = authProvider.currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        elevation: 0,

        backgroundColor: Colors.transparent,

        title: Text(AppLocalizations.of(context)!.settings),
      ),

      body: Padding(
        padding: const EdgeInsets.all(AppSizes.screenPadding),

        child: Column(
          children: [
            /// PROFILE CARD
            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(24),

                boxShadow: [
                  BoxShadow(
                    blurRadius: 12,

                    offset: const Offset(0, 4),

                    color: Colors.black.withValues(alpha: 0.04),
                  ),
                ],
              ),

              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,

                    backgroundColor: Colors.white,

                    backgroundImage:
                        (user?.profilePhoto != null &&
                                user!.profilePhoto!.isNotEmpty)
                            ? NetworkImage(
                              "${ApiConstants.imageBaseUrl}${user.profilePhoto}",
                            )
                            : null,

                    child:
                        (user?.profilePhoto == null ||
                                user!.profilePhoto!.isEmpty)
                            ? CircleAvatar(
                              radius: 30,

                              backgroundColor: AppColors.primary,

                              child: Text(
                                user?.fullName.substring(0, 1).toUpperCase() ??
                                    'G',

                                style: const TextStyle(
                                  color: Colors.white,

                                  fontSize: 22,

                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                            : null,
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          user?.fullName ?? 'Guest',

                          style: const TextStyle(
                            fontSize: 18,

                            fontWeight: FontWeight.w700,

                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          user?.email ?? user?.mobile ?? '',

                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            /// LANGUAGE
            _settingTile(
              context: context,

              icon: Icons.language,

              title: AppLocalizations.of(context)!.language,

              subtitle:
                  localizationService.locale.languageCode == 'ar'
                      ? 'Arabic'
                      : 'English',

              onTap: () {
                _showLanguageBottomSheet(context);
              },
            ),

            const SizedBox(height: 14),

            /// LOGOUT
            _settingTile(
              context: context,

              icon: Icons.logout,

              title: AppLocalizations.of(context)!.logout,

              iconColor: Colors.red,

              textColor: Colors.red,

              onTap: () async {
                final storage = SecureStorageService();

                await settingsProvider.logout();

                if (!context.mounted) {
                  return;
                }

                context.go(RouteNames.login);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingTile({
    required BuildContext context,

    required IconData icon,

    required String title,

    String? subtitle,

    Color? iconColor,

    Color? textColor,

    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),

      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(18),
        ),

        child: Row(
          children: [
            Icon(icon, color: iconColor ?? AppColors.primary),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    title,

                    style: TextStyle(
                      fontSize: 16,

                      color: textColor,

                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),

                      child: Text(
                        subtitle,

                        style: TextStyle(
                          color: AppColors.textSecondary,

                          fontSize: 13,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    final settingsProvider = context.read<SettingsProvider>();

    final localizationService = settingsProvider.localizationService;

    showModalBottomSheet(
      context: context,

      backgroundColor: Colors.white,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),

      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              ListTile(
                title: const Text('English'),

                trailing:
                    localizationService.locale.languageCode == 'en'
                        ? const Icon(Icons.check)
                        : null,

                onTap: () async {
                  await settingsProvider.changeLanguage("en");

                  if (!context.mounted) {
                    return;
                  }

                  Navigator.pop(context);
                },
              ),

              ListTile(
                title: const Text('العربية'),

                trailing:
                    localizationService.locale.languageCode == 'ar'
                        ? const Icon(Icons.check)
                        : null,

                onTap: () async {
                  await settingsProvider.changeLanguage("ar");

                  if (!context.mounted) {
                    return;
                  }

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
