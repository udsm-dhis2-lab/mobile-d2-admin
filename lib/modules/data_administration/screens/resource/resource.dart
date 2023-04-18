import 'package:flutter/material.dart';
import 'package:mobile_d2_admin/widgets/custom_material_button.dart';

import '../../../../config/theme_config.dart';

class Resource extends StatelessWidget {
  const Resource({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Resource Tables',
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
                    buildAction('Organisation unit structure', context),
                    buildAction('Organisation unit category option', context),
                    buildAction('Category option group set structure', context),
                    buildAction('Data element group set structure', context),
                    buildAction('Indicator group set structure', context),
                    buildAction(
                        'Organisation unit group set structure', context),
                    buildAction('Data element category option combo', context),
                    buildAction('Data element structure', context),
                    buildAction('Period structure', context),
                    buildAction('Date period structure', context),
                    buildAction('Data element category option', context),
                  ],
                )),
            const SizedBox(
              height: 32,
            ),
            CustomMaterialButton(
              size: size,
              label: 'Generate Tables',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget buildAction(String action, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        action,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: AppColors.onSurfaceColor),
      ),
    );
  }
}
