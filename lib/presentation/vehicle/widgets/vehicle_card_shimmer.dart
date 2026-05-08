import 'package:flutter/material.dart';

import '../../../core/widgets/shimmer_widget.dart';

class VehicleCardShimmer extends StatelessWidget {
  const VehicleCardShimmer({super.key});

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
            height: 90,

            width: 90,

            borderRadius: BorderRadius.all(Radius.circular(16)),
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

                const ShimmerWidget(
                  height: 14,

                  width: 120,

                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),

                const SizedBox(height: 10),

                const ShimmerWidget(
                  height: 14,

                  width: 90,

                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
