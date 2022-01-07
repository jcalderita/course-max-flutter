import 'package:flutter/material.dart';
import 'package:meals_app/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildListTitle(String title, IconData icon, Function tapHandler) => ListTile(
        leading: Icon(
          icon,
          size: 26,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () => tapHandler(),
      );

  @override
  Widget build(BuildContext context) => Drawer(
        child: Column(
          children: [
            Container(
              height: 120.0,
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              alignment: Alignment.centerLeft,
              color: Theme.of(context).colorScheme.secondary,
              child: Text(
                'Cooking up!',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            buildListTitle('Meals', Icons.restaurant, () => Navigator.of(context).pushReplacementNamed('/')),
            buildListTitle(
                'Filters', Icons.settings, () => Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName)),
          ],
        ),
      );
}
