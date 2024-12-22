import 'package:flutter/material.dart';
import 'package:mineat/screens/food_all_screen.dart';
import 'package:mineat/screens/home_screen.dart';

class IngredientAllScreen extends StatefulWidget {
  final List<Map<String, dynamic>> ingredientItems;
  final List<Map<String, dynamic>> foodItems;
  final String username;

  const IngredientAllScreen({
    super.key,
    required this.ingredientItems,
    required this.foodItems,
    required this.username,
  });

  @override
  _IngredientAllScreenState createState() => _IngredientAllScreenState();
}

class _IngredientAllScreenState extends State<IngredientAllScreen> {
  List<Map<String, dynamic>> filteredIngredients = [];
  List<Map<String, dynamic>> filteredFoodItems = [];
  List<String> selectedIngredients = [];

  @override
  void initState() {
    super.initState();
    filteredIngredients = widget.ingredientItems;
  }

  void _filterSearchResults(String query) {
    setState(() {
      filteredIngredients = query.isEmpty
          ? widget.ingredientItems
          : widget.ingredientItems
              .where((item) =>
                  item['ingredient']!.toLowerCase() == query.toLowerCase())
              .toList();
    });
  }

  void _toggleIngredientSelection(String ingredient) {
    setState(() {
      if (selectedIngredients.contains(ingredient)) {
        selectedIngredients.remove(ingredient);
      } else {
        selectedIngredients.add(ingredient);
      }
    });
  }

  List<Map<String, dynamic>> _showFilteredFoodItems() {
    // Filter food items to match only exact words in selectedIngredients
    return widget.foodItems.where((foodItem) {
      final ingredientsText = foodItem['ingredients'].toString().toLowerCase();
      return selectedIngredients.every((ingredient) {
        // Check for whole word matching of each selected ingredient
        final regex =
            RegExp(r'\b' + RegExp.escape(ingredient.toLowerCase()) + r'\b');
        return regex.hasMatch(ingredientsText);
      });
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Unfocuses the search bar
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Choose your ingredients",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          surfaceTintColor: Colors.white,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: SizedBox(
                height: 40,
                child: TextField(
                  onChanged: _filterSearchResults,
                  decoration: InputDecoration(
                    hintText: 'Search for an ingredient...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).shadowColor,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text("Home"),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 20,
                    childAspectRatio: 8 / 4,
                  ),
                  itemCount: filteredIngredients.length,
                  itemBuilder: (context, index) {
                    final item = filteredIngredients[index];
                    final ingredient = item['ingredient'];
                    final isSelected = selectedIngredients.contains(ingredient);

                    return GestureDetector(
                      onTap: () => _toggleIngredientSelection(ingredient),
                      child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Theme.of(context).shadowColor,
                                    offset: const Offset(6, 6),
                                  ),
                                ],
                              ),
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: isSelected
                                      ? Color.fromARGB(255, 255, 136, 0)
                                      : Color(0xffffd700),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              right: 10,
                              child: Text(
                                ingredient!,
                                style: TextStyle(
                                  color: Colors.grey.shade900,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (selectedIngredients.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodAllScreen(
                          appBarTitle: "Food Choices",
                          foodItems: _showFilteredFoodItems(),
                          username: widget.username,
                        ),
                      ),
                    );
                  },
                  child: const Text('Cook your dish'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
