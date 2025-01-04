import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Only allow digits
    final newText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    if (newText.length > 8) {
      return oldValue;
    }

    final buffer = StringBuffer();

    // Add day
    if (newText.isNotEmpty) {
      buffer
          .write(newText.substring(0, newText.length > 2 ? 2 : newText.length));
      if (newText.length > 2) buffer.write('/');
    }

    // Add month
    if (newText.length > 2) {
      buffer
          .write(newText.substring(2, newText.length > 4 ? 4 : newText.length));
      if (newText.length > 4) buffer.write('/');
    }

    // Add year
    if (newText.length > 4) {
      buffer.write(newText.substring(4));
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

bool isValidDate(String input) {
  try {
    if (input.length != 10) return false;
    final parts = input.split('/');
    if (parts.length != 3) return false;

    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);

    // Additional validation for day and month
    if (month < 1 || month > 12) return false;
    if (day < 1) return false;

    // Check days in month
    final daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    // Adjust February for leap year
    if (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) {
      daysInMonth[1] = 29;
    }

    if (day > daysInMonth[month - 1]) return false;
    if (year < DateTime.now().year) return false;

    return true;
  } catch (e) {
    return false;
  }
}

class DesktopTableWidgets {
  // ...existing desktop table widget methods...
}

class PhoneTableWidgets {
  // ...existing phone table widget methods...
}

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

  static Widget buildDateField({
    required TextEditingController controller,
    required String labelText,
    required Function(bool) onValidityChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: 'DD/MM/YYYY',
          errorStyle: const TextStyle(color: Colors.red),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        inputFormatters: [
          DateInputFormatter(),
        ],
        onChanged: (value) {
          final isValid = value.length == 10 && isValidDate(value);
          onValidityChanged(isValid);
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Date is required';
          }
          if (!isValidDate(value)) {
            return 'Invalid date format';
          }
          return null;
        },
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
            Expanded(child: Text(item['Banque '].toString())),
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
    String? hintText, // إضافة معامل جديد للنص التوضيحي
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }

  // إضافة ثوابت للتجاوب
  static const double _mobileBreakpoint = 480.0;
  static const double _tabletBreakpoint = 768.0;

  Widget buildResponsiveTable(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width < _mobileBreakpoint) {
      return _buildMobileTable();
    } else if (width < _tabletBreakpoint) {
      return _buildTabletTable();
    } else {
      return _buildDesktopTable();
    }
  }

  Widget _buildMobileTable() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: ExpansionTile(
            title: Text('Check #${data[index]['N'] ?? ''}'),
            subtitle: Text('${data[index]['Client'] ?? ''}'),
            children: [
              _buildMobileRowDetails(data[index]),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMobileRowDetails(Map<String, dynamic> rowData) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Date', rowData['Date']),
          _buildDetailRow('Échéance', rowData['Échéance']),
          _buildDetailRow('Tireur', rowData['Tireur']),
          _buildDetailRow('Montant', rowData['Montant']),
          _buildDetailRow('Type', rowData['Type']),
          _buildDetailRow('BQ', rowData['BQ']),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => onRemoveRow(data.indexOf(rowData)), // Fixed: Pass index instead of Map
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () => onRemoveRow(data.indexOf(rowData)), // Fixed: Pass index instead of Map
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value?.toString() ?? '',
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20,
        columns: _buildTableColumns(),
        rows: _buildTableRows(isCompact: true),
      ),
    );
  }

  Widget _buildDesktopTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 30,
        columns: _buildTableColumns(),
        rows: _buildTableRows(isCompact: false),
      ),
    );
  }

  List<DataColumn> _buildTableColumns() {
    return [
      _buildDataColumn('Date'),
      _buildDataColumn('Échéance'),
      _buildDataColumn('Tireur'),
      _buildDataColumn('Client'),
      _buildDataColumn('N'),
      _buildDataColumn('BQ'),
      _buildDataColumn('Montant'),
      _buildDataColumn('Type'),
      const DataColumn(label: Text('Actions')),
    ];
  }

  DataColumn _buildDataColumn(String label) {
    return DataColumn(
      label: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  List<DataRow> _buildTableRows({required bool isCompact}) {
    return data.map((row) {
      return DataRow(
        cells: [
          _buildDataCell('Date', row, isCompact),
          _buildDataCell('Échéance', row, isCompact),
          _buildDataCell('Tireur', row, isCompact),
          _buildDataCell('Client', row, isCompact),
          _buildDataCell('N', row, isCompact),
          _buildDataCell('BQ', row, isCompact),
          _buildDataCell('Montant', row, isCompact),
          _buildDataCell('Type', row, isCompact),
          DataCell(_buildActionButtons(row)),
        ],
      );
    }).toList();
  }

  DataCell _buildDataCell(String key, Map<String, dynamic> row, bool isCompact) {
    return DataCell(
      Container(
        constraints: BoxConstraints(
          maxWidth: isCompact ? 100 : 150,
        ),
        child: Text(
          row[key]?.toString() ?? '',
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildActionButtons(Map<String, dynamic> row) {
    final index = data.indexOf(row); // Get index of the row
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit, size: 20),
          onPressed: () => onRemoveRow(index), // Fixed: Pass index
          constraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red, size: 20),
          onPressed: () => onRemoveRow(index), // Fixed: Pass index
          constraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
        ),
      ],
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
  static const List<String> typeOptions = [
    'CHEQUE',
    'EFFET',
    'VIREMENT',
    'VERSEMENT',
    'AUTRES'
  ];

  List<TextEditingController> controllers =
      List.generate(8, (_) => TextEditingController());

  List<Map<String, dynamic>> sampleData = [];

  // Add this variable to track which row is being edited
  int? editingRow;

  // Add new state variables
  bool hasUnsavedChanges = false;
  bool isSaving = false;

  // Add new state variable
  bool isEcheanceValid = false;

  // Add validators
  bool validateFields() {
    if (!isEcheanceValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid date for Echeance'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    // Required fields
    if (controllers[1].text.isEmpty || // Echeance
        controllers[2].text.isEmpty || // Tireur
        controllers[3].text.isEmpty || // Client
        controllers[6].text.isEmpty) {
      // Montant
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('جميع الحقول مطلوبة: الاستحقاق، الساحب، العميل، والمبلغ'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    // Validate Montant
    try {
      double.parse(controllers[6].text.replaceAll(',', '.'));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('المبلغ يجب أن يكون رقماً صحيحاً أو عشرياً'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    return true;
  }

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
    if (!validateFields()) return;

    setState(() {
      String montantValue = controllers[6].text.replaceAll(',', '.');
      double montantDouble = double.parse(montantValue);

      controllers[0].text =
          "${DateFormat('HH:mm').format(DateTime.now())} \n ${DateFormat('yyyy/MM/dd').format(DateTime.now())}";
      sampleData.add({
        'Date': controllers[0].text,
        'Echeance': controllers[1].text,
        'Tireur': controllers[2].text,
        'Client': controllers[3].text,
        'N°': controllers[4].text,
        'Banque': controllers[5].text,
        'Montant': montantDouble.toStringAsFixed(2),
        'Type':
            controllers[7].text.isEmpty ? typeOptions[0] : controllers[7].text,
      });

      // Clear all controllers
      for (var controller in controllers) {
        controller.clear();
      }
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
    'Date',
    'Echeance',
    'Tireur',
    'Client',
    'N°',
    'Banque ',
    'Montant',
    'Type',
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
                    i == 1
                        ? TableWidgets.buildDateField(
                            controller: controllers[i],
                            labelText: headersOfTheTable[i],
                            onValidityChanged: (isValid) {
                              setState(() {
                                isEcheanceValid = isValid;
                              });
                            },
                          )
                        : TableWidgets.customTextField(
                            controller: controllers[i],
                            labelText:
                                headersOfTheTable[i], // Fixed syntax here
                          ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                        onPressed: addRow,
                        child: const Icon(color: Colors.white, Icons.add)),
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
                  TableWidgets.customHeaderText(text: 'N°'),
                  TableWidgets.customHeaderText(text: 'Banque'),
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
                        item['Date']?.toString() ?? '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    for (String key in [
                      'Echeance',
                      'Tireur',
                      'Client',
                      'N°',
                      'Banque',
                      'Montant'
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

  // Add new state variable
  bool isEcheanceValid = false;

  // Add validators
  bool validateFields() {
    // Required fields validation
    if (!isEcheanceValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid date for Echeance'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    if (controllers[1].text.isEmpty || // Echeance
        controllers[2].text.isEmpty || // Tireur
        controllers[3].text.isEmpty || // Client
        controllers[6].text.isEmpty) {
      // Montant
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('جميع الحقول مطلوبة: الاستحقاق، الساحب، العميل، والمبلغ'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    // Montant validation
    try {
      double.parse(controllers[6].text.replaceAll(',', '.'));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('المبلغ يجب أن يكون رقماً صحيحاً أو عشرياً'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    return true;
  }

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

  // Modify addRow to include validation
  void addRow() {
    if (!validateFields()) return;

    setState(() {
      String montantValue = controllers[6].text.replaceAll(',', '.');
      double montantDouble = double.parse(montantValue);

      controllers[0].text =
          "${DateFormat('HH:mm').format(DateTime.now())} \n ${DateFormat('YYYY/MM/DD').format(DateTime.now())}";
      sampleData.add({
        'date': controllers[0].text,
        'echeance': controllers[1].text,
        'tireur': controllers[2].text,
        'client': controllers[3].text,
        'n': controllers[4].text,
        'bq': controllers[5].text,
        'montant': montantDouble.toStringAsFixed(2),
        'type':
            controllers[7].text.isEmpty ? typeOptions[0] : controllers[7].text,
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
                    i == 1
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: TableWidgets.buildDateField(
                              controller: controllers[i],
                              labelText: 'Echeance',
                              onValidityChanged: (isValid) {
                                setState(() {
                                  isEcheanceValid = isValid;
                                });
                              },
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: TextField(
                              controller: controllers[i],
                              decoration: InputDecoration(
                                labelText: [
                                  'Date',
                                  'Echeance',
                                  'Tireur',
                                  'Client',
                                  'N°',
                                  'Banque ',
                                  'Montant',
                                  'Type'
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
