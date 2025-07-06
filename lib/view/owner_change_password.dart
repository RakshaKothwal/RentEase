import 'package:flutter/material.dart';
import 'package:rentease/common/global_widget.dart';

class OwnerChangePassword extends StatefulWidget {
  const OwnerChangePassword({super.key});

  @override
  State<OwnerChangePassword> createState() => _OwnerChangePasswordState();
}

class _OwnerChangePasswordState extends State<OwnerChangePassword> {
  final formKey = GlobalKey<FormState>();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool obscureCurrentPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;

  String? errorType;

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(
          data: "Change Password", showBackArrow: true, context: context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Set a new Password",
                  style: TextStyle(
                    color: Colors.black.withAlpha((255 * 0.8).toInt()),
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                    fontSize: 20,
                  )),
              SizedBox(
                height: 6,
              ),
              Text(
                "Create a new password. Ensure it differs from previous ones for security",

                style: TextStyle(
                    color: Color(0xff989898),
                    fontSize: 13,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 30),
              input(
                hintText: "Current Password",
                controller: currentPasswordController,
                icon: Icons.lock,
                obscureText: obscureCurrentPassword,
                suffixIcon: passwordIcon(obscureCurrentPassword, () {
                  setState(() {
                    obscureCurrentPassword = !obscureNewPassword;
                  });
                }),
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    errorType ??= 'Please enter your current password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              input(
                hintText: "New Password",
                controller: newPasswordController,
                icon: Icons.lock,
                obscureText: obscureNewPassword,
                suffixIcon: passwordIcon(obscureNewPassword, () {
                  setState(() {
                    obscureNewPassword = !obscureNewPassword;
                  });
                }),
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    errorType ??= 'Please enter your new password';
                  }
                  if (value!.length < 6) {
                    errorType ??= 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              input(
                hintText: "Confirm New Password",
                controller: confirmPasswordController,
                icon: Icons.lock,
                obscureText: obscureConfirmPassword,
                suffixIcon: passwordIcon(obscureConfirmPassword, () {
                  setState(() {
                    obscureConfirmPassword = !obscureConfirmPassword;
                  });
                }),
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    errorType ??= 'Please confirm your new password';
                  }
                  if (value != newPasswordController.text) {
                    errorType ??= 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: submit(
                    data: "Update Password",
                    onPressed: () {
                      setState(() {
                        errorType = null;
                      });
                      formKey.currentState!.validate();
                      if (errorType != null) {
                        commonToast(errorType!);
                      } else {
                        commonToast('Password updated successfully');





                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
