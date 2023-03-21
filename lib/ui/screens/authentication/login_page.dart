import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:xyz_store/ui/screens/screens.dart';
import 'package:xyz_store/services/firebase_auth_methods.dart';
import 'package:xyz_store/ui/widgets/show_snackbar.dart';
import 'package:xyz_store/ui/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
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
                'Login',
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormWidget(
                functionValidator: (value) {
                  if (value == null || value.length < 4) {
                    return 'Please Enter valid email';
                  } else {
                    return '';
                  }
                },
                textController: emailController,
                textString: "Enter your Email",
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormWidget(
                  functionValidator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password must be more than 5 characters';
                    } else {
                      return '';
                    }
                  },
                  textController: passwordController,
                  textString: "Enter your password"),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if ((emailController.text.length >= 4) &&
                        passwordController.text.length > 5) {
                      context.read<FirebaseAuthMedthods>().signinEmail(
                          context: context,
                          email: emailController.text,
                          password: passwordController.text);
                      context.goNamed('loading_screen');
                    } else {
                      showSnackBar(
                          "Please Enter valid email and password", context);
                    }
                  },
                  child: const Text("Login")),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Dont Have an Acocunt ?'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const SignUpPage())));
                    },
                    child: const Text("Signup"),
                  ),
                ],
              ),
              const Divider(
                height: 10 * 5,
                thickness: 1,
                indent: 10 * 8,
                endIndent: 10 * 8,
                color: Colors.red,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    child: IconButton(
                      onPressed: () {
                        context
                            .read<FirebaseAuthMedthods>()
                            .signInWithGoogle(context);
                        context.pop();
                      },
                      icon: Image.asset("google".toPng()),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              )
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
