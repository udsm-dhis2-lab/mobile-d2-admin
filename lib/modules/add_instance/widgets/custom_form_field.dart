import 'package:flutter/material.dart';

import '/config/theme_config.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String keyboardType;
  final String label;
  final String? Function(String?)? validator;
  const CustomFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.label,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    const Map<String, TextInputType> inputType = {
      'name': TextInputType.name,
      'password': TextInputType.visiblePassword,
      'url': TextInputType.url,
      'description': TextInputType.text,
    };
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: controller,
        keyboardType: inputType[keyboardType],
        decoration: InputDecoration(
          label: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: AppColors.textMuted,
                ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide:
                const BorderSide(color: AppColors.outlineColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide:
                const BorderSide(color: AppColors.primaryColor, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: AppColors.errorColor, width: 1),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
