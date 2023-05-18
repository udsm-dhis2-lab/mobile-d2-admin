import 'package:flutter/material.dart';
import 'package:mobile_d2_admin/config/theme_config.dart';

class TaskProgress extends StatelessWidget {
  final String time;
  final String message;
  const TaskProgress({
    super.key,
    required this.time,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                maxLines: 2,
                overflow: TextOverflow.clip,
              ),
              Text(
                time,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: AppColors.textMuted),
                maxLines: 2,
                overflow: TextOverflow.clip,
              ),
            ],
          ),
        ),
        const Icon(
          Icons.check,
          color: AppColors.successColor,
          size: 16,
        ),
      ],
    );
  }
}
