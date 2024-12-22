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
      // Prepare data before updating the state
      final titles = foods.map((food) => food['title'].toString()).toList();
      final imageUrls = foods.map((food) => food['imageUrl'].toString()).toList();

      // Update state with prepared data
      setState(() {
        allFood = foods;
        // allTitles = titles;
        // allImageUrls = imageUrls;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void navigateToEditDetail(Map<String, dynamic> food) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditFoodDetailScreen(foodData: food),
      ),
    );

    // Refetch data after editing
    fetchData();
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
                    trailing: Text('Price: Rp${food['price'] ?? '0'}'),
                    onTap: () => navigateToEditDetail(food),
                  ),
                );
              },
            ),
    );
  }
}

class EditFoodDetailScreen extends StatefulWidget {
  final Map<String, dynamic> foodData;

  const EditFoodDetailScreen({Key? key, required this.foodData}) : super(key: key);

  @override
  _EditFoodDetailScreenState createState() => _EditFoodDetailScreenState();
}

class _EditFoodDetailScreenState extends State<EditFoodDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _imageUrlController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.foodData['title']);
    _descriptionController = TextEditingController(text: widget.foodData['description']);
    _priceController = TextEditingController(text: widget.foodData['price'].toString());
    _imageUrlController = TextEditingController(text: widget.foodData['imageUrl']);
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        final updatedFood = await FoodService.updateFoodData(
          id: widget.foodData['id'],
          name: _nameController.text,
          description: _descriptionController.text,
          price: _priceController.text,
          imageUrl: _imageUrlController.text,
        );

        if (updatedFood != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Food updated successfully!")),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to update food.")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating food: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Food Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name", border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Description", border: OutlineInputBorder()),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a description";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: "Price", border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a price";
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
                decoration: const InputDecoration(labelText: "Image URL", border: OutlineInputBorder()),
                keyboardType: TextInputType.url,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter an image URL";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text("Update Food"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}