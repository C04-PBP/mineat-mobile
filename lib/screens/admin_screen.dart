import 'package:flutter/material.dart';
import 'package:mineat/api/food_service.dart';
import 'package:mineat/screens/food_add_screen.dart';
import 'package:mineat/screens/food_delete_screen.dart';
import 'package:mineat/screens/food_edit_screen.dart'; // Import the new FoodEditScreen

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<Map<String, dynamic>> allFood = [];
  List<String> allTitles = [];
  List<String> allImageUrls = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await FoodService.fetchFoodData();
    final foods = FoodService.getFoodData();

    if (foods != null) {
      // Prepare data before updating the state
      final titles = foods.map((food) => food['title'].toString()).toList();
      final imageUrls =
          foods.map((food) => food['imageUrl'].toString()).toList();

      // Update state with prepared data
      setState(() {
        allFood = foods;
        allTitles = titles;
        allImageUrls = imageUrls;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Set<String> getUniqueIngredients(List<Map<String, dynamic>> foodList) {
    // if (foodList.isEmpty) {
    //   return [];
    // }

    final Set<String> uniqueIngredients = {};

    for (var food in foodList) {
      // Safely access the ingredients field
      final ingredientsString = food['ingredients'] as String?;
      if (ingredientsString != null) {
        final ingredients = ingredientsString.split(',').map((e) => e.trim());
        uniqueIngredients
            .addAll(ingredients.where((ingredient) => ingredient.isNotEmpty));
      }
    }
    // Convert the Set of unique ingredients into a List of Maps
    return uniqueIngredients;
    // .map((ingredient) => {'ingredient': ingredient})
    // .toList();
  }

  Widget buildRow({
    required BuildContext context,
    required String title,
    required List<String> actions,
    required Function(String) onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: actions.map((action) {
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(action),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Theme.of(context).shadowColor,
                          offset: const Offset(6, 6),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        action,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  buildRow(
                    context: context,
                    title: "Food",
                    actions: ["Add", "Edit", "Delete"],
                    onTap: (action) {
                      if (action == 'Add') {
                        if (allFood.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FoodAddScreen(
                                uniqueIngredientsList:
                                    getUniqueIngredients(allFood),
                              ),
                            ),
                          );
                        } else {
                          // Show a message if data is still loading
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Data is still loading, please wait."),
                            ),
                          );
                        }
                      } else if (action == 'Edit') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodEditScreen(
                              uniqueIngredientsList:
                                  getUniqueIngredients(allFood),
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FoodDeleteScreen()),
                        );
                      }
                    },
                  ),
                  // buildRow(
                  //   context: context,
                  //   title: "Ingredient",
                  //   actions: ["Add", "Edit", "Delete"],
                  //   onTap: (action) {
                  //     if (action == 'Add') {
                  //     } else if (action == 'Edit') {
                  //     } else {}
                  //   },
                  // ),
                  buildRow(
                    context: context,
                    title: "Restaurant",
                    actions: ["Add", "Edit", "Delete"],
                    onTap: (action) {
                      if (action == 'Add') {
                      } else if (action == 'Edit') {
                      } else {}
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
