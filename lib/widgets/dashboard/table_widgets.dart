import 'package:flutter/material.dart';

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
              buildMobileField('اسم المنتج', index, 'name', TextInputType.text),
              buildMobileField(
                  'الكمية', index, 'quantity', TextInputType.number),
              buildMobileField('السعر', index, 'price', TextInputType.number),
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
            Expanded(
                child: buildEditableCell(index, 'name', TextInputType.text)),
            Expanded(
                child:
                    buildEditableCell(index, 'quantity', TextInputType.number)),
            Expanded(
                child: buildEditableCell(index, 'price', TextInputType.number)),
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
                  onPressed: () => onRemoveRow(index),
                ),
              ),
            ),
          ],
        ),
      );
    }
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
            child: buildEditableCell(rowIndex, key, keyboardType),
          ),
        ],
      ),
    );
  }

  Widget buildEditableCell(
      int rowIndex, String key, TextInputType keyboardType) {
    final focusKey = '${rowIndex}_$key';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        focusNode: focusNodes[focusKey],
        initialValue: data[rowIndex][key].toString(),
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
            onFieldSubmission(rowIndex, key, value, keyboardType),
      ),
    );
  }

  Widget buildDesktopTable() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Table(
        border: TableBorder.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FixedColumnWidth(150), // Date
          1: FixedColumnWidth(150), // Échéance
          2: FixedColumnWidth(150), // Tireur
          3: FixedColumnWidth(150), // Client
          4: FixedColumnWidth(150), // N
          5: FixedColumnWidth(150), // BQ
          6: FixedColumnWidth(150), // Montant
          7: FixedColumnWidth(100), // Type
          8: FixedColumnWidth(120), // actions
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
                  'Date',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Échéance',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Tireur',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Client',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'N',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'BQ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Montant',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Type',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'الإجراءات',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          ...data.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return TableRow(
              decoration: BoxDecoration(
                color: index % 2 == 0 ? Colors.white : Colors.grey.shade50,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${item['Date'].year}-${item['Date'].month.toString().padLeft(2, '0')}-${item['Date'].day.toString().padLeft(2, '0')} / ${item['Date'].hour.toString().padLeft(2, '0')}:${item['Date'].minute.toString().padLeft(2, '0')}',
                    textAlign: TextAlign.center,
                  ),
                ),
                buildEditableCell(index, 'Échéance', TextInputType.datetime),
                buildEditableCell(index, 'Tireur', TextInputType.text),
                buildEditableCell(index, 'Client', TextInputType.text),
                buildEditableCell(index, 'N', TextInputType.text),
                buildEditableCell(index, 'BQ', TextInputType.text),
                buildEditableCell(index, 'Montant', TextInputType.number),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: DropdownButton<String>(
                      value: item['Type'],
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        if (value != null) {
                          updateValue(index, 'Type', value);
                        }
                      },
                      items: <String>['Check', 'Effet'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // TO DO: Implement edit functionality
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => onRemoveRow(index),
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
  }
}
