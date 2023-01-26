import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/models/index.dart';
import '/config/theme_config.dart';

class PingStatusCard extends StatelessWidget {
  final InstancesPingStatus status;
  const PingStatusCard({
    super.key,
    required this.status,
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
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    _pingStatus(status.statusCode),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: AppColors.onSurfaceColor),
                    maxLines: 1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CircleAvatar(
                  backgroundColor: status.statusCode == '200'
                      ? AppColors.successColor
                      : AppColors.errorColor,
                  radius: 8,
                ),
              )
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat.yMMMMEEEEd().add_jms().format(status.pingTime),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: AppColors.textMuted),
              ),
              Text(
                timeElapsedSincePing(status.pingTime),
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

  String timeElapsedSincePing(DateTime pingTime) {
    var now = DateTime.now();
    var difference = now.difference(pingTime);

    if (difference.inDays > 0) {
      return "${difference.inDays} Days";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} Hrs";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes} Minutes";
    } else {
      return "${difference.inSeconds} Sec";
    }
  }
}
