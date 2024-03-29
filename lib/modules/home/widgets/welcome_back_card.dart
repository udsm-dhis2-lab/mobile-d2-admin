import 'package:flutter/material.dart';

import 'package:mobile_d2_admin/config/theme_config.dart';
import 'package:mobile_d2_admin/constants/assets_path.dart';

class WelcomeBackCard extends StatelessWidget {
  final double width;
  final double height;
  final String userName;
  final String welcomingWords;
  const WelcomeBackCard({
    super.key,
    required this.width,
    required this.height,
    required this.userName,
    required this.welcomingWords,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primaryContainerColor,
          borderRadius: BorderRadius.circular(6)),
      constraints: BoxConstraints.expand(
        width: width,
        height: height,
      ),
      padding: EdgeInsets.only(left: width * 0.02),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(AssetsPath.person),
          ),
          const SizedBox(width: 16),
          Column(
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
        ],
      ),
    );
  }
}
