// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'dart:math' show min;

// Data Models
class Product {
  final int id;
  final String name;
  Product(this.id, this.name);
}

class Size {
  final int id;
  final String name;
  Size(this.id, this.name);
}

// Rename Color to ColorModel to avoid conflict with material Color
class ColorModel {
  final int id;
  String name; // Remove final keyword to make it mutable
  ColorModel(this.id, this.name);
}

class Client {
  final int id;
  final String name;
  Client(this.id, this.name);
}

class PriceRef {
  final int id;
  final String product;
  final String size;
  final String reference;
  final String price;
  PriceRef(this.id, this.product, this.size, this.reference, this.price);
}

// Database Class
class LocalDatabase {
  static List<Product> products = [
    Product(1, "سجاد تركي"),
    Product(2, "سجاد إيراني"),
  ];

  static List<Size> sizes = [
    Size(1, "2*3"),
    Size(2, "3*4"),
  ];

  static List<ColorModel> colors = [
    ColorModel(1, "أحمر"),
    ColorModel(2, "أزرق"),
  ];

  static List<Client> clients = [
    Client(1, "محمد"),
    Client(2, "أحمد"),
  ];

  static List<PriceRef> priceRefs = [
    PriceRef(1, "سجاد تركي", "2*3", "TUR23", "1000"),
    PriceRef(2, "سجاد إيراني", "3*4", "IRN34", "2000"),
  ];
}

// Widgets Class
class CrudAsACardsWidgets {
  static Widget buildCustomTextField({
    required TextEditingController controller,
    required String hintText,
    required String labelText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  static Widget buildCustomDropdown<T>({
    required List<T> items,
    required T? selectedItem,
    required Function(T?) onChanged,
    required String labelText,
    required String Function(T) getLabel,
  }) {
    return DropdownButtonFormField<T>(
      value: selectedItem,
      items: items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(getLabel(item)),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  static Widget buildActionButton({
    required VoidCallback onPressed,
    required IconData icon,
    required Color color,
  }) {
    return IconButton(
      icon: Icon(icon, color: color),
      onPressed: onPressed,
    );
  }
}

// Functions Class
class CrudAsACardsFunctions {
  static Future<void> addItem<T>(
    BuildContext context,
    String itemType,
    Function addFunction,
  ) async {
    try {
      await addFunction();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تمت إضافة $itemType بنجاح ✅')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء إضافة $itemType ❌')),
      );
    }
  }

  static Future<void> updateItem<T>(
    BuildContext context,
    String itemType,
    Function updateFunction,
  ) async {
    try {
      await updateFunction();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم تحديث $itemType بنجاح ✅')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء تحديث $itemType ❌')),
      );
    }
  }

  static Future<void> deleteItem<T>(
    BuildContext context,
    String itemType,
    Function deleteFunction,
  ) async {
    try {
      await deleteFunction();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم حذف $itemType بنجاح ✅')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء حذف $itemType ❌')),
      );
    }
  }

  static String generateReference(String product, String size) {
    String productPrefix = product
        .substring(0, min(3, product.length))
        .toUpperCase()
        .replaceAll(RegExp(r'[^\w\s]+'), '');
    String sizeNumbers = size.replaceAll(RegExp(r'[^0-9]'), '');
    return '$productPrefix$sizeNumbers';
  }
}

// Main Widget
class DataManagement extends StatefulWidget {
  const DataManagement({super.key});

  @override
  DataManagementState createState() => DataManagementState();
}

class DataManagementState extends State<DataManagement> {
  // Controllers and Keys
  final GlobalKey colorsTileKey = GlobalKey();
  final GlobalKey sizesTileKey = GlobalKey();
  final GlobalKey clientsTileKey = GlobalKey();
  final GlobalKey productsTileKey = GlobalKey();
  final GlobalKey priceRefTileKey = GlobalKey();

  final TextEditingController colorController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController clientController = TextEditingController();
  final TextEditingController productController = TextEditingController();
  final TextEditingController referenceController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  // Selected Items
  ColorModel? selectedColorModel;
  Size? selectedSize;
  Client? selectedClient;
  Product? selectedProduct;
  PriceRef? selectedPriceRef;

  List<ColorModel> colors = LocalDatabase.colors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("إدارة البيانات"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildColorsCard(),
          ],
        ),
      ),
    );
  }

  // Build Methods for Cards
  Widget _buildColorsCard() {
    return ExpansionTile(
      key: colorsTileKey,
      title: const Text(
        'الألوان',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      subtitle: const Text(
        'يمكنك إضافة، تحديث، أو حذف الألوان',
        textAlign: TextAlign.right,
      ),
      children: [
        const Divider(thickness: 1.0, height: 1.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<ColorModel>(
                      isExpanded: true,
                      value: selectedColorModel,
                      hint: const Text("حدد اللون"),
                      items: colors
                          .map((color) => DropdownMenuItem<ColorModel>(
                                value: color,
                                child: Text(color.name),
                              ))
                          .toList(),
                      onChanged: (ColorModel? newValue) {
                        setState(() {
                          selectedColorModel = newValue;
                          colorController.text = newValue?.name ?? '';
                        });
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: selectedColorModel == null
                        ? null
                        : () {
                            updateColor(
                                selectedColorModel!.id, colorController.text);
                            setState(() {
                              selectedColorModel = null;
                              colorController.clear();
                            });
                          },
                    icon: const Icon(Icons.edit, color: Colors.blue),
                  ),
                  IconButton(
                    onPressed: selectedColorModel == null
                        ? null
                        : () {
                            deleteColor(selectedColorModel!.id);
                            setState(() {
                              selectedColorModel = null;
                            });
                          },
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: colorController,
                      decoration: const InputDecoration(
                        labelText: "إسم اللون",
                        hintText: "...إضافة أو تعديل اللون",
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (colorController.text.isNotEmpty) {
                        addColor(colorController.text);
                        colorController.clear();
                      }
                    },
                    icon: const Icon(Icons.add, color: Colors.green),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }

  void addColor(String colorName) {
    setState(() {
      colors.add(ColorModel(colors.length + 1, colorName));
    });
  }

  void updateColor(int id, String newName) {
    setState(() {
      final index = colors.indexWhere((color) => color.id == id);
      if (index != -1) {
        colors[index] = ColorModel(id, newName);
      }
    });
  }

  void deleteColor(int id) {
    setState(() {
      colors.removeWhere((color) => color.id == id);
    });
  }
}
