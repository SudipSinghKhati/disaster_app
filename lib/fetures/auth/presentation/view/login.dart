import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/router/app_route.dart';
import '../../../../core/app.dart';
import '../../../../core/common/text/disaster_style_text.dart';
import '../../../../core/common/text/style_font_20.dart';
import '../../../../core/common/text/text.dart';
import '../view_model/auth_view_model.dart';

const topCenter = Alignment.topCenter;

class LogIn extends ConsumerStatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  ConsumerState<LogIn> createState() => _LogInState();
}

class _LogInState extends ConsumerState<LogIn> {
  final _emailController = TextEditingController(text: 'sudip@gmail.com');
  final _passwordController = TextEditingController(text: 'sudip123');
  bool isObscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: width * 1,
                height: 200,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(51, 0, 255, 0.45),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                ),
                child: const Align(
                  alignment: topCenter,
                  child: Column(
                    children: [
                      StyleText(),
                      TextStyle1(
                        text: 'Solution To The Chaos Of',
                      ),
                      TextStyle1(
                        text: 'Disaster',
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButton<Locale>(
                  value: context.locale,
                  onChanged: (Locale? newLocale) {
                    if (newLocale != null) {
                      context.setLocale(newLocale);
                    }
                  },
                  items: const [
                    DropdownMenuItem(
                      value: Locale('en', 'US'),
                      child: Text('English'),
                    ),
                    DropdownMenuItem(
                      value: Locale('es', 'ES'),
                      child: Text('Español'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width * 1,
                child: Column(
                  children: [
                    const Align(
                      alignment: topCenter,
                      child: SizedBox(
                        child: TextStyle1(
                          text: 'Sign In to Continue',
                        ),
                      ),
                    ),
                    Form(
                      key: _key,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SizedBox(
                              width: width * 0.9,
                              child: TextFormField(
                                key: const ValueKey('Email'),
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context).email(),
                                  hintText: AppLocalizations.of(context)
                                      .enterEmailAddress(),
                                  prefixIcon: const Icon(
                                    Icons.person,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter Email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.9,
                            child: TextFormField(
                              key: const ValueKey('Password'),
                              obscureText: isObscure,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText:
                                    AppLocalizations.of(context).password(),
                                hintText: AppLocalizations.of(context)
                                    .enterPassword(),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isObscure = !isObscure;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter Password';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              width: width * 0.5,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (_key.currentState!.validate()) {
                                      await ref
                                          .read(authViewModelProvider.notifier)
                                          .loginUser(
                                              context,
                                              _emailController.text,
                                              _passwordController.text);
                                    }
                                  },
                                  child: const MakingText('Sign In')),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              width: width * 1,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const MakingText("Haven't SignIn Yet"),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, AppRoute.singUpRoute);
                                        },
                                        child: const MakingText('Sign Up'),
                                      ),
                                      const MakingText('Here')
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
