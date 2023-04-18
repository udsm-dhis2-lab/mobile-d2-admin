import 'package:flutter/material.dart';

import 'package:mobile_d2_admin/constants/assets_path.dart';
import 'package:mobile_d2_admin/modules/data_administration/screens/analytics/analytics.dart';
import 'package:mobile_d2_admin/modules/data_administration/screens/data_administration/widgets/data_administration_dashboard.dart';
import 'package:mobile_d2_admin/modules/data_administration/screens/data_administration/widgets/operation_card.dart';
import 'package:mobile_d2_admin/modules/data_administration/screens/maintainance/maintainance.dart';
import 'package:mobile_d2_admin/modules/data_administration/screens/resource/resource.dart';
import '../../../../config/theme_config.dart';

class DataAdministration extends StatelessWidget {
  const DataAdministration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Data Administration',
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
          color: AppColors.appGreyColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const DataAdministrationDashBoard(),
            const SizedBox(height: 24),
            buildOperationCardList(context)
          ],
        ),
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
          label: 'Maintainance',
          screen: Maintainance(),
        ),
        OperationCard(
          imageUrl: AssetsPath.schedule,
          label: 'Scheduler',
          screen: Maintainance(),
        ),
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
