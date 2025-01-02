// table_add_check.dart
import 'package:flutter/material.dart';
import '../../functions/dashboard/table_functions.dart';
import '../../widgets/dashboard/table_widgets.dart';

class EditableTableScreen extends StatefulWidget {
  const EditableTableScreen({super.key});

  @override
  State<EditableTableScreen> createState() => _EditableTableScreenState();
}

class _EditableTableScreenState extends State<EditableTableScreen> {
  final List<Map<String, dynamic>> _data = [];
  final Map<String, FocusNode> _focusNodes = {};
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

  // Form controllers
  final TextEditingController _echeanceController = TextEditingController();
  final TextEditingController _tireurController = TextEditingController();
  final TextEditingController _clientController = TextEditingController();
  final TextEditingController _nController = TextEditingController();
  final TextEditingController _bqController = TextEditingController();
  final TextEditingController _montantController = TextEditingController();
  String _selectedType = 'Check';

  late TableFunctions tableFunctions;
  late TableWidgets tableWidgets;

  List<Map<String, dynamic>> sampleData = [
    {
      'date': '01/01/2025',
      'echeance': '05/01/2025',
      'tireur': 'John Doe',
      'client': 'Client A',
      'n': '123',
      'bq': 'Bank XYZ',
      'montant': '1000 MAD',
      'type': 'Credit',
    },
    {
      'date': '02/01/2025',
      'echeance': '06/01/2025',
      'tireur': 'Jane Doe',
      'client': 'Client B',
      'n': '124',
      'bq': 'Bank ABC',
      'montant': '2000 MAD',
      'type': 'Debit',
    },
  ];

  @override
  void initState() {
    super.initState();
    tableFunctions = TableFunctions(
      data: _data,
      focusNodes: _focusNodes,
      setState: setState,
      context: context,
      insertNewRow: (Map<String, dynamic> newRow) {
        setState(() {
          _data.insert(0, newRow);
        });
      },
    );
    tableWidgets = TableWidgets(
      data: _data,
      focusNodes: _focusNodes,
      onFieldSubmission: tableFunctions.handleFieldSubmission,
      onRemoveRow: tableFunctions.removeRow,
      updateValue: tableFunctions.updateValue,
    );
  }

  void _submitForm() {
    final newRow = {
      'Date': DateTime.now(),
      'Échéance': _echeanceController.text,
      'Tireur': _tireurController.text,
      'Client': _clientController.text,
      'N': _nController.text,
      'BQ': _bqController.text,
      'Montant': _montantController.text,
      'Type': _selectedType,
    };

    setState(() {
      _data.insert(0, newRow);
      // Clear form
      _echeanceController.clear();
      _tireurController.clear();
      _clientController.clear();
      _nController.clear();
      _bqController.clear();
      _montantController.clear();
      _selectedType = 'Check';
    });
  }

  Widget _buildInputForm() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'إضافة سجل جديد',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _echeanceController,
                    decoration: const InputDecoration(
                      labelText: 'Échéance',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _tireurController,
                    decoration: const InputDecoration(
                      labelText: 'Tireur',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _clientController,
                    decoration: const InputDecoration(
                      labelText: 'Client',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _nController,
                    decoration: const InputDecoration(
                      labelText: 'N',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _bqController,
                    decoration: const InputDecoration(
                      labelText: 'BQ',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _montantController,
                    decoration: const InputDecoration(
                      labelText: 'Montant',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedType,
                    decoration: const InputDecoration(
                      labelText: 'Type',
                      border: OutlineInputBorder(),
                    ),
                    items: ['Check', 'Effet'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('إضافة السجل'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildInputForm(),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _data.length,
                    itemBuilder: (context, index) {
                      return tableWidgets.buildTableRow(
                          index, _data[index], true);
                    },
                  );
                } else {
                  return const DesktopTable();
                  // return SingleChildScrollView(
                  //   controller: _verticalScrollController,
                  //   child: SingleChildScrollView(
                  //     controller: _horizontalScrollController,
                  //     scrollDirection: Axis.horizontal,
                  //     child: tableWidgets.buildDesktopTable(),
                  //   ),
                  // );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _focusNodes.forEach((_, node) => node.dispose());
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    _echeanceController.dispose();
    _tireurController.dispose();
    _clientController.dispose();
    _nController.dispose();
    _bqController.dispose();
    _montantController.dispose();
    super.dispose();
  }
}
