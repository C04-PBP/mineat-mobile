import 'package:flutter/material.dart';
import 'package:mineat/api/food_service.dart';

class FoodDeleteScreen extends StatefulWidget {
  const FoodDeleteScreen({Key? key}) : super(key: key);

  @override
  _FoodDeleteScreenState createState() => _FoodDeleteScreenState();
}

class _FoodDeleteScreenState extends State<FoodDeleteScreen> {
  List<Map<String, dynamic>> allFood = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Fetch food data from the backend
  Future<void> fetchData() async {
    try {
      final List<Map<String, dynamic>> foods = await FoodService.fetchFoodData2();
      setState(() {
        allFood = foods;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

  // Delete food item from the backend
  Future<void> deleteFood(String id) async {
    try {
      final bool success = await FoodService.deleteFoodData(id);
      if (success) {
        setState(() {
          allFood.removeWhere((food) => food['id'] == id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Food deleted successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete food.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting food: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete Food"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : allFood.isEmpty
              ? const Center(child: Text("No food items available"))
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: allFood.length,
                  itemBuilder: (context, index) {
                    final food = allFood[index];
                    return Card(
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: food['imageUrl'] != null && food['imageUrl'].isNotEmpty
                              ? Image.network(
                                  food['imageUrl'],
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/ingredients2.png',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                              : Image.asset(
                                  'assets/images/ingredients2.png',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        title: Text(food['title'] ?? 'No title'),
                        subtitle: Text(food['description'] ?? 'No description'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          // onPressed: () => print(allFood[1]['id']),
                          onPressed: () => deleteFood(food['id']),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}