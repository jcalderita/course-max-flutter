import 'package:flutter/material.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
// import 'package:meals_app/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(this.id, this.title, this.color, {Key? key}) : super(key: key);

  final String id;
  final String title;
  final Color color;

  // void selectCategory(BuildContext context) =>
  //     Navigator.of(context).push(MaterialPageRoute(builder: (_) => CategoryMealsScreen(id, title)));

  void selectCategory(BuildContext context) => Navigator.of(context).pushNamed(
        CategoryMealsScreen.routeName,
        arguments: {'id': id, 'title': title},
      );

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => selectCategory(context),
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline1,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.7),
                color,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      );
}
