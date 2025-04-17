import 'package:client/core/theme/app_palette.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:client/features/auth/view/widgets/custom_button.dart';
import 'package:client/features/auth/view/widgets/custom_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' as fp;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(AssetImage('assets/images/login.jpg'), context);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
    formkey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/login.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formkey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Text(
                    "Sign in to your account.",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  CustomField(
                    hintText: 'Email',
                    controller: emailController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomField(
                    hintText: 'Password',
                    isObscureText: true,
                    controller: passwordController,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  CustomButton(
                    buttonText: "Sign In",
                    onTap: () async {
                      final res = await AuthRemoteRepository().login(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      final val = switch (res) {
                        fp.Left(value: final l) => l,
                        fp.Right(value: final r) => r,
                      };
                      print(val);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Don't have an account ? ",
                      style: TextStyle(fontFamily: 'Lato'),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _navigate(context),
                            text: " Sign Up",
                            style: TextStyle(
                              color: Pallete.gradient2,
                              fontFamily: 'Lato',
                            ))
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _navigate(BuildContext context) {
  Navigator.of(context).pushReplacement(
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 400), // Smooth transition time
      pageBuilder: (context, animation, secondaryAnimation) => SignupPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ),
  );
}
