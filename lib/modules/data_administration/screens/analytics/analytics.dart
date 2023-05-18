import 'package:flutter/material.dart';
import 'package:mobile_d2_admin/widgets/custom_checkbox.dart';
import 'package:mobile_d2_admin/widgets/custom_material_button.dart';

import '../../../../config/theme_config.dart';
import '../../../../constants/assets_path.dart';
import '../../../../utils/services/rest_apis/data_administration_api.dart';
import '../../widgets/process_status.dart';
import '../../widgets/task_progress.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  var data = <String, dynamic>{};

  final actionCheckBoxes = [
    CustomCheckBox(
      actionLabel: 'Skip generation of aggregate',
      action: 'skipAggregate',
    ),
    CustomCheckBox(
      actionLabel: 'Skip generation of resource tables',
      action: 'skipResourceTables',
    ),
    CustomCheckBox(
      actionLabel: 'Skip generation of event data',
      action: 'skipEvents',
    ),
    CustomCheckBox(
      actionLabel: 'Skip generation of enrollment data',
      action: 'skipEnrollment',
    ),
  ];

  final numberOfLastYears = _NumberOfLastYearsInputField();

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
                  ...actionCheckBoxes,
                  const SizedBox(
                    height: 40,
                  ),
                  numberOfLastYears,
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            CustomMaterialButton(
              size: size,
              label: 'Run Analytics',
              onPressed: () {
                for (var option in actionCheckBoxes) {
                  if (option.isChecked == true) {
                    data[option.action] = true;
                  } else {
                    data[option.action] = false;
                  }
                }
                data['lastYears'] = numberOfLastYears.dropdownValue;
                showRunAnalyticsProcess(context, size, data);
              },
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> showRunAnalyticsProcess(
      BuildContext context, Size size, dynamic data) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.surfaceColor),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: StreamBuilder<List<dynamic>>(
                    stream: DataAdministrationApi.runAnalytics(data),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: size.height * 0.2,
                              child: ListView.separated(
                                  primary: false,
                                  itemCount: snapshot.data!.length,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 16,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    final progresses = snapshot.data;
                                    return TaskProgress(
                                      time: progresses![index]['time'],
                                      message: progresses[index]['message'],
                                    );
                                  }),
                            ),
                            if (!snapshot.data![0]['completed'])
                              const CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            if (snapshot.data![0]['completed'])
                              CustomMaterialButton(
                                size: size,
                                label: 'Ok',
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return ProcessStatus(
                          imagePath: AssetsPath.error,
                          processStatus: 'Failed',
                          process: snapshot.error.toString(),
                          size: size,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        );
                      } else {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          ],
                        );
                      }
                    }),
              ),
            ),
          );
        });
  }
}

// ignore: must_be_immutable
class _NumberOfLastYearsInputField extends StatefulWidget {
  String dropdownValue = 'All';

  final List<String> lastYears = ['All', '1', '2'];

  @override
  State<_NumberOfLastYearsInputField> createState() =>
      _NumberOfLastYearsInputFieldState();
}

class _NumberOfLastYearsInputFieldState
    extends State<_NumberOfLastYearsInputField> {
  @override
  Widget build(BuildContext context) {
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
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            isEmpty: widget.dropdownValue == '',
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: widget.dropdownValue,
                isDense: true,
                onChanged: (String? newValue) {
                  setState(() {
                    widget.dropdownValue = newValue!;
                    // state.didChange(newValue);
                  });
                },
                items: widget.lastYears
                    .map<DropdownMenuItem<String>>((String value) {
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
