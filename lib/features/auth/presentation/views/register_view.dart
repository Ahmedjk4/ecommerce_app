import 'package:electronics_shop/constants.dart';
import 'package:electronics_shop/core/services/create_new_user_service.dart';
import 'package:electronics_shop/core/utils/types/text_form_field_types.dart';
import 'package:electronics_shop/core/widgets/custom_button.dart';
import 'package:electronics_shop/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController(),
      firstNameController = TextEditingController(),
      lastNameController = TextEditingController(),
      phoneNumberController = TextEditingController();
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
                    hintText: "Enter Your First Name",
                    label: "First Name",
                    controller: firstNameController,
                    type: TextFormFieldTypes.name,
                    autoFocus: true,
                  ),
                  CustomTextField(
                    hintText: "Enter Your Last Name",
                    label: "Last Name",
                    controller: lastNameController,
                    type: TextFormFieldTypes.name,
                  ),
                  CustomTextField(
                    hintText: "Enter Your Phone Number",
                    label: "Phone Number",
                    controller: phoneNumberController,
                    type: TextFormFieldTypes.number,
                  ),
                  CustomTextField(
                    hintText: "Enter Your Email",
                    label: "Email",
                    controller: emailController,
                    type: TextFormFieldTypes.email,
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
                    text: "Sign Up",
                    callback: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        await CreateNewUserService.createNewUser(
                          name:
                              '${firstNameController.text} ${lastNameController.text}',
                          phoneNumber: phoneNumberController.text,
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        if (context.mounted) {
                          context.pop();
                        }
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
                        "Already have an account ?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text(
                          "Login",
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
