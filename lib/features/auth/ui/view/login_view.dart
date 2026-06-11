import 'package:flutter/material.dart';
import '../../../../core/assets/app_strings.dart';
import '../../../../core/assets/assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import 'widgets/login_form.dart';
import 'widgets/remember_me_and_forget_password.dart';

class LoginView extends StatefulWidget {
  static const String routeName = '/login';
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late ValueNotifier<bool> _isPasswordVisible;
  late ValueNotifier<bool> _isRememberMeChecked;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _isPasswordVisible = ValueNotifier<bool>(false);
    _isRememberMeChecked = ValueNotifier<bool>(false);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _isPasswordVisible.dispose();
    _isRememberMeChecked.dispose();
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
            LoginForm(
              formKey: _formKey,
              emailController: _emailController,
              passwordController: _passwordController,
              isPasswordVisible: _isPasswordVisible,
            ),
            vGap(16),
            RememberMeAndForgetPassword(
              isChecked: _isRememberMeChecked,
              onChanged: (value) {
                _isRememberMeChecked.value = value ?? false;
              },
              onForgetPasswordPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
