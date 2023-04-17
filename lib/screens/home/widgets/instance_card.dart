import 'package:flutter/material.dart';
import 'package:mobile_d2_admin/config/theme_config.dart';

class InstanceCard extends StatelessWidget {
  final String instanceName;
  final String instanceStatusCode;
  const InstanceCard({
    super.key,
    required this.instanceName,
    required this.instanceStatusCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(
        height: 49,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceColor,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: AppColors.outlineColor,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            instanceName,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: AppColors.onSurfaceColor),
          ),
          CircleAvatar(
            backgroundColor: instanceStatusCode == '200'
                ? AppColors.successColor
                : AppColors.errorColor,
            radius: 8,
          )
        ],
      ),
    );
  }
}
