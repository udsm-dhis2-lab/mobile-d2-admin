import 'package:d2_touch/d2_touch.dart';
import 'package:flutter/material.dart';

import 'package:mobile_d2_admin/constants/assets_path.dart';
import 'package:mobile_d2_admin/modules/data_administration/screens/analytics/analytics.dart';
import 'package:mobile_d2_admin/modules/data_administration/screens/data_administration/widgets/data_administration_dashboard.dart';
import 'package:mobile_d2_admin/modules/data_administration/screens/data_administration/widgets/operation_card.dart';
import 'package:mobile_d2_admin/modules/data_administration/screens/maintenance/maintenance.dart';
import 'package:mobile_d2_admin/modules/data_administration/screens/resource/resource.dart';
import 'package:mobile_d2_admin/utils/services/rest_apis/data_administration_api.dart';
import '../../../../config/theme_config.dart';
import 'package:mobile_d2_admin/constants/app_constants.dart';

class DataAdministration extends StatefulWidget {
  const DataAdministration({super.key});

  @override
  State<DataAdministration> createState() => _DataAdministrationState();
}

class _DataAdministrationState extends State<DataAdministration> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await d2repository.authModule.logOut();
        await d2repository.dispose();
        d2repository = await D2Touch.init();

        return true;
      },
      child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () async {
                  await d2repository.authModule.logOut();
                  await d2repository.dispose();
                  d2repository = await D2Touch.init();

                  if (!mounted) {}
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            elevation: 0.0,
            backgroundColor: AppColors.primaryColor,
            title: Text(
              'Data Administration',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColors.onPrimaryColor,
                  ),
            ),
          ),
          body: FutureBuilder(
              future: DataAdministrationApi.getInstanceInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  final instanceInfo = snapshot.data;
                  return buildBodyContents(
                    version: instanceInfo!['version']!,
                    lastAnalytics: instanceInfo['lastAnalytics']!,
                    runtime: instanceInfo['runTime']!,
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.onPrimaryColor,
                    ),
                  );
                }
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                    style: const TextStyle(color: AppColors.onPrimaryColor),
                  ),
                );
              })),
    );
  }

  Widget buildBodyContents({
    required String version,
    required String lastAnalytics,
    required String runtime,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 19, right: 19, top: 24, bottom: 24),
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.appGreyColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DataAdministrationDashBoard(
            version: version,
            lastAnalytics: lastAnalytics,
            runtime: runtime,
          ),
          const SizedBox(height: 24),
          buildOperationCardList(context)
        ],
      ),
    );
  }

  Widget buildOperationCardList(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      primary: false,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 22,
        mainAxisSpacing: 22,
      ),
      children: const [
        OperationCard(
          imageUrl: AssetsPath.maintainance,
          label: 'Maintenance',
          screen: Maintenance(),
        ),
        // OperationCard(
        //   imageUrl: AssetsPath.schedule,
        //   label: 'Scheduler',
        //   screen: Maintainance(),
        // ),
        OperationCard(
          imageUrl: AssetsPath.resources,
          label: 'Resource',
          screen: Resource(),
        ),
        OperationCard(
          imageUrl: AssetsPath.analytics,
          label: 'Analytics',
          screen: Analytics(),
        ),
      ],
    );
  }
}
