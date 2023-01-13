import 'package:flutter/material.dart';
import 'package:mobile_d2_admin/models/instances_ping_statuses.dart';
import 'package:provider/provider.dart';

import '/config/theme_config.dart';
import 'widgets/index.dart';
import '/database/repository.dart';

class InstanceCardModel {
  final String instanceName;
  final String instanceStatusCode;

  InstanceCardModel({
    required this.instanceName,
    required this.instanceStatusCode,
  });
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
      body: Stack(
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
                onlineInstances: 13,
                totalInstances: 27,
              ),
            ),
          ),
          Positioned.fill(
            top: 1.9 * topPadding +
                heightOfWelcomeCard +
                heightOfOnlineInstancesSummaryCard,
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: size.width * 0.9,
                height: heightOfAddInstanceButton,
                child: MaterialButton(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: AppColors.primaryColor,
                    child: Text(
                      'Add Instance',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: AppColors.onPrimaryColor),
                    ),
                    onPressed: () {}),
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
                      _buildInstanceList(context),
                      // const InstanceCard(
                      //     instanceName: 'dhis', instanceStatusCode: '200'),
                      // const InstanceCard(
                      //     instanceName: 'Muhas', instanceStatusCode: '300'),
                      // const InstanceCard(
                      //     instanceName: 'Beta', instanceStatusCode: '200'),
                      // const InstanceCard(
                      //     instanceName: 'Test', instanceStatusCode: '200'),
                      // const InstanceCard(
                      //     instanceName: 'alpha', instanceStatusCode: '200'),
                      // const InstanceCard(
                      //     instanceName: 'UDSM', instanceStatusCode: '678'),
                      // const InstanceCard(
                      //     instanceName: 'Lab', instanceStatusCode: '200'),
                      // const InstanceCard(
                      //     instanceName: 'THTD', instanceStatusCode: '900'),
                      // const InstanceCard(
                      //     instanceName: 'Test2', instanceStatusCode: '200'),
                      // const InstanceCard(
                      //     instanceName: 'D2touch', instanceStatusCode: '200'),
                    ],
                  ),
                ),
              ))
        ],
      ),
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
            'Istance',
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

  Widget _buildInstanceList(BuildContext context) {
    final repository = Provider.of<Repository>(context, listen: false);
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
              if (snapshot.hasData) {
                final instances = snapshot.data ?? [];
                final instanceCards = <InstanceCardModel>[];
                for (var instance in instances) {
                  //  find the latest status of this instance
                  final thisInstanceStatuses = <InstancesPingStatus>[];
                  for (var status in statuses) {
                    status.instanceId == instance.id
                        ? thisInstanceStatuses.add(status)
                        : null;
                  }
                  // sort the list of statuses according to date
                  thisInstanceStatuses
                      .sort(((a, b) => a.pingTime.compareTo(b.pingTime)));
                  // get the latest status
                  final currentStatus = thisInstanceStatuses.last;

                  // add both instance and the status code to instance card model
                  instanceCards.add(InstanceCardModel(
                      instanceName: instance.instanceName,
                      instanceStatusCode: currentStatus.statusCode));
                }

                return ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                    itemCount: instanceCards.length,
                    itemBuilder: ((context, index) {
                      final card = instanceCards[index];
                      return InstanceCard(
                          instanceName: card.instanceName,
                          instanceStatusCode: card.instanceStatusCode);
                    }));
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return Container();
            }),
          );
        }
        return Container();
      }),
    );
  }
}
