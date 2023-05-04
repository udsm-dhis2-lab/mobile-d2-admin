import 'package:flutter/material.dart';

import 'package:mobile_d2_admin/constants/assets_path.dart';
import 'package:mobile_d2_admin/core/auth/login/login.dart';
import '/config/theme_config.dart';

class InstanceDataAdministrationCard extends StatelessWidget {
  final String instanceUrl;
  const InstanceDataAdministrationCard({super.key, required this.instanceUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 127,
      padding: const EdgeInsets.only(left: 18, top: 11, bottom: 11, right: 18),
      decoration: BoxDecoration(
        color: AppColors.secondaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Data Administration',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.onSecondaryContainerColor),
              ),
              const SizedBox(height: 14),
              Text(
                'Perform quick dhis administration\nactions in a go',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: const Color(0xFF6C757D)),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 25,
                width: 80,
                child: MaterialButton(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Color(0xFF6C757D), width: 0.3),
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Login(
                                    instanceUrl: instanceUrl,
                                  )));
                    },
                    child: Text(
                      'Perform',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: AppColors.onSecondaryContainerColor),
                    )),
              ),
            ],
          ),
          Image.asset(
            AssetsPath.shield,
          ),
        ],
      ),
    );
  }
}
