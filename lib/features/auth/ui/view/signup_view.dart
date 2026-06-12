import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iti_flutter_proj/features/auth/ui/view/login_view.dart';

import '../../../../core/assets/app_strings.dart';
import '../../../../core/assets/assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import 'widgets/auth_footer.dart';
import 'widgets/signup_form.dart';
import 'widgets/social_auth_button.dart';

class SignupView extends StatefulWidget {
  static const String routeName = '/signup';
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late ValueNotifier<bool> _isPasswordVisible;
  late ValueNotifier<bool> _isConfirmPasswordVisible;
  final _formKey = GlobalKey<FormState>();
  @override
  initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _isPasswordVisible = ValueNotifier<bool>(false);
    _isConfirmPasswordVisible = ValueNotifier<bool>(false);
    super.initState();
  }

  @override
  dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _isPasswordVisible.dispose();
    _isConfirmPasswordVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vGap(10),
            BackButton(),
            vGap(20),
            Text(
              AppStrings.signUp,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            vGap(16),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SignupForm(
                          formKey: _formKey,
                          nameController: _nameController,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          confirmPasswordController: _confirmPasswordController,
                          isPasswordVisible: _isPasswordVisible,
                          isConfirmPasswordVisible: _isConfirmPasswordVisible,
                        ),

                        vGap(32),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: CustomButton(
                            label: AppStrings.signUp,
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {}
                            },
                          ),
                        ),
                        vGap(32),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            AppStrings.or,
                            style: AppTextStyles.font16Medium.withColor(
                              AppColors.darkGray,
                            ),
                          ),
                        ),
                        vGap(32),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: SocialAuthButton(
                            label: AppStrings.loginWithGoogle,
                            assetPath: Assets.assetsImagesGoogleIcon,
                            onPressed: () {},
                          ),
                        ),
                        vGap(16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: SocialAuthButton(
                            label: AppStrings.loginWithFacebook,
                            assetPath: Assets.assetsImagesFacebookIcon,
                            onPressed: () {},
                          ),
                        ),
                        vGap(16),
                      ],
                    ),
                  ),

                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AuthFooter(
                          text: AppStrings.alreadyHaveAccount,
                          buttonText: AppStrings.signIn,
                          onPressed: () {
                            context.pop();
                          },
                        ),
                        vGap(24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
