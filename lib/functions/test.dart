import 'package:flutter/material.dart';

class TableFunctions {
  // Data handling functions
  static List<Map<String, dynamic>> initializeData() {
    return [
      {'name': 'Product 1', 'quantity': 10, 'price': 50.0, 'total': 500.0},
      {'name': 'Product 2', 'quantity': 5, 'price': 100.0, 'total': 500.0},
    ];
  }

  static void initializeFocusNodes(Map<String, FocusNode> focusNodes, List<Map<String, dynamic>> data) {
    focusNodes.forEach((_, node) => node.dispose());
    focusNodes.clear();

    for (var rowIndex = 0; rowIndex < data.length; rowIndex++) {
      for (var field in ['name', 'quantity', 'price']) {
        final key = '${rowIndex}_$field';
        focusNodes[key] = FocusNode();
      }
    }
  }

  static bool isMobileView(BuildContext context) {
    return MediaQuery.of(context).size.width < 710;
  }

  static void handleFieldSubmission(
    BuildContext context,
    int rowIndex,
    String key,
    String value,
    TextInputType keyboardType,
    List<Map<String, dynamic>> data,
    Map<String, FocusNode> focusNodes,
    Function(int, String, dynamic) updateValue,
  ) {
    dynamic processedValue = value;
    if (keyboardType == TextInputType.number) {
      processedValue = key == 'price'
          ? double.tryParse(value) ?? 0.0
          : int.tryParse(value) ?? 0;
    }
    updateValue(rowIndex, key, processedValue);

    final fields = ['name', 'quantity', 'price'];
    final currentFieldIndex = fields.indexOf(key);
    final nextFieldIndex = (currentFieldIndex + 1) % fields.length;
    final nextRowIndex =
        nextFieldIndex == 0 ? (rowIndex + 1) % data.length : rowIndex;
    final nextField = fields[nextFieldIndex];
    final nextFocusKey = '${nextRowIndex}_$nextField';

    if (focusNodes.containsKey(nextFocusKey)) {
      FocusScope.of(context).requestFocus(focusNodes[nextFocusKey]);
    }
  }

  static void addNewRow(
    List<Map<String, dynamic>> data,
    Map<String, FocusNode> focusNodes,
    Function setState,
  ) {
    setState(() {
      data.add({
        'name': '',
        'quantity': 0,
        'price': 0.0,
        'total': '0.00',
      });
      final newRowIndex = data.length - 1;
      for (var field in ['name', 'quantity', 'price']) {
        final key = '${newRowIndex}_$field';
        focusNodes[key] = FocusNode();
      }
    });
  }

  static void removeRow(
    BuildContext context,
    int index,
    List<Map<String, dynamic>> data,
    Map<String, FocusNode> focusNodes,
    Function setState,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: const Text('هل أنت متأكد من حذف هذا الصف؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                for (var field in ['name', 'quantity', 'price']) {
                  final key = '${index}_$field';
                  focusNodes[key]?.dispose();
                  focusNodes.remove(key);
                }
                data.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('حذف', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  static void updateValue(
    int rowIndex,
    String key,
    dynamic value,
    List<Map<String, dynamic>> data,
    Function setState,
  ) {
    setState(() {
      data[rowIndex][key] = value;
      if (key == 'quantity' || key == 'price') {
        final quantity = data[rowIndex]['quantity'] as num;
        final price = data[rowIndex]['price'] as num;
        data[rowIndex]['total'] = (quantity * price).toStringAsFixed(2);
      }
    });
  }
}