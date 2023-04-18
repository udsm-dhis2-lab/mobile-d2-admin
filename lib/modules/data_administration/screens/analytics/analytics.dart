import 'package:flutter/material.dart';
import 'package:mobile_d2_admin/widgets/custom_checkbox.dart';
import 'package:mobile_d2_admin/widgets/custom_material_button.dart';

import '../../../../config/theme_config.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  String dropdownValue = 'All';
  bool showDropdownMenu = false;

  final List<String> lastYears = ['All', '1', '2'];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Analytics',
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
                    CustomCheckBox(action: 'Skip generation of aggregate'),
                    CustomCheckBox(
                        action: 'Skip generation of resource tables'),
                    CustomCheckBox(action: 'Skip generation of event data'),
                    CustomCheckBox(
                        action: 'Skip generation of enrollment data'),
                    const SizedBox(
                      height: 40,
                    ),
                    buildNumberOfLastYearsInputFIeld()
                  ],
                )),
            const SizedBox(
              height: 32,
            ),
            CustomMaterialButton(
              size: size,
              label: 'Run Analytics',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget buildNumberOfLastYearsInputFIeld() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Number of last years of data to include',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.onSurfaceColor),
          ),
          const SizedBox(height: 16),
          InputDecorator(
            decoration: InputDecoration(
                label: const Text('Years'),
                labelStyle: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: AppColors.primaryColor),
                errorStyle:
                    const TextStyle(color: Colors.redAccent, fontSize: 16.0),
                hintText: 'last year',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
            isEmpty: dropdownValue == '',
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: dropdownValue,
                isDense: true,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    // state.didChange(newValue);
                  });
                },
                items: lastYears.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
