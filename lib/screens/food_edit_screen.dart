import 'package:flutter/material.dart';
import 'package:mineat/api/food_service.dart';

class FoodEditScreen extends StatefulWidget {
  const FoodEditScreen({Key? key}) : super(key: key);

  @override
  _FoodEditScreenState createState() => _FoodEditScreenState();
}

class _FoodEditScreenState extends State<FoodEditScreen> {
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
      final imageUrls = foods.map((food) => food['imageUrl'].toString()).toList();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Food"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: allFood.length,
              itemBuilder: (context, index) {
                final food = allFood[index];
                final title = allTitles[index];
                final imageUrl = allImageUrls[index];

                return Card(
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12), // Set the radius to 12
                      child: imageUrl.isNotEmpty
                          ? Image.network(
                              imageUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                // Display local asset image when network image fails
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
                    title: Text(title),
                    subtitle: Text(food['description'] ?? 'No description'),
                    trailing: Text('Price: Rp${food['price'] ?? '0'}'),
                  ),
                );
              },
            ),
    );
  }
}