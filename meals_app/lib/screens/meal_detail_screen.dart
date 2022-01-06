import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({Key? key}) : super(key: key);

  static const routeName = '/meal-detail';

  Widget buildSectionTitle(BuildContext context, String text) => SizedBox(
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline1,
        ),
      );

  Widget buildContainer(Widget child) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        height: 200,
        width: 300,
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final meal = dummyMeals.firstWhere((e) => e.id == mealId);
    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 300.0,
                width: double.infinity,
                child: Image.network(
                  meal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              buildSectionTitle(context, 'Ingredients'),
              buildContainer(
                ListView.builder(
                  itemBuilder: (context, index) => Card(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(meal.ingredients[index]),
                    ),
                  ),
                  itemCount: meal.ingredients.length,
                ),
              ),
              buildSectionTitle(context, 'Steps'),
              buildContainer(
                ListView.builder(
                  itemBuilder: (context, index) => Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          child: Text('# ${index + 1}'),
                        ),
                        title: Text(meal.steps[index]),
                      ),
                      const Divider(),
                    ],
                  ),
                  itemCount: meal.steps.length,
                ),
              )
            ],
          ),
        ));
  }
}
