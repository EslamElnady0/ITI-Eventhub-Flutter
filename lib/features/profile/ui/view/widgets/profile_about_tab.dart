import 'package:flutter/material.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/colors.dart';

class ProfileAboutTab extends StatefulWidget {
  const ProfileAboutTab({
    super.key,
    required this.about,
    required this.isSaving,
    required this.onSave,
  });

  final String about;
  final bool isSaving;
  final ValueChanged<String> onSave;

  @override
  State<ProfileAboutTab> createState() => _ProfileAboutTabState();
}

class _ProfileAboutTabState extends State<ProfileAboutTab> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.about);
  }

  @override
  void didUpdateWidget(covariant ProfileAboutTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.about != widget.about && _controller.text != widget.about) {
      _controller.text = widget.about;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            minLines: 5,
            maxLines: 8,
            decoration: InputDecoration(
              hintText: 'Tell people about yourself.',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.primaryColor),
              ),
            ),
            style: AppTextStyles.font14Regular,
          ),
          vGap(16),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              onPressed: widget.isSaving
                  ? null
                  : () => widget.onSave(_controller.text),
              child: Text(widget.isSaving ? 'Saving...' : 'Save'),
            ),
          ),
        ],
      ),
    );
  }
}
