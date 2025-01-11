import 'package:flutter/material.dart';

class DesktopTableFunctions {
  // ...existing desktop table functions...
}

class PhoneTableFunctions {
  // ...existing phone table functions...
}

class TableFunctions {
  final List<Map<String, dynamic>> data;
  final Map<String, FocusNode> focusNodes;
  final Function setState;
  final BuildContext context;
  final Function(Map<String, dynamic>) insertNewRow;

  final TextEditingController echeanceController;
  final TextEditingController tireurController;
  final TextEditingController clientController;
  final TextEditingController nController;
  final TextEditingController bqController;
  final TextEditingController montantController;
  String selectedType;

  TableFunctions({
    required this.data,
    required this.focusNodes,
    required this.setState,
    required this.context,
    required this.insertNewRow,
    required this.echeanceController,
    required this.tireurController,
    required this.clientController,
    required this.nController,
    required this.bqController,
    required this.montantController,
    this.selectedType = 'Check',
  });

  void initializeFocusNodes() {
    focusNodes.forEach((_, node) => node.dispose());
    focusNodes.clear();

    for (var rowIndex = 0; rowIndex < data.length; rowIndex++) {
      for (var field in ['name', 'quantity', 'price']) {
        final key = '${rowIndex}_$field';
        focusNodes[key] = FocusNode();
      }
    }
  }

  bool isMobileView(BuildContext context) {
    return MediaQuery.of(context).size.width < 710;
  }

  void handleFieldSubmission(
      int rowIndex, String key, String value, TextInputType keyboardType) {
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

  void updateValue(int rowIndex, String key, dynamic value) {
    setState(() {
      data[rowIndex][key] = value;
      if (key == 'quantity' || key == 'price') {
        data[rowIndex]['total'] =
            (data[rowIndex]['quantity'] * data[rowIndex]['price'])
                .toStringAsFixed(2);
      }
    });
  }

  void addNewRow() {
    final newRow = {
      'Date': DateTime.now(),
      'Échéance': '',
      'Tireur': '',
      'Client': '',
      'N': '',
      'BQ': '',
      'Montant': '',
      'Type': 'Check',
    };
    insertNewRow(newRow);
    setState(() {
      final newRowIndex = data.length - 1;
      for (var field in [
        'Date',
        'Échéance',
        'Tireur',
        'Client',
        'N',
        'BQ',
        'Montant',
        'Type'
      ]) {
        final key = '${newRowIndex}_$field';
        focusNodes[key] = FocusNode();
      }
    });
  }

  void removeRow(int index) {
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

  void addNewRowWithData(Map<String, dynamic> newRow) {
    insertNewRow(newRow);
    setState(() {
      final newRowIndex = data.length - 1;
      for (var field in [
        'Date',
        'Échéance',
        'Tireur',
        'Client',
        'N',
        'BQ',
        'Montant',
        'Type'
      ]) {
        final key = '${newRowIndex}_$field';
        focusNodes[key] = FocusNode();
      }
    });
  }

  void submitForm() {
    final newRow = {
      'Date': DateTime.now(),
      'Échéance': echeanceController.text,
      'Tireur': tireurController.text,
      'Client': clientController.text,
      'N': nController.text,
      'BQ': bqController.text,
      'Montant': montantController.text,
      'Type': selectedType,
    };

    insertNewRow(newRow);

    // Clear form
    echeanceController.clear();
    tireurController.clear();
    clientController.clear();
    nController.clear();
    bqController.clear();
    montantController.clear();
    selectedType = 'Check';
  }
}
