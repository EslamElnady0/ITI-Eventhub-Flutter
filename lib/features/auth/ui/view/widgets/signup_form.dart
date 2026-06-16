import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/assets/assets.dart';
import '../../../../../core/helpers/spacing.dart';
import 'custom_text_field.dart';

class SignupForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final ValueNotifier<bool> isPasswordVisible;
  final ValueNotifier<bool> isConfirmPasswordVisible;

  const SignupForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: AppStrings.fullName,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(Assets.assetsImagesProfileIcon),
            ),
            controller: nameController,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if ((value?.trim() ?? '').isEmpty) {
                return 'Full name is required.';
              }
              return null;
            },
          ),
          vGap(20),
          CustomTextField(
            hintText: AppStrings.email,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(Assets.assetsImagesMailIcon),
            ),
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              final email = value?.trim() ?? '';
              if (email.isEmpty) return 'Email is required.';
              if (!email.contains('@')) return 'Enter a valid email.';
              return null;
            },
          ),
          vGap(20),
          ValueListenableBuilder<bool>(
            valueListenable: isPasswordVisible,
            builder: (context, isVisible, child) {
              return CustomTextField(
                hintText: AppStrings.password,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(Assets.assetsImagesPassword),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    isPasswordVisible.value = !isVisible;
                  },
                  icon: Icon(
                    isVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
                controller: passwordController,
                obscureText: !isPasswordVisible.value,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  final password = value ?? '';
                  if (password.isEmpty) return 'Password is required.';
                  if (password.length < 6) {
                    return 'Password must be at least 6 characters.';
                  }
                  return null;
                },
              );
            },
          ),
          vGap(20),
          ValueListenableBuilder<bool>(
            valueListenable: isConfirmPasswordVisible,
            builder: (context, isVisible, child) {
              return CustomTextField(
                hintText: AppStrings.confirmPassword,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(Assets.assetsImagesPassword),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    isConfirmPasswordVisible.value = !isVisible;
                  },
                  icon: Icon(
                    isVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
                controller: confirmPasswordController,
                obscureText: !isConfirmPasswordVisible.value,
                validator: (value) {
                  if (value != passwordController.text) {
                    return 'Passwords do not match.';
                  }
                  return null;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
