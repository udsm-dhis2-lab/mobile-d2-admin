// ignore_for_file: file_names

import 'package:d2_touch/modules/auth/models/login-response.model.dart';
import 'package:flutter/material.dart';
import 'package:mobile_d2_admin/constants/app_constants.dart';
import 'package:mobile_d2_admin/core/auth/login/widgets/text_widget_bold.dart';
import 'package:mobile_d2_admin/modules/data_administration/screens/data_administration/data_administration.dart';

import '../../../config/theme_config.dart';

class Login extends StatefulWidget {
  final String instanceUrl;
  const Login({
    Key? key,
    required this.instanceUrl,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username = '';
  String password = '';
  String url = '';
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  bool authenticating = false;
  bool showPassWord = false;
  bool loggedIn = true;
  bool errorLoginIn = false;
  late String errorMessage;

  @override
  void initState() {
    usernameController.text = "baharajr";
    passwordController.text = "Idsr@2023";
    urlController.text = widget.instanceUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // ignore: todo
        //TODO : add logic to check if back will go to login page

        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: const BoxDecoration(color: AppColors.primaryColor),
          width: double.maxFinite,
          height: double.maxFinite,
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 120),
                alignment: Alignment.center,
                child: TextWidgetBold(
                  text: '',
                  size: 30,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 30, right: 20, left: 20),
                  margin: const EdgeInsets.only(left: 40, right: 40, top: 20),
                  child: Container(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            errorLoginIn
                                ? Text(
                                    "Error logging in. Please confirm your credentials and retry",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error),
                                  )
                                : const SizedBox(
                                    height: 0,
                                  ),
                            /*Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  controller: urlController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person_outlined),
                                    border: UnderlineInputBorder(),
                                    labelText: 'Dhis URL',
                                  ),
                                )),*/
                            Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  controller: usernameController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person_outlined),
                                    border: UnderlineInputBorder(),
                                    labelText: 'Username',
                                  ),
                                )),
                            Container(
                                margin:
                                    const EdgeInsets.only(top: 15, bottom: 25),
                                child: TextFormField(
                                  obscureText: !showPassWord,
                                  controller: passwordController,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock_outlined),
                                    // suffixIcon: Icon(Icons.person,),
                                    suffixIcon: IconButton(
                                      icon: showPassWord
                                          ? const Icon(Icons.visibility_sharp)
                                          : const Icon(
                                              Icons.visibility_off_outlined),
                                      onPressed: () {
                                        setState(() {
                                          showPassWord = !showPassWord;
                                        });
                                      },
                                    ),
                                    border: const UnderlineInputBorder(),
                                    labelText: 'Password',
                                  ),
                                )),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  username = usernameController.text;
                                  password = passwordController.text;
                                  url = urlController.text;

                                  authenticating = true;
                                  errorMessage = "";
                                  errorLoginIn = false;
                                });
                                _login(username.trim(), password.trim(),
                                    url.trim());
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.only(
                                          left: 30, right: 30))),
                              child: authenticating == false
                                  ? const Text("Login",
                                      style: TextStyle(color: Colors.white))
                                  : const CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                            ),
                          ],
                        ),
                      )))
            ],
          ),
        ),
      ),
    );
  }
  
  _login(String username, String password, String url) async {
    setState(() {
      authenticating = true;
    });

    // ignore: unused_local_variable
    LoginResponseStatus? onlineLogIn;

    try {
      onlineLogIn = await d2repository.authModule
          .logIn(username: username, password: password, url: url);
    } catch (error) {
      onlineLogIn = null;

      setState(() {
        errorLoginIn = true;
        authenticating = false;
      });
    }

    bool isAuthenticated = await d2repository.authModule.isAuthenticated();

    if (isAuthenticated) {
      // User? loggedInUser =
      //     await d2repository.userModule.user.withAuthorities().getOne();

      setState(() => {
            authenticating = false,
            loggedIn = false,
            errorLoginIn = false,
          });

      // ignore: todo
      // TODO: revamp metadata sync page

      if (mounted) {}
      try {
        // if (mounted) {}
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DataAdministration()),
        );
        if (!mounted) {}
        Navigator.pop(context);
      } catch (error) {
        //
      }
    } else {
      //logic to show error widget

      setState(() => {
            authenticating = false,
            loggedIn = false,
            errorLoginIn = true,
            errorMessage = "error message"
          });
    }
  }
}
