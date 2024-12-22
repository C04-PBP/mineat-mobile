import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mineat/app_view.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:mineat/api/device.dart';
import 'package:uuid/uuid.dart';

class FoodAddScreen extends StatefulWidget {
  final Set<String> uniqueIngredientsList;

  const FoodAddScreen({
    super.key,
    required this.uniqueIngredientsList,
  });

  @override
  State<FoodAddScreen> createState() => _FoodAddScreenState();
}

class _FoodAddScreenState extends State<FoodAddScreen> {
  final Uuid uuid = Uuid();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final Map<String, bool> _selectedIngredients = {};

  @override
  void initState() {
    super.initState();
    // Initialize _selectedIngredients with the provided Set<String>
    for (var ingredient in widget.uniqueIngredientsList) {
      _selectedIngredients[ingredient] = false;
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final selectedIngredients = _selectedIngredients.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();

      final String generatedId = uuid.v4();
      final request = context.read<CookieRequest>();

      final response = await request.postJson(
        "$device/fnb/create_flutter/",
        jsonEncode(<String, dynamic>{
          'id': generatedId,
          'title': _nameController.text,
          'description': _descriptionController.text,
          'price': _priceController.text,
          'imageUrl': _imageUrlController.text,
          'ingredients': selectedIngredients.join(', '),
        }),
      );

      if (context.mounted) {
        if (response['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Food successfully added!")),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Error occurred, please try again.")),
          );
        }
      }
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
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  labelText: "Image URL",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.url,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the image URL";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                "Select Ingredients:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300, // Specify a fixed height for the GridView
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                    childAspectRatio: 3 / 1,
                  ),
                  itemCount: widget.uniqueIngredientsList.length,
                  itemBuilder: (context, index) {
                    final ingredient = widget.uniqueIngredientsList.elementAt(index);
                    final isSelected = _selectedIngredients[ingredient] ?? false;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIngredients[ingredient] = !isSelected;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: isSelected
                              ? const Color.fromARGB(255, 255, 136, 0)
                              : const Color(0xffffd700),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          ingredient,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
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