import 'package:flutter/material.dart';
import '../../constant/app_colors.dart';
import '../../constant/app_typography.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class CheckListScreen extends StatefulWidget {
  const CheckListScreen({super.key});

  @override
  State<CheckListScreen> createState() => _CheckListScreenState();
}

class _CheckListScreenState extends State<CheckListScreen> {
  final _searchController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Add filter options here
              const Text(
                'Filters',
                style: AppTypography.heading2,
              ),
              const SizedBox(height: 16),
              // Example filter
              CustomTextField(
                label: 'Date Range',
                hint: 'Select date range',
                onTap: () {
                  // TO DO: Show date range picker
                },
              ),
              const SizedBox(height: 16),
              CustomButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Apply Filters'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Check List',
          style: AppTypography.heading2.copyWith(
            color: AppColors.textLight,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilters,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomTextField(
              controller: _searchController,
              label: 'Search',
              prefixIcon: const Icon(Icons.search),
              onChanged: (value) {
                // TO DO: Implement search logic
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: DataTable(
                  columnSpacing: 20, // Add some spacing between columns
                  columns: const [
                    DataColumn(label: Text('DATE')),
                    DataColumn(label: Text('ECHEANCE')),
                    DataColumn(label: Text('TIREURE')),
                    DataColumn(label: Text('CLT')),
                    DataColumn(label: Text('CHEQUE')),
                    DataColumn(label: Text('BQ')),
                    DataColumn(label: Text('M0NTANT')),
                    DataColumn(label: Text('CHQ/EFF')),
                    DataColumn(label: Text('MIS A')),
                    DataColumn(label: Text('LA DATE')),
                    DataColumn(label: Text('REMARQUES')),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('2023-10-01')),
                      DataCell(Text('2023-10-15')),
                      DataCell(Text('Bank XYZ')),
                      DataCell(Text('Customer A')),
                      DataCell(Text('CHQ001')),
                      DataCell(Text('Bank ABC')),
                      DataCell(Text('\$100')),
                      DataCell(Text('CHEQUE')),
                      DataCell(Text('John Doe')),
                      DataCell(Text('2023-10-02')),
                      DataCell(Text('First payment')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('2023-10-02')),
                      DataCell(Text('2023-10-20')),
                      DataCell(Text('Company Z')),
                      DataCell(Text('Customer B')),
                      DataCell(Text('CHQ002')),
                      DataCell(Text('Bank DEF')),
                      DataCell(Text('\$200')),
                      DataCell(Text('EFFET')),
                      DataCell(Text('Jane Smith')),
                      DataCell(Text('2023-10-03')),
                      DataCell(Text('Second payment')),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TO DO: Navigate to add check screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
