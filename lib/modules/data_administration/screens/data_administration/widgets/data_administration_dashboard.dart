import 'package:flutter/material.dart';

import '../../../../../config/theme_config.dart';
import '../../../../../constants/assets_path.dart';

class DataAdministrationDashBoard extends StatelessWidget {
  const DataAdministrationDashBoard({super.key});

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
              buildRowOfStatsInDashBoard('Version', '2.36.6', context),
              const SizedBox(height: 14),
              buildRowOfStatsInDashBoard(
                  'Last Analytics', 'July 24, 2022, 01:00', context),
              const SizedBox(height: 14),
              buildRowOfStatsInDashBoard('Runtime', '01:54:22.125', context),
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
