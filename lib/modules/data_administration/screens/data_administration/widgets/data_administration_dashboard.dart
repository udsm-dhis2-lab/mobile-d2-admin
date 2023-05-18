import 'package:flutter/material.dart';

import '../../../../../config/theme_config.dart';
import '../../../../../constants/assets_path.dart';

class DataAdministrationDashBoard extends StatelessWidget {
  final String version;
  final String lastAnalytics;
  final String runtime;
  const DataAdministrationDashBoard({
    super.key,
    required this.lastAnalytics,
    required this.runtime,
    required this.version,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      padding: const EdgeInsets.only(left: 18, top: 11, bottom: 11, right: 18),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(AssetsPath.logo),
          const SizedBox(width: 32),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildRowOfStatsInDashBoard('Version', version, context),
              const SizedBox(height: 14),
              buildRowOfStatsInDashBoard(
                  'Last Analytics', lastAnalytics, context),
              const SizedBox(height: 14),
              buildRowOfStatsInDashBoard('Runtime', runtime, context),
            ],
          )
        ],
      ),
    );
  }

  buildRowOfStatsInDashBoard(String label, String value, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: AppColors.appDarkGreyColor,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 7),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: AppColors.textMuted),
        )
      ],
    );
  }
}
