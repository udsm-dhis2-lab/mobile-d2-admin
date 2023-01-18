import 'package:flutter/material.dart';

import '/config/theme_config.dart';

class InstanceCurrentState extends StatelessWidget {
  const InstanceCurrentState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18, top: 10, bottom: 10),
      height: 71,
      decoration: BoxDecoration(
        color: AppColors.successContainerColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: AppColors.successColor,
          ),
          const SizedBox(width: 25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Good Job',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.onSuccessContainerColor),
              ),
              Text(
                'Your instance is up',
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
