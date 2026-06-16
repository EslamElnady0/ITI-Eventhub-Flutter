import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/assets/assets.dart';
import '../../../../../core/helpers/spacing.dart';
import 'custom_text_field.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final ValueNotifier<bool> isPasswordVisible;
  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isPasswordVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: AppStrings.email,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(Assets.assetsImagesMailIcon),
            ),
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
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
                validator: (value) {
                  if ((value ?? '').isEmpty) return 'Password is required.';
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
