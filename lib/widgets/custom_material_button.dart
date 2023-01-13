import 'package:flutter/material.dart';

import '/config/theme_config.dart';

class CustomMaterialButton extends StatelessWidget {
  final Size size;
  final double? height;
  final String label;
  final void Function() onPressed;
  const CustomMaterialButton(
      {super.key,
      required this.size,
      this.height,
      required this.label,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.9,
      height: height ?? 44,
      child: MaterialButton(
        elevation: 0.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: AppColors.primaryColor,
        onPressed: onPressed,
        child: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: AppColors.onPrimaryColor),
        ),
      ),
    );
  }
}
