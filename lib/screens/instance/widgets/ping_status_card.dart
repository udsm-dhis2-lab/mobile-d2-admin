import 'package:flutter/material.dart';

import '/config/theme_config.dart';

class PingStatusCard extends StatelessWidget {
  final String pingStatusCode;
  const PingStatusCard({
    super.key,
    required this.pingStatusCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 0.3, color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _pingStatus(pingStatusCode),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: AppColors.onSurfaceColor),
              ),
              CircleAvatar(
                backgroundColor: pingStatusCode == '200'
                    ? AppColors.successColor
                    : AppColors.errorColor,
                radius: 8,
              )
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Jul 01, 2022. 13:40 08Hrs',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: AppColors.textMuted),
              ),
              Text(
                '4Hrs',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: AppColors.textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _pingStatus(String pingStatusCode) {
    if (pingStatusCode == '200') {
      return 'Online';
    } else if (pingStatusCode == '502') {
      return 'Bad Gateway (502)';
    }
    return pingStatusCode;
  }
}
