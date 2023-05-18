import 'package:flutter/material.dart';
import 'package:mobile_d2_admin/config/theme_config.dart';
import 'package:mobile_d2_admin/widgets/custom_material_button.dart';

class ProcessStatus extends StatelessWidget {
  final String imagePath;
  final String processStatus;
  final String process;
  final Size size;
  final void Function() onPressed;
  const ProcessStatus(
      {super.key,
      required this.imagePath,
      required this.processStatus,
      required this.process,
      required this.size,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          )),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          processStatus,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.onSurfaceColor,
              ),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          process,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: AppColors.textMuted,
              ),
        ),
        const SizedBox(
          height: 16,
        ),
        CustomMaterialButton(
          size: size,
          label: 'Ok',
          onPressed: onPressed,
        )
      ],
    );
  }
}
