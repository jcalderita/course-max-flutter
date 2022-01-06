import 'package:flutter/material.dart';
import 'package:meals_app/widgets/category_item.dart';
import 'package:meals_app/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25.0),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
      ),
      children: dummyCategories.map((e) => CategoryItem(e.id, e.title, e.color)).toList(),
    );
  }
}
