import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/snackbar/snackbar.dart';
import '../../../../core/common/text/style_font_20.dart';
import '../../../../core/common/text/text.dart';
import '../../domain/entity/user_entity.dart';
import '../view_model/auth_view_model.dart';

class Register extends ConsumerStatefulWidget {
  const Register({super.key});

  @override
  ConsumerState<Register> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  final _key = GlobalKey<FormState>();
  final _fullNameController = TextEditingController(text: "Sudip Singh Khati");

  final _emailController = TextEditingController(text: "sudip@gmail.com");
  final _passwordController = TextEditingController(text: "sudip123");
  bool isObscure = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: const Color(0xFFA38CFE),
      appBar: AppBar(
        title: const TextStyle1(text: 'Registration'),
        centerTitle: true,
        elevation: 0,
        // backgroundColor: const Color.fromRGBO(51, 0, 255, 0.45),
      ),
      body: Center(
        child: Form(
          key: _key,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                width: width * double.infinity,
                child: TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    hintText: 'Full  Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  }),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                width: width * 1,
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    return null;
                  }),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                width: width * 1,
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: isObscure,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      icon: Icon(
                        isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6),
                child: SizedBox(
                  width: width * 0.6,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        var user = UserEntity(
                          fullName: _fullNameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                        );

                        ref
                            .read(authViewModelProvider.notifier)
                            .registerUser(context, user);
                      }

                      if (authState.error != null) {
                        showSnackBar(
                          context: context,
                          message: authState.error.toString(),
                        );
                      } else {
                      showSnackBar(
                        context: context,
                        message: 'Registered successfully',
                        color: Colors.green,
                      );
                      }
                    },
                    child: const Text('Register'),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MakingText("Already Have An Account"),
                  TextButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/');
                    },
                    child: const MakingText('Sign In'),
                  ),
                  const MakingText('Here'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
