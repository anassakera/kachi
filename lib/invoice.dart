import 'package:flutter/material.dart';

class InvoiceCreateScreen extends StatefulWidget {
  const InvoiceCreateScreen({super.key});

  @override
  InvoiceCreateScreenState createState() => InvoiceCreateScreenState();
}

class InvoiceCreateScreenState extends State<InvoiceCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  late Invoice _invoice;
  final List<Invoice> _invoices = [];

  @override
  void initState() {
    super.initState();
    _resetInvoice();
  }

  void _resetInvoice() {
    _invoice = Invoice(
      reference: DateTime.now().millisecondsSinceEpoch.toString(),
      numero: '',
      date: '',
      clientNumber: '',
      client: '',
      adresse: '',
      ice: '',
      ifCode: '',
      rc: '',
      numTP: '',
      cnss: '',
      telephone: '',
      email: '',
      produits: [],
      totalHT: 0,
      tauxTaxe: '20%',
      montantTaxe: 0,
      totalTTC: 0,
      acompte: 0,
      netAPayer: 0,
    );
  }

  void _updateTotals() {
    double totalHT =
        _invoice.produits.fold(0, (sum, item) => sum + item.montantHT);
    double taxRate = double.parse(_invoice.tauxTaxe.replaceAll('%', '')) / 100;
    double montantTaxe = totalHT * taxRate;
    double totalTTC = totalHT + montantTaxe;
    double netAPayer = totalTTC - _invoice.acompte;

    setState(() {
      _invoice.totalHT = totalHT;
      _invoice.montantTaxe = montantTaxe;
      _invoice.totalTTC = totalTTC;
      _invoice.netAPayer = netAPayer;
    });
  }

  void _saveInvoice() {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _invoices.add(_invoice);
      _resetInvoice();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حفظ الفاتورة بنجاح!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إنشاء فاتورة جديدة')),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 3) setState(() => _currentStep++);
        },
        onStepCancel: () {
          if (_currentStep > 0) setState(() => _currentStep--);
        },
        steps: [
          _buildClientInfoStep(),
          _buildCompanyInfoStep(),
          _buildProductsStep(),
          _buildReviewStep(),
        ],
      ),
    );
  }

  Step _buildClientInfoStep() {
    return Step(
      title: const Text('معلومات العميل'),
      content: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            _buildInputField('المرجع', (v) => _invoice.reference = v,
                required: true),
            _buildInputField('الرقم', (v) => _invoice.numero = v),
            _buildInputField('التاريخ', (v) => _invoice.date = v),
            _buildInputField('N° client', (v) => _invoice.clientNumber = v),
            _buildInputField('العميل', (v) => _invoice.client = v,
                required: true),
            _buildInputField('العنوان', (v) => _invoice.adresse = v),
          ],
        ),
      ),
    );
  }

  Step _buildCompanyInfoStep() {
    return Step(
      title: const Text('المعلومات القانونية'),
      content: ListView(
        shrinkWrap: true,
        children: [
          _buildInputField('ICE', (v) => _invoice.ice = v),
          _buildInputField('IF', (v) => _invoice.ifCode = v),
          _buildInputField('RC', (v) => _invoice.rc = v),
          _buildInputField('N° TP', (v) => _invoice.numTP = v),
          _buildInputField('CNSS', (v) => _invoice.cnss = v),
          _buildInputField('الهاتف', (v) => _invoice.telephone = v),
          _buildInputField('البريد الإلكتروني', (v) => _invoice.email = v),
        ],
      ),
    );
  }

  Step _buildProductsStep() {
    return Step(
      title: const Text('المنتجات'),
      content: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                _invoice.produits.add(Product(
                  reference: '',
                  designation: '',
                  quantite: 1,
                  prixUnitaire: 0,
                  montantHT: 0,
                ));
              });
            },
            child: const Text('إضافة منتج'),
          ),
          Expanded(
            child: ReorderableListView(
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  final item = _invoice.produits.removeAt(oldIndex);
                  _invoice.produits.insert(newIndex, item);
                });
              },
              children: [
                for (int i = 0; i < _invoice.produits.length; i++)
                  _buildProductItem(_invoice.produits[i], i),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(Product product, int index) {
    return Container(
      key: Key('product_$index'),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _buildInputField('المرجع', (v) => product.reference = v),
            _buildInputField('الوصف', (v) => product.designation = v),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'الكمية'),
                    keyboardType: TextInputType.number,
                    initialValue: product.quantite.toString(),
                    onChanged: (v) {
                      product.quantite = int.tryParse(v) ?? 0;
                      product.montantHT =
                          product.quantite * product.prixUnitaire;
                      _updateTotals();
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'السعر'),
                    keyboardType: TextInputType.number,
                    initialValue: product.prixUnitaire.toString(),
                    onChanged: (v) {
                      product.prixUnitaire = double.tryParse(v) ?? 0;
                      product.montantHT =
                          product.quantite * product.prixUnitaire;
                      _updateTotals();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Step _buildReviewStep() {
    return Step(
      title: const Text('مراجعة'),
      content: Column(
        children: [
          _buildTotalRow('الإجمالي قبل الضريبة', _invoice.totalHT),
          _buildTotalRow(
              'نسبة الضريبة (${_invoice.tauxTaxe})', _invoice.montantTaxe),
          _buildTotalRow('الإجمالي مع الضريبة', _invoice.totalTTC),
          _buildInputField('الدفعة المقدمة', (v) {
            _invoice.acompte = double.tryParse(v) ?? 0;
            _updateTotals();
          }),
          const Divider(thickness: 2),
          _buildTotalRow('الصافي المستحق', _invoice.netAPayer, isBold: true),
          ElevatedButton(
            onPressed: _saveInvoice,
            child: const Text('حفظ الفاتورة'),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String label, Function(String) onChanged,
      {bool required = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: required ? (v) => v!.isEmpty ? 'مطلوب' : null : null,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildTotalRow(String label, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  isBold ? const TextStyle(fontWeight: FontWeight.bold) : null),
          Text(value.toStringAsFixed(2),
              style:
                  isBold ? const TextStyle(fontWeight: FontWeight.bold) : null),
        ],
      ),
    );
  }
}

class Invoice {
  String reference;
  String numero;
  String date;
  String clientNumber;
  String client;
  String adresse;
  String ice;
  String ifCode;
  String rc;
  String numTP;
  String cnss;
  String telephone;
  String email;
  List<Product> produits;
  double totalHT;
  String tauxTaxe;
  double montantTaxe;
  double totalTTC;
  double acompte;
  double netAPayer;

  Invoice({
    required this.reference,
    required this.numero,
    required this.date,
    required this.clientNumber,
    required this.client,
    required this.adresse,
    required this.ice,
    required this.ifCode,
    required this.rc,
    required this.numTP,
    required this.cnss,
    required this.telephone,
    required this.email,
    required this.produits,
    required this.totalHT,
    required this.tauxTaxe,
    required this.montantTaxe,
    required this.totalTTC,
    required this.acompte,
    required this.netAPayer,
  });
}

class Product {
  String reference;
  String designation;
  int quantite;
  double prixUnitaire;
  double montantHT;

  Product({
    required this.reference,
    required this.designation,
    required this.quantite,
    required this.prixUnitaire,
    required this.montantHT,
  });
}
