import 'package:flutter/material.dart';
import 'package:mobile_d2_admin/widgets/custom_checkbox.dart';
import 'package:mobile_d2_admin/widgets/custom_material_button.dart';

import '../../../../config/theme_config.dart';

class Maintainance extends StatelessWidget {
  const Maintainance({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Maintainance',
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
                child: ListView(
                  children: [
                    CustomCheckBox(action: 'Clear analytics tables'),
                    CustomCheckBox(action: 'Analyze analytics tables'),
                    CustomCheckBox(action: 'Remove zero data values'),
                    CustomCheckBox(action: 'Prune periods'),
                    CustomCheckBox(action: 'Remove expired invitations'),
                    CustomCheckBox(action: 'Drop SQL views'),
                    CustomCheckBox(action: 'Create SQL views'),
                    CustomCheckBox(action: 'Update category option'),
                    CustomCheckBox(action: 'Update organisation unit paths'),
                    CustomCheckBox(action: 'Clear application cache'),
                    CustomCheckBox(action: 'Reload apps'),
                  ],
                )),
            const SizedBox(
              height: 32,
            ),
            CustomMaterialButton(
              size: size,
              label: 'Perform Maintainance',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
