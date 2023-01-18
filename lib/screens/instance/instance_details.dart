import 'package:flutter/material.dart';

import '../../models/instances.dart';
import '/config/theme_config.dart';
import 'widgets/index.dart';

class InstanceDetails extends StatefulWidget {
  final Instance instance;
  const InstanceDetails({
    super.key,
    required this.instance,
  });

  @override
  State<InstanceDetails> createState() => _InstanceDetailsState();
}

class _InstanceDetailsState extends State<InstanceDetails> {
  final String latestPingStatusCode =
      ''; // This tells if instance is down or up
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColors.primaryColor,
          title: Text(
            widget.instance.instanceName,
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
                      widget.instance.instanceUrl,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.textMuted,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                InstanceCurrentState(
                  pingStatusCode: latestPingStatusCode,
                ),
                const SizedBox(height: 24),
                const DataAdministrationCard(),
                const SizedBox(height: 32),
                Expanded(
                  child: ListView(
                    children: [
                      buildListHeader(context),
                      const SizedBox(height: 16),
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
}
