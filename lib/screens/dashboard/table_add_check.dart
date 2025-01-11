// table_add_check.dart
import 'package:flutter/material.dart';
import '../../functions/dashboard/table_functions.dart';
import '../../widgets/dashboard/table_widgets.dart';

class TableAddCheck extends StatefulWidget {
  const TableAddCheck({super.key});

  @override
  State<TableAddCheck> createState() => _TableAddCheckState();
}

class _TableAddCheckState extends State<TableAddCheck> {
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
  final rowDecoration = BoxDecoration(
    color: Colors.grey.shade50.withValues(alpha: 0.9),
    border: Border(
      bottom: BorderSide(
        color: Colors.grey.withValues(alpha: 0.1),
        width: 1,
      ),
    ),
  );

  late TableFunctions tableFunctions;
  late TableWidgets tableWidgets;

  List<Map<String, dynamic>> sampleData = [];

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
      // Add new controller parameters
      echeanceController: _echeanceController,
      tireurController: _tireurController,
      clientController: _clientController,
      nController: _nController,
      bqController: _bqController,
      montantController: _montantController,
    );
    tableWidgets = TableWidgets(
      data: _data,
      focusNodes: _focusNodes,
      onFieldSubmission: tableFunctions.handleFieldSubmission,
      onRemoveRow: tableFunctions.removeRow,
      updateValue: tableFunctions.updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableWidgets.buildInputForm(
            context,
            tableFunctions: tableFunctions,
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
                  return const DesktopTable();
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
