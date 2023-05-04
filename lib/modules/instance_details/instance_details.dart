import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/instances.dart';
import '/config/theme_config.dart';
import 'widgets/index.dart';
import '/database/repository.dart';
import '/models/instances_ping_statuses.dart';
import '../add_instance/add_instance_screen.dart';
import '/core/ping/ping_instance.dart';

enum MenuActions {
  edit,
  ping,
  delete,
}

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
  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository>(context, listen: false);
    return Scaffold(
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
        actions: [
          buildMenuButton(
            repository,
          )
        ],
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
          child: _buildInstanceDetailScreen(
            context,
            widget.instance.id!,
            widget.instance.instanceUrl,
          )),
    );
  }

  Widget buildMenuButton(Repository repository) {
    return PopupMenuButton(
      onSelected: ((value) async {
        switch (value) {
          case MenuActions.edit:
            {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => AddInstanceScreen(
                        instance: widget.instance,
                      )),
                ),
              );
              if (!mounted) return;
              Navigator.pop(context);
            }
            break;
          case MenuActions.ping:
            {
              final ping = PingInstance(repository: repository);
              ping.pingInstance(widget.instance);
              setState(() {});
            }
            break;

          case MenuActions.delete:
            {
              repository.removeInstance(widget.instance);
              Navigator.pop(context);
            }
        }
      }),
      itemBuilder: ((context) {
        return <PopupMenuEntry>[
          PopupMenuItem(
            value: MenuActions.edit,
            child: Text(
              'Edit instance',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.onSurfaceColor, fontWeight: FontWeight.w100),
            ),
          ),
          PopupMenuItem(
            value: MenuActions.ping,
            child: Text(
              'Ping instance',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.onSurfaceColor, fontWeight: FontWeight.w100),
            ),
          ),
          PopupMenuItem(
            value: MenuActions.delete,
            child: Text(
              'Delete instance',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.onSurfaceColor, fontWeight: FontWeight.w100),
            ),
          )
        ];
      }),
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

  Widget _buildInstanceDetailScreen(
      BuildContext context, int instanceId, String instanceUrl) {
    final repository = Provider.of<Repository>(context, listen: true);

    return FutureBuilder(
      future: repository.getInstancesPingStatusByInstanceId(instanceId),
      builder: ((context, AsyncSnapshot<List<InstancesPingStatus>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final statuses = snapshot.data ?? [];

            // find the current status
            statuses.sort(((a, b) => a.pingTime.compareTo(b.pingTime)));
            final latestStatus = statuses.last;

            final latestPingStatusCode = latestStatus.statusCode;

            // reverse the list
            final reversedStatuses = statuses.reversed.toList();

            return Column(
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
                InstanceCurrentStateCard(
                  pingStatusCode: latestPingStatusCode,
                ),
                const SizedBox(height: 24),
                InstanceDataAdministrationCard(instanceUrl: instanceUrl),
                const SizedBox(height: 32),
                buildListHeader(context),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: reversedStatuses.length,
                    itemBuilder: ((context, index) {
                      final status = reversedStatuses[index];
                      return InstancePingStatusCard(
                        status: status,
                      );
                    }),
                    separatorBuilder: ((context, index) {
                      return const SizedBox(
                        height: 14,
                      );
                    }),
                  ),
                ),
              ],
            );
          }
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return const Center(child: Text('No Data'));
      }),
    );
  }
}
