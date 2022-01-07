import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  // const CategoryMealsScreen(this.categoryId, this.categoryTitle, {Key? key}) : super(key: key);
  const CategoryMealsScreen(this.availableMeals, {Key? key}) : super(key: key);

  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle = '';
  List<Meal> meals = [];

  @override
  void didChangeDependencies() {
    final routeArguments = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryId = routeArguments['id'];
    categoryTitle = routeArguments['title'] ?? '';
    meals = widget.availableMeals.where((e) => e.categories.contains(categoryId)).toList();
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) => setState(() => meals.removeWhere((element) => element.id == mealId));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final meal = meals[index];
          return MealItem(
            id: meal.id,
            title: meal.title,
            imageUrl: meal.imageUrl,
            duration: meal.duration,
            complexity: meal.complexity,
            affordability: meal.affordability,
          );
        },
        itemCount: meals.length,
      ),
    );
  }
}
