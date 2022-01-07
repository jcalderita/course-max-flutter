import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen(this.currentFilters, this.saveFilters, {Key? key}) : super(key: key);

  static const routeName = '/filters';

  final Map<String, bool> currentFilters;
  final Function saveFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten'] as bool;
    _vegetarian = widget.currentFilters['vegetarian'] as bool;
    _vegan = widget.currentFilters['vegan'] as bool;
    _lactoseFree = widget.currentFilters['lactose'] as bool;
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String subTitle, bool currentValue, Function updateValue) {
    return SwitchListTile(
      activeColor: Theme.of(context).colorScheme.secondary,
      title: Text(title),
      value: currentValue,
      subtitle: Text(subTitle),
      onChanged: updateValue as void Function(bool?),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
        actions: [
          IconButton(
            onPressed: () => widget.saveFilters({
              'gluten': _glutenFree,
              'lactose': _lactoseFree,
              'vegan': _vegan,
              'vegetarian': _vegetarian,
            }),
            icon: const Icon(Icons.save),
          )
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(
              20.0,
            ),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile('Gluten-free', 'Only include gluten-free meals.', _glutenFree,
                  (val) => setState(() => _glutenFree = val)),
              _buildSwitchListTile('Lactose-free', 'Only include lactose-free meals.', _lactoseFree,
                  (val) => setState(() => _lactoseFree = val)),
              _buildSwitchListTile('Vegetarian', 'Only include vegetarian meals.', _vegetarian,
                  (val) => setState(() => _vegetarian = val)),
              _buildSwitchListTile('Vegan', 'Only include vegam meals.', _vegan, (val) => setState(() => _vegan = val)),
            ],
          ))
        ],
      ),
    );
  }
}
