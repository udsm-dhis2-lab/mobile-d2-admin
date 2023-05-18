import 'package:flutter/material.dart';

import 'package:mobile_d2_admin/config/theme_config.dart';

class OperationCard extends StatelessWidget {
  final String imageUrl;
  final String label;
  final Widget screen;
  const OperationCard({
    super.key,
    required this.imageUrl,
    required this.label,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => screen));
      },
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(imageUrl),
                const SizedBox(height: 12),
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppColors.appDarkGreyColor,
                        fontWeight: FontWeight.w600,
                      ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
