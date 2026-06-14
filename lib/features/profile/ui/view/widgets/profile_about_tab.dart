import 'package:flutter/material.dart';

import '../../../../../core/assets/app_strings.dart';
import '../../../../../core/theme/app_text_styles.dart';

class ProfileAboutTab extends StatelessWidget {
  const ProfileAboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Text(
        AppStrings.eventDescription,
        style: AppTextStyles.font14Regular,
      ),
    );
  }
}
