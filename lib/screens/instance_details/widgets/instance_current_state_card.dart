import 'package:flutter/material.dart';

import '/config/theme_config.dart';

class InstanceCurrentStateCard extends StatelessWidget {
  final String pingStatusCode;
  const InstanceCurrentStateCard({
    super.key,
    required this.pingStatusCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18, top: 10, bottom: 10),
      height: 71,
      decoration: BoxDecoration(
        color: pingStatusCode == '200'
            ? AppColors.successContainerColor
            : AppColors.errorContainerColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: pingStatusCode == '200'
                ? AppColors.successColor
                : AppColors.errorColor,
          ),
          const SizedBox(width: 25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                pingStatusCode == '200' ? 'Good Job' : 'Poor Progress',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.onSuccessContainerColor),
              ),
              Text(
                pingStatusCode == '200'
                    ? 'Your instance is up'
                    : 'Your instance is down',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.onSuccessContainerColor,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
