import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../generated/l10n/app_localizations.dart';

class ServiceCard extends StatelessWidget {
  final dynamic service;

  final String imageUrl;

  final bool isTablet;

  const ServiceCard({
    required this.service,

    required this.imageUrl,

    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 8),

            color: Colors.black.withValues(alpha: 0.09),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          /// IMAGE
          AspectRatio(
            aspectRatio: isTablet ? 1.4 : 1.4,

            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),

                  child: CachedNetworkImage(
                    imageUrl: imageUrl,

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

                      borderRadius: BorderRadius.circular(40),
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
          ),

          /// CONTENT
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 16 : 12),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    service.serviceTitle,

                    maxLines: 2,

                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(
                      fontSize: isTablet ? 19 : 16,

                      height: 1.2,

                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// META
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,

                            borderRadius: BorderRadius.circular(30),
                          ),

                          child: FittedBox(
                            fit: BoxFit.scaleDown,

                            child: Text(
                              "CFA ${service.price}",

                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),

                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),

                            borderRadius: BorderRadius.circular(30),
                          ),

                          child: FittedBox(
                            fit: BoxFit.scaleDown,

                            child: Text(
                              service.duration,

                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// BUTTON
                  Container(
                    // height: isTablet ? 56 : 48,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.primary.withValues(alpha: 0.82),
                        ],
                      ),

                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        Text(
                          AppLocalizations.of(context)!.bookNow,

                          style: TextStyle(
                            color: Colors.white,

                            fontWeight: FontWeight.w700,

                            fontSize: isTablet ? 16 : 14,
                          ),
                        ),

                        Container(
                          width: 28,

                          height: 28,

                          decoration: const BoxDecoration(
                            color: Colors.white,

                            shape: BoxShape.circle,
                          ),

                          child: Icon(
                            Icons.arrow_outward_rounded,

                            size: 16,

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
  }
}
