import 'package:client/core/theme/app_palette.dart';
import 'package:client/core/utils.dart';
import 'package:client/core/widgets/custom_loader.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:client/features/auth/view/widgets/custom_button.dart';
import 'package:client/core/widgets/custom_field.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:client/features/home/view/pages/home_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
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
    final isLoading = ref.watch(
        authViewModelProvider.select((value) => value?.isLoading == true));

    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        data: (data) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));

          ShowSnackBar(context, 'Welcome , ${data.name}!');
        },
        error: (error, st) {
          ShowSnackBar(context, error.toString());
        },
        loading: () {},
      );
    });

    return Scaffold(
      // appBar: AppBar(),
      body: isLoading
          ? const CustomLoader()
          : Stack(
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
                              if (formkey.currentState!.validate()) {
                                ref
                                    .read(authViewModelProvider.notifier)
                                    .loginUser(
                                        email: emailController.text,
                                        password: passwordController.text);
                              }
                            }),
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
