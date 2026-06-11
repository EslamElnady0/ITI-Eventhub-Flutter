import 'package:flutter/material.dart';

import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/colors.dart';

class RememberMeAndForgetPassword extends StatelessWidget {
  final ValueNotifier<bool> isChecked;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onForgetPasswordPressed;

  const RememberMeAndForgetPassword({
    super.key,
    required this.isChecked,
    required this.onChanged,
    required this.onForgetPasswordPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: isChecked,
              builder: (context, value, child) {
                return Switch(
                  value: value,
                  onChanged: (newValue) {
                    isChecked.value = newValue;
                    onChanged(newValue);
                  },
                );
              },
            ),
            hGap(5),
            Text(AppStrings.rememberMe, style: AppTextStyles.font14Medium),
          ],
        ),

        TextButton(
          onPressed: onForgetPasswordPressed,
          child: Text(
            AppStrings.forgotPassword,
            style: AppTextStyles.font14Medium.withColor(AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
