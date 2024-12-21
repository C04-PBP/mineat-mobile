import 'package:flutter/material.dart';

class FoodAddScreen extends StatefulWidget {
  const FoodAddScreen({Key? key}) : super(key: key);

  @override
  State<FoodAddScreen> createState() => _FoodAddScreenState();
}

class _FoodAddScreenState extends State<FoodAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final List<String> _ingredients = [
    "Tomato",
    "Cheese",
    "Basil",
    "Chicken",
    "Beef",
    "Lettuce",
  ];

  final Map<String, bool> _selectedIngredients = {};

  @override
  void initState() {
    super.initState();
    for (var ingredient in _ingredients) {
      _selectedIngredients[ingredient] = false;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final selectedIngredients = _selectedIngredients.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();

      // Perform the add food action here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Food Added: ${_nameController.text}, Ingredients: ${selectedIngredients.join(', ')}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Food"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Add New Food",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the food name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the description";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: "Price",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the price";
                  }
                  if (double.tryParse(value) == null) {
                    return "Please enter a valid number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                "Select Ingredients:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ..._ingredients.map((ingredient) {
                return CheckboxListTile(
                  title: Text(ingredient),
                  value: _selectedIngredients[ingredient],
                  onChanged: (bool? value) {
                    setState(() {
                      _selectedIngredients[ingredient] = value ?? false;
                    });
                  },
                );
              }).toList(),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                  ),
                  child: const Text(
                    "Add Food",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}