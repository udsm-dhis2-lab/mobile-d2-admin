import 'package:flutter/material.dart';

import '/config/theme_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double heightOfWelcomeCard = 60;
  final double heightOfOnlineInstancesSummaryCard = 152;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double topPadding = size.height * 0.08;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
          ),
          Container(
            color: AppColors.primaryColor,
            height: size.height * 0.3,
          ),
          Positioned.fill(
            top: topPadding,
            child: Align(
              alignment: Alignment.topCenter,
              child: buildWelcomeBackCard(
                  'Yusuf', 'Welcome back Admin', context, size),
            ),
          ),
          Positioned.fill(
            top: 1.5 * topPadding + heightOfWelcomeCard,
            child: Align(
              alignment: Alignment.topCenter,
              child: buildOnlineInstancesSummaryCard(13, 20, context, size),
            ),
          )
        ],
      ),
    );
  }

  Widget buildWelcomeBackCard(
    String userName,
    String welcomingWords,
    BuildContext context,
    Size size,
  ) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primaryContainerColor,
          borderRadius: BorderRadius.circular(6)),
      constraints: BoxConstraints.expand(
        width: size.width * 0.9,
        height: heightOfWelcomeCard,
      ),
      padding: EdgeInsets.only(left: size.width * 0.15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hi, $userName',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: AppColors.onPrimaryContainerColor),
          ),
          Text(
            welcomingWords,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.onPrimaryContainerColor,
                fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }

  Widget buildOnlineInstancesSummaryCard(
    int onlineInstances,
    int totalInstances,
    BuildContext context,
    Size size,
  ) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        constraints: BoxConstraints.expand(
          width: size.width * 0.9,
          height: heightOfOnlineInstancesSummaryCard,
        ),
        padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
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
                      .copyWith(color: AppColors.onSurfaceColor),
                ),
                Text(
                  '$onlineInstances',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: AppColors.onSurfaceColor),
                )
              ],
            ),
            const SizedBox(height: 14),
            LinearProgressIndicator(
              value: (onlineInstances / totalInstances),
              color: AppColors.primaryColor,
            ),
            const SizedBox(height: 10),
            Text(
              '$onlineInstances / $totalInstances Active dhis instances',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: AppColors.textMuted),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'View',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: AppColors.primaryColor),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
