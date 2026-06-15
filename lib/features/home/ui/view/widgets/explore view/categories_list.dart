import 'package:flutter/material.dart';

import '../../../../../../core/helpers/spacing.dart';
import '../../../../data/entities/home_category_entity.dart';
import 'category_item.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key, required this.categories});

  final List<HomeCategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.048,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        separatorBuilder: (context, index) => hGap(10),
        itemBuilder: (context, index) {
          return CategoryItem(category: categories[index]);
        },
      ),
    );
  }
}
