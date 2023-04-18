import 'package:flutter/material.dart';
import 'package:mobile_d2_admin/models/index.dart';
import 'package:provider/provider.dart';

import '/config/theme_config.dart';
import 'widgets/index.dart';
import '/database/repository.dart';
import '/widgets/custom_material_button.dart';
import '../add_instance/add_instance_screen.dart';
import '../instance_details/instance_details.dart';

class InstanceCardModel {
  final int instanceId;
  final String instanceName;
  final String instanceUrl;
  final String instanceStatusCode;

  InstanceCardModel(
      {required this.instanceName,
      required this.instanceStatusCode,
      required this.instanceId,
      required this.instanceUrl});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static double heightOfWelcomeCard = 60;
  static double heightOfOnlineInstancesSummaryCard = 138;
  static double heightOfAddInstanceButton = 44;
  static double heightOfTopElements = heightOfWelcomeCard +
      heightOfOnlineInstancesSummaryCard +
      heightOfAddInstanceButton;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double topPadding = size.height * 0.08;
    double elementsWidth = size.width * 0.9;

    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: _buildHome(
          context,
          size,
          topPadding,
          elementsWidth,
        ));
  }

  Widget _buildHome(
    BuildContext context,
    Size size,
    double topPadding,
    double elementsWidth,
  ) {
    final repository = Provider.of<Repository>(context, listen: true);
    return StreamBuilder<List<InstancesPingStatus>>(
      // listen to the stream of ping statuses
      stream: repository.watchAllInstancePingStatuses(),
      builder: ((context, AsyncSnapshot<List<InstancesPingStatus>> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final statuses = snapshot.data ?? [];
          // get all instances
          return FutureBuilder(
            future: repository.getAllInstances(),
            builder: ((context, snapshot) {
              if (snapshot.hasData && statuses.isNotEmpty) {
                final instances = snapshot.data ?? [];
                final int totalInstances = instances.length;
                int onlineInstances = 0;
                final instanceCards = <InstanceCardModel>[];

                // find the latest ping status of each instance
                for (var instance in instances) {
                  //  find all ping statuses of this instance
                  final thisInstanceStatuses = <InstancesPingStatus>[];
                  for (var status in statuses) {
                    status.instanceId == instance.id
                        ? thisInstanceStatuses.add(status)
                        : [];
                  }

                  if (thisInstanceStatuses.isNotEmpty) {
                    // sort the list of statuses according to date
                    thisInstanceStatuses
                        .sort(((a, b) => a.pingTime.compareTo(b.pingTime)));
                    // get the latest status
                    final currentStatus = thisInstanceStatuses.last;

                    // check if it is online and add increment the number of online instances
                    currentStatus.statusCode == '200'
                        ? onlineInstances++
                        : null;

                    // add both instance and the status code to instance card model
                    instanceCards.add(InstanceCardModel(
                        instanceId: instance.id!,
                        instanceUrl: instance.instanceUrl,
                        instanceName: instance.instanceName,
                        instanceStatusCode: currentStatus.statusCode));
                  }
                }

                return buildHomeContents(
                  context: context,
                  size: size,
                  topPadding: topPadding,
                  elementsWidth: elementsWidth,
                  instanceCards: instanceCards,
                  onlineInstances: onlineInstances,
                  totalInstances: totalInstances,
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return buildHomeContents(
                context: context,
                size: size,
                topPadding: topPadding,
                elementsWidth: elementsWidth,
                instanceCards: [],
                onlineInstances: 0,
                totalInstances: 0,
              );
            }),
          );
        }
        return Container();
      }),
    );
  }

  Widget buildHomeContents(
      {required BuildContext context,
      required Size size,
      required double topPadding,
      required double elementsWidth,
      required List<InstanceCardModel> instanceCards,
      required int totalInstances,
      required int onlineInstances}) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
        ),
        Container(
          color: AppColors.primaryColor,
          height: size.height * 0.3,
        ),
        Positioned.fill(
          top: topPadding,
          child: Align(
            alignment: Alignment.topCenter,
            child: WelcomeBackCard(
              userName: 'Yusuf',
              welcomingWords: 'Welcome back admin',
              height: heightOfWelcomeCard,
              width: elementsWidth,
            ),
          ),
        ),
        Positioned.fill(
          top: 1.5 * topPadding + heightOfWelcomeCard,
          child: Align(
            alignment: Alignment.topCenter,
            child: OnlineInstanceSummaryCard(
              width: elementsWidth,
              height: heightOfOnlineInstancesSummaryCard,
              onlineInstances: onlineInstances,
              totalInstances: totalInstances,
            ),
          ),
        ),
        Positioned.fill(
          top: 1.9 * topPadding +
              heightOfWelcomeCard +
              heightOfOnlineInstancesSummaryCard,
          child: Align(
            alignment: Alignment.topCenter,
            child: CustomMaterialButton(
              label: 'Add Instance',
              height: heightOfAddInstanceButton,
              size: size,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const AddInstanceScreen()),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned.fill(
            top: 2.4 * topPadding + heightOfTopElements,
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: size.width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildListHeader(),
                    Expanded(
                      child: buildInstanceList(instanceCards),
                    ),
                  ],
                ),
              ),
            ))
      ],
    );
  }

  Widget buildListHeader() {
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
            'Instance',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: AppColors.textMuted),
          ),
          Text(
            'Code',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }

  Widget buildInstanceList(List<InstanceCardModel> instanceCards) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: instanceCards.length,
      itemBuilder: ((context, index) {
        final card = instanceCards[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => InstanceDetails(
                      instance: Instance(
                        id: card.instanceId,
                        instanceName: card.instanceName,
                        instanceUrl: card.instanceUrl,
                      ),
                    )),
              ),
            );
          },
          child: InstanceCard(
              instanceName: card.instanceName,
              instanceStatusCode: card.instanceStatusCode),
        );
      }),
    );
  }
}
