import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/assets/app_strings.dart';
import '../../../../core/assets/assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import '../../../home/ui/view/explore_view.dart';
import '../cubit/auth_cubit.dart';
import 'signup_view.dart';
import 'widgets/auth_footer.dart';
import 'widgets/login_form.dart';
import 'widgets/remember_me_and_forget_password.dart';
import 'widgets/remembered_user_section.dart';
import 'widgets/social_auth_button.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<AuthCubit>().loadRememberedUser();
    });
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocListener<AuthCubit, AuthState>(
                    listener: (context, state) async {
                      if (state.status == AuthStatus.failure &&
                          state.errorMessage.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errorMessage)),
                        );
                      }
                      if (state.status == AuthStatus.authenticated) {
                        _goHome(context);
                      }
                    },
                    child: const SizedBox.shrink(),
                  ),
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
                  const RememberedUserSection(),
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
                  vGap(24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: BlocSelector<AuthCubit, AuthState, bool>(
                      selector: (state) => state.status == AuthStatus.loading,
                      builder: (context, isLoading) {
                        return CustomButton(
                          label: isLoading ? 'Loading...' : AppStrings.signIn,
                          onPressed: () {
                            if (isLoading) return;
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<AuthCubit>().login(
                                email: _emailController.text,
                                password: _passwordController.text,
                                rememberMe: _isRememberMeChecked.value,
                              );
                            }
                          },
                        );
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
                    text: AppStrings.dontHaveAccount,
                    buttonText: AppStrings.signUp,
                    onPressed: () {
                      context.push(SignupView.routeName);
                    },
                  ),
                  vGap(24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goHome(BuildContext context) {
    final router = GoRouter.of(context);
    if (!mounted) return;
    router.go(ExploreView.routeName);
  }
}
