import 'package:flutter/material.dart';
import 'package:mineat/screens/food_add_screen.dart';
import 'package:mineat/screens/food_delete_screen.dart';
import 'package:mineat/screens/food_edit_screen.dart'; // Import the new FoodEditScreen

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildRow(
              context: context,
              title: "Food",
              actions: ["Add", "Edit", "Delete"],
              onTap: (action) {
                if (action == 'Add') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FoodAddScreen()),
                  );
                } else if (action == 'Edit') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FoodEditScreen()),
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
            buildRow(
              context: context,
              title: "Ingredient",
              actions: ["Add", "Edit", "Delete"],
              onTap: (action) {
                if (action == 'Add') {
                } else if (action == 'Edit') {
                } else {}
              },
            ),
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
            buildRow(
              context: context,
              title: "District",
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
