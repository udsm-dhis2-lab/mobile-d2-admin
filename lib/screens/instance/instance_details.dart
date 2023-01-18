import 'package:flutter/material.dart';

import '../../models/instances.dart';
import '/config/theme_config.dart';
import 'widgets/index.dart';

class InstanceDetails extends StatelessWidget {
  final Instance instance;
  const InstanceDetails({
    super.key,
    required this.instance,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColors.primaryColor,
          title: Text(
            'Instance details',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColors.onPrimaryColor,
                ),
          ),
        ),
        body: Container(
            padding:
                const EdgeInsets.only(left: 19, right: 19, top: 24, bottom: 24),
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.surfaceColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Ping',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.textMuted,
                          ),
                    ),
                    Text(
                      'https://www.google.com',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.textMuted,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const InstanceCurrentState(),
                const SizedBox(height: 24),
                const DataAdministrationCard(),
                const SizedBox(height: 32),
                Expanded(
                  child: ListView(
                    children: [
                      buildListHeader(context),
                      const SizedBox(height: 16),
                      buildPingStatusesCard(
                          context: context,
                          pingStatus: 'Online',
                          pingStatusCode: '200'),
                      const SizedBox(height: 14),
                      buildPingStatusesCard(
                          context: context,
                          pingStatus: 'Outage occured',
                          pingStatusCode: '299'),
                      const SizedBox(height: 14),
                      buildPingStatusesCard(
                          context: context,
                          pingStatus: 'Bad Gate Way',
                          pingStatusCode: '288'),
                      const SizedBox(height: 14),
                      buildPingStatusesCard(
                          context: context,
                          pingStatus: 'Online',
                          pingStatusCode: '200'),
                      const SizedBox(height: 14),
                      buildPingStatusesCard(
                          context: context,
                          pingStatus: 'Online',
                          pingStatusCode: '200'),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget buildListHeader(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              height: 30,
              color: AppColors.onSurfaceColor,
            ),
          ),
        ),
        Text(
          'Recent Alerts',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: AppColors.onSurfaceColor),
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              height: 30,
              color: AppColors.onSurfaceColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPingStatusesCard({
    required BuildContext context,
    required String pingStatus,
    required String pingStatusCode,
  }) {
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
                pingStatus,
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
}
