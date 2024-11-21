import 'package:electronics_shop/constants.dart';
import 'package:electronics_shop/core/utils/app_router.dart';
import 'package:electronics_shop/core/services/login_by_email_and_password_service.dart';
import 'package:electronics_shop/core/utils/types/text_form_field_types.dart';
import 'package:electronics_shop/core/widgets/custom_button.dart';
import 'package:electronics_shop/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Constants.kPrimaryColor,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Hero(
                      tag: "logo",
                      child: Image.asset('assets/logo.png'),
                    ),
                  ),
                  CustomTextField(
                    hintText: "Enter Your Email",
                    label: "Email",
                    controller: emailController,
                    type: TextFormFieldTypes.email,
                    autoFocus: true,
                  ),
                  CustomTextField(
                    hintText: "Enter Your Password",
                    label: "Password",
                    controller: passwordController,
                    type: TextFormFieldTypes.password,
                    obsecure: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  CustomButton(
                    text: "Login",
                    callback: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        await LoginByEmailAndPasswordService
                            .loginByEmailAndPassword(
                          context: context,
                          emailController.text,
                          passwordController.text,
                        );
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          context.push(AppRouter.register);
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
