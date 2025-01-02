import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TableWidgets {
  final List<Map<String, dynamic>> data;
  final Map<String, FocusNode> focusNodes;
  final Function(int, String, String, TextInputType) onFieldSubmission;
  final Function(int) onRemoveRow;
  final Function(int, String, dynamic) updateValue;

  TableWidgets({
    required this.data,
    required this.focusNodes,
    required this.onFieldSubmission,
    required this.onRemoveRow,
    required this.updateValue,
  });

  /// Builds an editable cell for the table.
  static Widget buildEditableCell(
    int index,
    String labelText,
    TextInputType keyboardType, {
    required void Function(String) onChanged,
    String? initialValue,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget buildMobileField(
      String label, int rowIndex, String key, TextInputType keyboardType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: TableWidgets.buildEditableCell(
              rowIndex,
              key,
              TextInputType.text,
              onChanged: (String value) {
                // Add logic here to handle the changed value
                // ignore: avoid_print
                print('Value changed: $value');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTableRow(int index, Map<String, dynamic> item, bool isMobile) {
    if (isMobile) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date: ${item['Date']}'),
              Text('Échéance: ${item['Échéance']}'),
              Text('Tireur: ${item['Tireur']}'),
              Text('Client: ${item['Client']}'),
              Text('N: ${item['N']}'),
              Text('BQ: ${item['BQ']}'),
              Text('Montant: ${item['Montant']}'),
              Text('Type: ${item['Type']}'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => onRemoveRow(index),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: index % 2 == 0 ? Colors.white : Colors.grey.shade50,
        ),
        child: Row(
          children: [
            Expanded(child: Text(item['Date'].toString())),
            Expanded(child: Text(item['Échéance'].toString())),
            Expanded(child: Text(item['Tireur'].toString())),
            Expanded(child: Text(item['Client'].toString())),
            Expanded(child: Text(item['N'].toString())),
            Expanded(child: Text(item['BQ'].toString())),
            Expanded(child: Text(item['Montant'].toString())),
            Expanded(child: Text(item['Type'].toString())),
            SizedBox(
              width: 80,
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onRemoveRow(index),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  List<Map<String, dynamic>> sampleData = [
    {
      'date': '02/01/2025',
      'echeance': '06/01/2025',
      'tireur': 'Jane Doe',
      'client': 'Client B',
      'n': '124',
      'bq': 'Bank ABC',
      'montant': '2000 MAD',
    },
  ]; // قائمة البيانات فارغة

  static Widget customHeaderText({required String text}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  static Widget customTextField({
    required TextEditingController controller,
    required String labelText,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: labelText),
      ),
    );
  }
}

class DesktopTable extends StatefulWidget {
  const DesktopTable({super.key});

  @override
  DesktopTableState createState() => DesktopTableState();
}

class DesktopTableState extends State<DesktopTable> {
  // Add constant for valid type options
  static const List<String> typeOptions = ['شيك', 'كمبيالا', 'effet'];

  List<TextEditingController> controllers =
      List.generate(8, (_) => TextEditingController());

  List<Map<String, dynamic>> sampleData = [];

  // Add this variable to track which row is being edited
  int? editingRow;

  // Add new state variables
  bool hasUnsavedChanges = false;
  bool isSaving = false;

  // Add method to handle save operation
  Future<void> handleSave() async {
    setState(() {
      isSaving = true;
    });

    // Simulate API call or save operation
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isSaving = false;
      hasUnsavedChanges = false;
    });
  }

  // Modify addRow to set hasUnsavedChanges
  void addRow() {
    bool hasValues =
        controllers.any((controller) => controller.text.isNotEmpty);

    if (!hasValues) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill at least one field')),
      );
      return;
    }

    // Validate type value
    String typeValue =
        controllers[7].text.isEmpty ? 'Type A' : controllers[7].text;
    if (!typeOptions.contains(typeValue)) {
      typeValue = 'Type A'; // Default to Type A if invalid value
    }

    setState(() {
      controllers[0].text =
          "${DateFormat('HH:mm').format(DateTime.now())} \n ${DateFormat('yyyy-MM-dd').format(DateTime.now())}";
      sampleData.add({
        'date': controllers[0].text,
        'echeance': controllers[1].text,
        'tireur': controllers[2].text,
        'client': controllers[3].text,
        'n': controllers[4].text,
        'bq': controllers[5].text,
        'montant': controllers[6].text,
        'type': typeValue,
      });

      // Clear all controllers
      for (var controller in controllers) {
        controller.clear();
      }

      // Set unsaved changes flag
      hasUnsavedChanges = true;
    });
  }

  // Modify updateValue to set hasUnsavedChanges
  void updateValue(int index, String key, dynamic value) {
    setState(() {
      sampleData[index][key] = value;
      hasUnsavedChanges = true;
    });
  }

  // Add this method to toggle edit mode
  void toggleEditMode(int index) {
    setState(() {
      editingRow = editingRow == index ? null : index;
    });
  }

  // Add delete row method with confirmation dialog
  Future<void> deleteRow(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: const Text('هل أنت متأكد من حذف هذا السطر؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        sampleData.removeAt(index);
        hasUnsavedChanges = true; // Mark that we have unsaved changes
      });
    }
  }

  List<String> headersOfTheTable = [
    'date',
    'echeance',
    'tireur',
    'client',
    'N°',
    'banque ',
    'montant',
    'type',
  ];

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double columnWidth = (constraints.maxWidth - 120) /
            9; // subtract actions column width and divide by number of columns

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Table(
            border: TableBorder.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: {
              for (int i = 0; i < 8; i++) i: FixedColumnWidth(columnWidth),
              8: const FixedColumnWidth(120),
            },
            children: [
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        backgroundColor:
                            hasUnsavedChanges ? Colors.orange : Colors.green,
                      ),
                      onPressed: isSaving
                          ? null
                          : (hasUnsavedChanges ? handleSave : null),
                      child: isSaving
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              hasUnsavedChanges ? 'هناك تعديلات' : 'حفظ',
                              style: const TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                  for (int i = 1; i < 8; i++)
                    TableWidgets.customTextField(
                      controller: controllers[i],
                      labelText: headersOfTheTable[i], // Fixed syntax here
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: addRow,
                      child: const Text('إضافة'),
                    ),
                  ),
                ],
              ),
              TableRow(
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F5F5),
                ),
                children: [
                  TableWidgets.customHeaderText(text: 'Date'),
                  TableWidgets.customHeaderText(text: 'Échéance'),
                  TableWidgets.customHeaderText(text: 'Tireur'),
                  TableWidgets.customHeaderText(text: 'Client'),
                  TableWidgets.customHeaderText(text: 'N'),
                  TableWidgets.customHeaderText(text: 'BQ'),
                  TableWidgets.customHeaderText(text: 'Montant'),
                  TableWidgets.customHeaderText(text: 'Type'),
                  TableWidgets.customHeaderText(text: 'الإجراءات'),
                ],
              ),
              ...sampleData.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final bool isEditing = editingRow == index;

                return TableRow(
                  decoration: BoxDecoration(
                    color: index % 2 == 0 ? Colors.white : Colors.grey.shade50,
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item['date'],
                        textAlign: TextAlign.center,
                      ),
                    ),
                    for (String key in [
                      'echeance',
                      'tireur',
                      'client',
                      'n',
                      'bq',
                      'montant'
                    ])
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: isEditing
                            ? TableWidgets.buildEditableCell(
                                index,
                                key,
                                TextInputType.text,
                                onChanged: (String value) {
                                  updateValue(index, key, value);
                                },
                                initialValue: item[key],
                              )
                            : Text(
                                item[key]?.toString() ?? '',
                                textAlign: TextAlign.center,
                              ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: isEditing
                          ? DropdownButton<String>(
                              value: typeOptions.contains(item['type'])
                                  ? item['type']
                                  : typeOptions[0],
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String? value) {
                                if (value != null) {
                                  updateValue(index, 'type', value);
                                }
                              },
                              items: typeOptions.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )
                          : Text(
                              item['type']?.toString() ?? '',
                              textAlign: TextAlign.center,
                            ),
                    ),
                    // Actions column
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              isEditing ? Icons.save : Icons.edit,
                              color: isEditing ? Colors.green : Colors.blue,
                            ),
                            onPressed: () => toggleEditMode(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteRow(index),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

class PhoneTable extends StatefulWidget {
  const PhoneTable({super.key});

  @override
  State<PhoneTable> createState() => PhoneTableState(); // Fixed return type
}

class PhoneTableState extends State<PhoneTable> {
  // Fixed State class declaration
  static const List<String> typeOptions = ['Type A', 'Type B', 'Type C'];
  List<TextEditingController> controllers =
      List.generate(8, (_) => TextEditingController());
  List<Map<String, dynamic>> sampleData = [];
  int? editingRow;
  bool hasUnsavedChanges = false;
  bool isSaving = false;

  Future<void> handleSave() async {
    setState(() {
      isSaving = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isSaving = false;
      hasUnsavedChanges = false;
    });
  }

  void addRow() {
    if (!controllers.any((controller) => controller.text.isNotEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى ملء حقل واحد على الأقل')),
      );
      return;
    }

    setState(() {
      controllers[0].text =
          "${DateFormat('HH:mm').format(DateTime.now())} \n ${DateFormat('yyyy-MM-dd').format(DateTime.now())}";
      sampleData.add({
        'date': controllers[0].text,
        'echeance': controllers[1].text,
        'tireur': controllers[2].text,
        'client': controllers[3].text,
        'n': controllers[4].text,
        'bq': controllers[5].text,
        'montant': controllers[6].text,
        'type': controllers[7].text.isEmpty ? 'Type A' : controllers[7].text,
      });

      for (var controller in controllers) {
        controller.clear();
      }
      hasUnsavedChanges = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Add Row Form
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  for (int i = 1; i < controllers.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: TextField(
                        controller: controllers[i],
                        decoration: InputDecoration(
                          labelText: [
                            'التاريخ',
                            'الاستحقاق',
                            'الساحب',
                            'العميل',
                            'الرقم',
                            'البنك',
                            'المبلغ',
                            'النوع'
                          ][i],
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: addRow,
                          child: const Text('إضافة صف جديد'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Save Button
          if (hasUnsavedChanges)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: isSaving ? null : handleSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: isSaving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('حفظ التغييرات'),
              ),
            ),

          // Data List
          Expanded(
            child: ListView.builder(
              itemCount: sampleData.length,
              itemBuilder: (context, index) {
                final item = sampleData[index];
                final bool isEditing = editingRow == index;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ExpansionTile(
                    title: Text('${item['tireur']} - ${item['date']}'),
                    subtitle: Text('${item['montant']} DH'),
                    children: [
                      if (isEditing)
                        _buildEditableFields(item, index)
                      else
                        _buildReadOnlyFields(item),
                      OverflowBar(
                        // Replaced ButtonBar with OverflowBar
                        children: [
                          IconButton(
                            icon: Icon(
                              isEditing ? Icons.save : Icons.edit,
                              color: isEditing ? Colors.green : Colors.blue,
                            ),
                            onPressed: () => setState(() {
                              editingRow = isEditing ? null : index;
                            }),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteRow(index),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableFields(Map<String, dynamic> item, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          for (String field in [
            'echeance',
            'tireur',
            'client',
            'n',
            'bq',
            'montant'
          ])
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: TextField(
                controller: TextEditingController(
                    text: item[field]?.toString()), // Fixed initialValue
                decoration: InputDecoration(labelText: field),
                onChanged: (value) => setState(() {
                  item[field] = value;
                  hasUnsavedChanges = true;
                }),
              ),
            ),
          DropdownButton<String>(
            value: typeOptions.contains(item['type'])
                ? item['type']
                : typeOptions[0],
            items: typeOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              if (value != null) {
                setState(() {
                  item['type'] = value;
                  hasUnsavedChanges = true;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReadOnlyFields(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('تاريخ الاستحقاق: ${item['echeance']}'),
          Text('العميل: ${item['client']}'),
          Text('الرقم: ${item['n']}'),
          Text('البنك: ${item['bq']}'),
          Text('النوع: ${item['type']}'),
        ],
      ),
    );
  }

  Future<void> _deleteRow(int index) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: const Text('هل أنت متأكد من حذف هذا السطر؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        sampleData.removeAt(index);
        hasUnsavedChanges = true;
      });
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
