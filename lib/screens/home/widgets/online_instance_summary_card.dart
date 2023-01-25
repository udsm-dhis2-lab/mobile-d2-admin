import 'package:flutter/material.dart';
import 'package:mobile_d2_admin/config/theme_config.dart';

class OnlineInstanceSummaryCard extends StatelessWidget {
  final double width;
  final double height;
  final int onlineInstances;
  final int totalInstances;
  const OnlineInstanceSummaryCard(
      {super.key,
      required this.width,
      required this.height,
      required this.onlineInstances,
      required this.totalInstances});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        constraints: BoxConstraints.expand(
          width: width,
          height: height,
        ),
        padding:
            const EdgeInsets.only(top: 11, bottom: 12, left: 12, right: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Online \nInstances',
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: AppColors.appBlackColor),
                ),
                Text(
                  '$onlineInstances',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: AppColors.appBlackColor),
                )
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value:
                  (totalInstances == 0 ? 0 : onlineInstances / totalInstances),
              color: AppColors.progressIndicatorColor,
              backgroundColor: AppColors.secondaryColor,
            ),
            const SizedBox(height: 9),
            Text(
              '$onlineInstances / $totalInstances Active dhis instances',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: AppColors.textMuted),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 25,
                  width: 67,
                  child: MaterialButton(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: AppColors.secondaryColor,
                      onPressed: () {},
                      child: Text(
                        'View',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: AppColors.onSecondaryColor),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
