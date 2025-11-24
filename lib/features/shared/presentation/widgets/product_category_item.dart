// ignore_for_file: deprecated_member_use
import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/features/product/presentation/screen/product_list_screen.dart';
import 'package:ecommerce/features/shared/presentation/models/category_model.dart';
import 'package:flutter/material.dart';

class productCategoryItem extends StatelessWidget {
  const productCategoryItem({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductListScreen.name,
          arguments: categoryModel,
        );
      },
      child: Column(
        spacing: 4,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.themeColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.network(
              categoryModel.icon,
              height: 32,
              width: 32,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error_outline, size: 32);
              },
            ),
          ),
          Text(
            _getTitleText(categoryModel.title),
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.themeColor),
          ),
        ],
      ),
    );
  }

  String _getTitleText(String text) {
    if (text.length < 12) {
      return text;
    }
    return "${text.substring(0, 9)}..";
  }
}
