// table_add_check.dart
import 'package:flutter/material.dart';
import '../../functions/dashboard/table_functions.dart';
import 'table_widgets.dart';


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
  ];

  // إضافة ثوابت للاستجابة
  static const double _mobileThreshold = 480.0;    // عتبة الموبايل
  static const double _tabletThreshold = 768.0;    // عتبة التابلت

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
      margin: EdgeInsets.all(MediaQuery.of(context).size.width > _mobileThreshold ? 16 : 8),
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width > _mobileThreshold ? 16 : 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'إضافة سجل جديد',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // تحسين تخطيط النموذج بناءً على حجم الشاشة
            if (MediaQuery.of(context).size.width >= _tabletThreshold)
              _buildDesktopLayout()
            else
              _buildMobileLayout(),
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

  // إضافة طرق جديدة للتخطيطات المختلفة
  Widget _buildDesktopLayout() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildEcheanceField()),
            const SizedBox(width: 16),
            Expanded(child: _buildTireurField()),
            const SizedBox(width: 16),
            Expanded(child: _buildClientField()),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildNField()),
            const SizedBox(width: 16),
            Expanded(child: _buildBQField()),
            const SizedBox(width: 16),
            Expanded(child: _buildMontantField()),
            const SizedBox(width: 16),
            Expanded(child: _buildTypeField()),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildEcheanceField(),
        const SizedBox(height: 12),
        _buildTireurField(),
        const SizedBox(height: 12),
        _buildClientField(),
        const SizedBox(height: 12),
        _buildNField(),
        const SizedBox(height: 12),
        _buildBQField(),
        const SizedBox(height: 12),
        _buildMontantField(),
        const SizedBox(height: 12),
        _buildTypeField(),
      ],
    );
  }

  Widget _buildEcheanceField() {
    return TextFormField(
      controller: _echeanceController,
      decoration: const InputDecoration(
        labelText: 'Échéance',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildTireurField() {
    return TextFormField(
      controller: _tireurController,
      decoration: const InputDecoration(
        labelText: 'Tireur',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildClientField() {
    return TextFormField(
      controller: _clientController,
      decoration: const InputDecoration(
        labelText: 'Client',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildNField() {
    return TextFormField(
      controller: _nController,
      decoration: const InputDecoration(
        labelText: 'N',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildBQField() {
    return TextFormField(
      controller: _bqController,
      decoration: const InputDecoration(
        labelText: 'BQ',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildMontantField() {
    return TextFormField(
      controller: _montantController,
      decoration: const InputDecoration(
        labelText: 'Montant',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildTypeField() {
    return DropdownButtonFormField<String>(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85), // Fixed deprecation
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1), // Fixed deprecation
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: Scaffold(
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

                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  final rowDecoration = BoxDecoration(
    color: Colors.grey.shade50.withValues(alpha: 0.9), // Fixed deprecation
    border: Border(
      bottom: BorderSide(
        color: Colors.grey.withValues(alpha: 0.1), // Fixed deprecation
        width: 1,
      ),
    ),
  );

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
