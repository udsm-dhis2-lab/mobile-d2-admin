import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/widgets/custom_material_button.dart';
import '/config/theme_config.dart';
import '/database/repository.dart';
import '/models/index.dart';
import '/core/ping/ping_instance.dart';
import 'widgets/custom_form_field.dart';

class AddInstanceScreen extends StatefulWidget {
  final Instance? instance;
  final bool isUpdating;

  const AddInstanceScreen({super.key, this.instance})
      // if we have an instance, we are updating
      : isUpdating = (instance != null);

  @override
  State<AddInstanceScreen> createState() => _AddInstanceScreenState();
}

class _AddInstanceScreenState extends State<AddInstanceScreen> {
  static final _formKey = GlobalKey<FormState>();

  List<String> allInstancesNames = <String>[];

  final TextEditingController instanceNameController = TextEditingController();
  final TextEditingController instanceDetailsController =
      TextEditingController();
  final TextEditingController instanceUrlController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdating) {
      instanceNameController.text = widget.instance!.instanceName;
      instanceUrlController.text = widget.instance!.instanceUrl;
    }
    //  get all instance names that have been used
    // change all names to uppercase
    Future.delayed(Duration.zero, (() {
      final repository = Provider.of<Repository>(context, listen: false);
      setState(() async {
        final names = await getAllInstancesNames(repository);
        final namesInUpperCase = <String>[];
        for (var name in names) {
          namesInUpperCase.add(name.toUpperCase());
        }
        allInstancesNames = namesInUpperCase;
      });
    }));
  }

  @override
  void dispose() {
    instanceDetailsController.dispose();
    instanceDetailsController.dispose();
    instanceUrlController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final repository = Provider.of<Repository>(context, listen: false);
    // if we are updating remove the current instance name from already used names
    final List<String> alreadyAvailableNames = List.from(allInstancesNames);
    widget.isUpdating
        ? alreadyAvailableNames
            .remove(widget.instance!.instanceName.toUpperCase())
        : alreadyAvailableNames;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColors.primaryColor,
          title: Text(
            widget.isUpdating ? 'Edit Instance' : 'Add Instance',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColors.onPrimaryColor,
                ),
          ),
        ),
        body: Container(
          padding:
              const EdgeInsets.only(left: 25, right: 25, top: 39, bottom: 30),
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.surfaceColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: buildForm(context, size, repository, alreadyAvailableNames),
        ),
      ),
    );
  }

  Widget buildForm(
    BuildContext context,
    Size size,
    Repository repository,
    List<String> alreadyAvailableNames,
  ) {
    final ping = PingInstance(repository: repository);
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Information',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.onSurfaceColor, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              'Provide details about new dhis instance',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColors.textMuted,
                  ),
            ),
            const SizedBox(height: 24),
            CustomFormField(
              controller: instanceNameController,
              keyboardType: 'name',
              label: 'Name*',
              validator: (value) {
                if (alreadyAvailableNames.contains(value!.trim().toUpperCase())) {
                  return 'This instance name has already been used';
                } else if (value.isEmpty) {
                  return 'This field can not be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            CustomFormField(
              controller: instanceDetailsController,
              keyboardType: 'description',
              label: 'Description',
            ),
            const SizedBox(height: 24),
            CustomFormField(
              controller: instanceUrlController,
              keyboardType: 'url',
              label: 'Url*',
            ),
            const SizedBox(height: 52),
            // Text(
            //   'Instance Credentials',
            //   style: Theme.of(context).textTheme.titleMedium!.copyWith(
            //       color: AppColors.onSurfaceColor, fontWeight: FontWeight.w600),
            // ),
            // const SizedBox(height: 6),
            // Text(
            //   'Provide your credentials to this dhis instance',
            //   style: Theme.of(context).textTheme.titleSmall!.copyWith(
            //         color: AppColors.textMuted,
            //       ),
            // ),
            // const SizedBox(height: 24),
            // CustomFormField(
            //   controller: userNameController,
            //   keyboardType: 'name',
            //   label: 'Username',
            // ),
            // const SizedBox(height: 24),
            // CustomFormField(
            //   controller: passwordController,
            //   keyboardType: 'password',
            //   label: 'Password',
            // ),
            // const SizedBox(height: 50),
            // Container(
            //   constraints: const BoxConstraints.expand(height: 69),
            //   padding: const EdgeInsets.only(
            //       top: 20, bottom: 19, right: 22, left: 17.75),
            //   decoration: BoxDecoration(
            //       color: AppColors.infoColor,
            //       borderRadius: BorderRadius.circular(10)),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       const Icon(
            //         Icons.info_outline,
            //         color: AppColors.onInfoColor,
            //         size: 37.5,
            //       ),
            //       const SizedBox(width: 18.75),
            //       Expanded(
            //         child: Text(
            //           'Providing username and password to dhis instance gives you more functionalities',
            //           style: Theme.of(context)
            //               .textTheme
            //               .bodySmall!
            //               .copyWith(color: AppColors.onInfoColor, fontSize: 12),
            //           maxLines: 4,
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 33),
            CustomMaterialButton(
              size: size,
              label: 'Save',
              onPressed: (() {
                widget.isUpdating
                    ? updateInstance(repository, ping)
                    : addInstance(repository, ping);
              }),
            )
          ],
        ),
      ),
    );
  }

  void addInstance(Repository repository, PingInstance ping) async {
    if (_formKey.currentState!.validate()) {
      final instance = Instance(
        instanceName: instanceNameController.text,
        instanceUrl: instanceUrlController.text,
      );
      final id = await repository.addInstance(instance);
      await ping.pingInstance(
        Instance(
            id: id,
            instanceName: instanceNameController.text,
            instanceUrl: instanceUrlController.text),
      );
      // check if not mounted to avoid asychronous gaps after async function
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  void updateInstance(Repository repository, PingInstance ping) async {
    if (_formKey.currentState!.validate()) {
      final instance = Instance(
        id: widget.instance!.id,
        instanceName: instanceNameController.text,
        instanceUrl: instanceUrlController.text,
      );
      await repository.updateInstance(instance);
      // check if not mounted to avoid asychronous gaps after async function
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  Future<List<String>> getAllInstancesNames(Repository repository) async {
    final instances = await repository.getAllInstances();
    final instancesNames = <String>[];

    for (var instance in instances) {
      instancesNames.add(instance.instanceName);
    }
    return instancesNames;
  }
}
