import 'package:flutter/material.dart';

import '../../functions/dashboard/table_functions.dart';
import '../../widgets/dashboard/table_widgets.dart';

class EditableTableScreen extends StatefulWidget {
  const EditableTableScreen({super.key});

  @override
  State<EditableTableScreen> createState() => _EditableTableScreenState();
}

class _EditableTableScreenState extends State<EditableTableScreen> {
  final List<Map<String, dynamic>> _data = [
    {
      'Date': DateTime.now(),
      'Échéance': '',
      'Tireur': '',
      'Client': '',
      'N': '',
      'BQ': '',
      'Montant': '',
      'Type': 'Check',
    },
    {
      'Date': DateTime.now(),
      'Échéance': '',
      'Tireur': '',
      'Client': '',
      'N': '',
      'BQ': '',
      'Montant': '',
      'Type': 'Effet',
    },
  ];

  final Map<String, FocusNode> _focusNodes = {};
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();
  late TableFunctions tableFunctions;
  late TableWidgets tableWidgets;

  @override
  void initState() {
    super.initState();
    tableFunctions = TableFunctions(
      data: _data,
      focusNodes: _focusNodes,
      setState: setState,
      context: context,
      insertNewRow: (Map<String, dynamic> newRow) {
        _data.insert(0, newRow);
      },
    );
    tableWidgets = TableWidgets(
      data: _data,
      focusNodes: _focusNodes,
      onFieldSubmission: tableFunctions.handleFieldSubmission,
      onRemoveRow: tableFunctions.removeRow,
      updateValue: tableFunctions.updateValue,
    );
    tableFunctions.initializeFocusNodes();
  }

  @override
  Widget build(BuildContext context) {
    // final isMobile = tableFunctions.isMobileView(context);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'الإجراءات',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                FloatingActionButton(
                  onPressed: tableFunctions.addNewRow,
                  tooltip: 'إضافة صف جديد',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
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
                  return SingleChildScrollView(
                    controller: _verticalScrollController,
                    child: SingleChildScrollView(
                      controller: _horizontalScrollController,
                      scrollDirection: Axis.horizontal,
                      child: tableWidgets.buildDesktopTable(),
                    ),
                  );
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
    super.dispose();
  }
}
