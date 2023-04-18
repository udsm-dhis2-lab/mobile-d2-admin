import 'package:flutter/material.dart';

import '../config/theme_config.dart';

// ignore: must_be_immutable
class CustomCheckBox extends StatefulWidget {
  bool? isChecked;
  final String action;
  CustomCheckBox({
    super.key,
    this.isChecked,
    required this.action,
  }) {
    isChecked = isChecked ?? false;
  }

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: widget.isChecked,
      
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (newValue) {
        setState(() {
          widget.isChecked = newValue;
        });
      },
      title: Text(
        widget.action,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: AppColors.onSurfaceColor),
      ),
    );
  }
}
