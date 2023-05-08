import 'package:flutter/material.dart';
import 'package:mobile_d2_admin/constants/assets_path.dart';
import 'package:mobile_d2_admin/modules/data_administration/widgets/process_status.dart';
import 'package:mobile_d2_admin/utils/services/rest_apis/data_administration_api.dart';
import 'package:mobile_d2_admin/widgets/custom_checkbox.dart';
import 'package:mobile_d2_admin/widgets/custom_material_button.dart';

import '../../../../config/theme_config.dart';

class Maintenance extends StatefulWidget {
  const Maintenance({super.key});

  @override
  State<Maintenance> createState() => _MaintenanceState();
}

class _MaintenanceState extends State<Maintenance> {
  var data = <String, bool>{};

  final actionCheckBoxes = [
    CustomCheckBox(
        actionLabel: 'Clear analytics tables', action: 'analyticsTableClear'),
    CustomCheckBox(
        actionLabel: 'Analyze analytics tables',
        action: 'analyticsTableAnalyze'),
    CustomCheckBox(
        actionLabel: 'Remove zero data values', action: 'zeroDataValueRemoval'),
    CustomCheckBox(actionLabel: 'Prune periods', action: 'periodPruning'),
    CustomCheckBox(
        actionLabel: 'Remove expired invitations',
        action: 'expiredInvitationsClear'),
    CustomCheckBox(actionLabel: 'Drop SQL views', action: 'sqlViewsDrop'),
    CustomCheckBox(actionLabel: 'Create SQL views', action: 'sqlViewsCreate'),
    CustomCheckBox(
        actionLabel: 'Update category option',
        action: 'categoryOptionComboUpdate'),
    CustomCheckBox(
        actionLabel: 'Update organisation unit paths', action: 'ouPathsUpdate'),
    CustomCheckBox(
        actionLabel: 'Clear application cache', action: 'cacheClear'),
    CustomCheckBox(actionLabel: 'Reload apps', action: 'appReload'),
    CustomCheckBox(
        actionLabel: 'deleted data value removal',
        action: 'softDeletedDataValueRemoval'),
    CustomCheckBox(
        actionLabel: 'deleted event removal',
        action: 'softDeletedEventRemoval'),
    CustomCheckBox(
        actionLabel: 'deleted enrollment removal',
        action: 'softDeletedEnrollmentRemoval'),
    CustomCheckBox(
        actionLabel: 'deleted tracked entity instance removal',
        action: 'softDeletedTrackedEntityInstanceRemoval'),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Maintenance',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                height: size.height * 0.7,
                decoration: BoxDecoration(
                  color: AppColors.surfaceColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView(children: actionCheckBoxes)),
            const SizedBox(
              height: 32,
            ),
            CustomMaterialButton(
              size: size,
              label: 'Perform Maintenance',
              onPressed: () async {
                for (var option in actionCheckBoxes) {
                  if (option.isChecked == true) {
                    data[option.action] = true;
                  } else {
                    data[option.action] = false;
                  }
                }
                showMaintenanceProcessProgress(data, context, size);
              },
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> showMaintenanceProcessProgress(
      dynamic data, BuildContext context, Size size) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
               decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.surfaceColor
            ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: FutureBuilder(
                    future: DataAdministrationApi.performMaintenance(data),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ProcessStatus(
                          imagePath: AssetsPath.complete,
                          processStatus: 'Successful',
                          process: 'maintenance was performed successful',
                          size: size,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const[
                            CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          ],
                        );
                      } else {
                        return ProcessStatus(
                          imagePath: AssetsPath.error,
                          processStatus: 'Failed',
                          process: snapshot.error.toString(),
                          size: size,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        );
                      }
                    }),
              ),
            ),
          );
        });
  }
}
