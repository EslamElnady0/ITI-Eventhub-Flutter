import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/assets/app_strings.dart';
import '../../../../core/assets/assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import 'widgets/custom_text_field.dart';

class LoginView extends StatefulWidget {
  static const String routeName = '/login';
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                Assets.assetsImagesAuthLogo,
                width: MediaQuery.sizeOf(context).width * 0.4,
                height: MediaQuery.sizeOf(context).height * 0.2,
              ),
            ),
            Text(
              AppStrings.signIn,
              style: AppTextStyles.font24Bold.withColor(AppColors.black),
            ),
            vGap(16),
            CustomTextField(
              hintText: AppStrings.email,
              prefixIcon: const Icon(Icons.email),
              controller: _emailController,
            ),
            vGap(16),
            CustomTextField(
              hintText: AppStrings.password,
              prefixIcon: const Icon(Icons.lock),
              controller: _passwordController,
              obscureText: true,
            ),
            vGap(16),
          ],
        ),
      ),
    );
  }
}
