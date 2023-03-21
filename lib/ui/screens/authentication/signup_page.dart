import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:xyz_store/services/firebase_auth_methods.dart';
import 'package:xyz_store/ui/widgets/show_snackbar.dart';

import 'package:xyz_store/ui/widgets/widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 80,
                child: Image.asset(
                  "xyz".toPng(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Sign up',
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormWidget(
                  functionValidator: (value) {
                    if (value == null || value.length < 4) {
                      return showSnackBar(
                          'Please Enter name of greater than 4 characters',
                          context);
                    } else {
                      return '';
                    }
                  },
                  textController: _nameController,
                  textString: "Enter your Name"),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormWidget(
                  functionValidator: (value) {
                    if (value == null || value.length < 4) {
                      return 'Please Enter valid Email';
                    } else {
                      return '';
                    }
                  },
                  
                  textController: _emailController,
                  textString: "Enter your Email"),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormWidget(
                  functionValidator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password must be more than 5 characters';
                    } else {
                      return "";
                    }
                  },
                  textController: _passwordController,
                  textString: "Create your Password"),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      context.read<FirebaseAuthMedthods>().signUpwithEmail(
                          userName: _nameController.text,
                          password: _passwordController.text,
                          email: _emailController.text,
                          context: context);

                      showSnackBar("Email Verification sent", context);
                    } else {
                      showSnackBar("Please fullfill above conditions", context);
                    }
                  },
                  child: const Text("Sign Up")),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on String {
  toPng() {
    return 'assets/icons/$this.png';
  }
}
