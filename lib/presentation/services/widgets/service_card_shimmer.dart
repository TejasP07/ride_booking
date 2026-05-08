import 'package:flutter/material.dart';

import '../../../core/widgets/shimmer_widget.dart';

class ServiceCardShimmer extends StatelessWidget {
  const ServiceCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        children: [
          const ShimmerWidget(
            height: 80,

            width: 80,

            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const ShimmerWidget(
                  height: 18,

                  width: double.infinity,

                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),

                const SizedBox(height: 14),

                ShimmerWidget(
                  height: 14,

                  width: MediaQuery.of(context).size.width * 0.3,

                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
