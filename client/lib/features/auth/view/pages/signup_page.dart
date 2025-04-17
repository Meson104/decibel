import 'package:client/core/theme/app_palette.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/widgets/custom_button.dart';
import 'package:client/features/auth/view/widgets/custom_field.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' as fp;

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final nameController = TextEditingController();
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
    formkey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewModelProvider)?.isLoading == true;
    return Scaffold(
      // appBar: AppBar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/register.jpg',
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
                    "Let's create your account.",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomField(
                    hintText: 'Name',
                    controller: nameController,
                  ),
                  SizedBox(
                    height: 15,
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
                    height: 30,
                  ),
                  CustomButton(
                    buttonText: "Sign Up",
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        await ref
                            .read(authViewModelProvider.notifier)
                            .signUpUser(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "Already have an account ? ",
                          style: TextStyle(fontFamily: 'Lato'),
                          children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _navigate(context),
                            text: " Sign In",
                            style: TextStyle(
                              color: Pallete.gradient2,
                              fontFamily: 'Lato',
                            ))
                      ])),
                  Spacer(
                    flex: 2,
                  )
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
      pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ),
  );
}
