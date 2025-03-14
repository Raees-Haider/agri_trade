import 'package:agri_trade/controller/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddProductsScreen extends StatefulWidget {
  const AddProductsScreen({super.key});

  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  final _formKey = GlobalKey<FormState>();
  String selectedValue = 'Kg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Products",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          scrolledUnderElevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey, // Assigning the form key
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: productController.nameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct_right),
                        labelText: "Product Name",
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Product Name cannot be empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: productController.desController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct_right),
                        labelText: "Product Description",
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Product Description cannot be empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: productController.catController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.category),
                        labelText: "Product Category",
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Product Category cannot be empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: productController.quantityController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.quote_down),
                              labelText: "Product Quantity",
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Quantity cannot be empty";
                              }
                              if (double.tryParse(value) == null) {
                                return "Enter a valid number";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('Ton'),
                      ],
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: productController.priceController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.paperclip),
                        labelText: "Product Price",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Price cannot be empty";
                        }
                        if (double.tryParse(value) == null) {
                          return "Enter a valid price";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          productController.pickImage();
                        },
                        child: const Text("Select Image"),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Obx(
                          () => SizedBox(
                        width: double.infinity,
                        child: productController.isLoading.value
                            ? const Center(
                          child: CircularProgressIndicator(),
                        )
                            : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              productController.uploadProduct();
                            }
                          },
                          child: const Text("Add Product"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ),
        );
    }
}
