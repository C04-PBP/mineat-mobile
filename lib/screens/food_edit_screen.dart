import 'package:flutter/material.dart';
import 'package:mineat/api/food_service.dart';

class FoodEditScreen extends StatefulWidget {
  const FoodEditScreen({Key? key}) : super(key: key);

  @override
  _FoodEditScreenState createState() => _FoodEditScreenState();
}

class _FoodEditScreenState extends State<FoodEditScreen> {
  List<Map<String, dynamic>> allFood = [];
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
      setState(() {
        allFood = foods;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Food"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: allFood.map((food) {
                return Card(
                  child: ListTile(
                    leading: food['imageUrl'] != null
                        ? Image.network(
                            food['imageUrl'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.fastfood),
                    title: Text(food['title'] ?? 'Unnamed Food'),
                    subtitle: Text(food['description'] ?? 'No description'),
                    trailing: Text('Price: Rp${food['price'] ?? '0'}'),
                  ),
                );
              }).toList(),
            ),
    );
  }
}