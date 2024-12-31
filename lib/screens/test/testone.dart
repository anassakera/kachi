import 'package:flutter/material.dart';

class EditableTableScreen extends StatefulWidget {
  const EditableTableScreen({super.key});

  @override
  State<EditableTableScreen> createState() => _EditableTableScreenState();
}

class _EditableTableScreenState extends State<EditableTableScreen> {
  final List<Map<String, dynamic>> _data = [
    {'name': 'Product 1', 'quantity': 10, 'price': 50.0, 'total': 500.0},
    {'name': 'Product 2', 'quantity': 5, 'price': 100.0, 'total': 500.0},
  ];

  final Map<String, FocusNode> _focusNodes = {};
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initializeFocusNodes();
  }

  void _initializeFocusNodes() {
    _focusNodes.forEach((_, node) => node.dispose());
    _focusNodes.clear();

    for (var rowIndex = 0; rowIndex < _data.length; rowIndex++) {
      for (var field in ['name', 'quantity', 'price']) {
        final key = '${rowIndex}_$field';
        _focusNodes[key] = FocusNode();
      }
    }
  }

  // دالة لتحديد ما إذا كانت الشاشة في وضع الموبايل
  bool _isMobileView(BuildContext context) {
    return MediaQuery.of(context).size.width < 710;
  }

  // دالة لبناء صف في الجدول
  Widget _buildTableRow(int index, Map<String, dynamic> item, bool isMobile) {
    if (isMobile) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMobileField(
                  'اسم المنتج', index, 'name', TextInputType.text),
              _buildMobileField(
                  'الكمية', index, 'quantity', TextInputType.number),
              _buildMobileField('السعر', index, 'price', TextInputType.number),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'المجموع: ${item['total']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeRow(index),
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
            Expanded(
                child: _buildEditableCell(index, 'name', TextInputType.text)),
            Expanded(
                child: _buildEditableCell(
                    index, 'quantity', TextInputType.number)),
            Expanded(
                child:
                    _buildEditableCell(index, 'price', TextInputType.number)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  item['total'].toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _removeRow(index),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  // دالة لبناء حقل في عرض الموبايل
  Widget _buildMobileField(
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
            child: _buildEditableCell(rowIndex, key, keyboardType),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableCell(
      int rowIndex, String key, TextInputType keyboardType) {
    final focusKey = '${rowIndex}_$key';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextFormField(
        focusNode: _focusNodes[focusKey],
        initialValue: _data[rowIndex][key].toString(),
        keyboardType: keyboardType,
        textAlign: keyboardType == TextInputType.number
            ? TextAlign.center
            : TextAlign.start,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        ),
        style: const TextStyle(fontSize: 14),
        onFieldSubmitted: (value) =>
            _handleFieldSubmission(rowIndex, key, value, keyboardType),
      ),
    );
  }

  void _handleFieldSubmission(
      int rowIndex, String key, String value, TextInputType keyboardType) {
    dynamic processedValue = value;
    if (keyboardType == TextInputType.number) {
      processedValue = key == 'price'
          ? double.tryParse(value) ?? 0.0
          : int.tryParse(value) ?? 0;
    }
    _updateValue(rowIndex, key, processedValue);

    final fields = ['name', 'quantity', 'price'];
    final currentFieldIndex = fields.indexOf(key);
    final nextFieldIndex = (currentFieldIndex + 1) % fields.length;
    final nextRowIndex =
        nextFieldIndex == 0 ? (rowIndex + 1) % _data.length : rowIndex;
    final nextField = fields[nextFieldIndex];
    final nextFocusKey = '${nextRowIndex}_$nextField';

    if (_focusNodes.containsKey(nextFocusKey)) {
      FocusScope.of(context).requestFocus(_focusNodes[nextFocusKey]);
    }
  }

  void _updateValue(int rowIndex, String key, dynamic value) {
    setState(() {
      _data[rowIndex][key] = value;
      if (key == 'quantity' || key == 'price') {
        _data[rowIndex]['total'] =
            (_data[rowIndex]['quantity'] * _data[rowIndex]['price'])
                .toStringAsFixed(2);
      }
    });
  }

  void _addNewRow() {
    setState(() {
      _data.add({
        'name': '',
        'quantity': 0,
        'price': 0.0,
        'total': 0.0,
      });
      final newRowIndex = _data.length - 1;
      for (var field in ['name', 'quantity', 'price']) {
        final key = '${newRowIndex}_$field';
        _focusNodes[key] = FocusNode();
      }
    });
  }

  void _removeRow(int index) {
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
                  _focusNodes[key]?.dispose();
                  _focusNodes.remove(key);
                }
                _data.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('حذف', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = _isMobileView(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('جدول المنتجات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNewRow,
            tooltip: 'إضافة صف جديد',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Card(
              margin: const EdgeInsets.all(16),
              child: isMobile
                  ? ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _data.length,
                      itemBuilder: (context, index) {
                        return _buildTableRow(index, _data[index], true);
                      },
                    )
                  : SingleChildScrollView(
                      controller: _verticalScrollController,
                      child: SingleChildScrollView(
                        controller: _horizontalScrollController,
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Table(
                            border: TableBorder.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            columnWidths: const {
                              0: FixedColumnWidth(200), // name
                              1: FixedColumnWidth(100), // quantity
                              2: FixedColumnWidth(100), // price
                              3: FixedColumnWidth(100), // total
                              4: FixedColumnWidth(80), // actions
                            },
                            children: [
                              const TableRow(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5F5F5),
                                ),
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      'اسم المنتج',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      'الكمية',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      'السعر',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      'المجموع',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      'الإجراءات',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              ..._data.asMap().entries.map((entry) {
                                final index = entry.key;
                                final item = entry.value;
                                return TableRow(
                                  decoration: BoxDecoration(
                                    color: index % 2 == 0
                                        ? Colors.white
                                        : Colors.grey.shade50,
                                  ),
                                  children: [
                                    _buildEditableCell(
                                        index, 'name', TextInputType.text),
                                    _buildEditableCell(index, 'quantity',
                                        TextInputType.number),
                                    _buildEditableCell(
                                        index, 'price', TextInputType.number),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        item['total'].toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Center(
                                      child: IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () => _removeRow(index),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          if (_data.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'المجموع الكلي: ${_calculateTotal()}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewRow,
        tooltip: 'إضافة صف جديد',
        child: const Icon(Icons.add),
      ),
    );
  }

  String _calculateTotal() {
    final total = _data.fold(0.0,
        (sum, item) => sum + (double.tryParse(item['total'].toString()) ?? 0));
    return total.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _focusNodes.forEach((_, node) => node.dispose());
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    super.dispose();
  }
}
