import 'package:flutter/material.dart';

class InvoiceCreateScreen extends StatefulWidget {
  const InvoiceCreateScreen({super.key});

  @override
  InvoiceCreateScreenState createState() => InvoiceCreateScreenState();
}

class InvoiceCreateScreenState extends State<InvoiceCreateScreen> {
  // تحديث نظام الألوان
  final mainColor = const Color(0xFF1E88E5);
  final secondaryColor = const Color(0xFF90CAF9);
  final backgroundColor = const Color(0xFFF8F9FA);
  final surfaceColor = const Color(0xFFFFFFFF);
  final textColor = const Color(0xFF2C3E50);
  final subtitleColor = const Color(0xFF607D8B);

  // Add new colors for stepper
  final stepperBackgroundColor = const Color(0xFFF8F9FA);
  final stepperActiveColor = const Color(0xFF1E88E5);
  final stepperCompletedColor = const Color(0xFF4CAF50);
  final stepperInactiveColor = const Color(0xFFBDBDBD);

  final _formKeys = List.generate(4, (_) => GlobalKey<FormState>());
  int _currentStep = 0;
  late Invoice _invoice;
  final List<Invoice> _invoices = [];

  // Add step validation tracking
  final Map<int, bool> _stepValidation = {
    0: false,
    1: false,
    2: false,
    3: false
  };

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
    if (!_formKeys[_currentStep].currentState!.validate()) return;

    setState(() {
      _invoices.add(_invoice);
      _resetInvoice();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حفظ الفاتورة بنجاح!')),
    );
  }

  bool _validateCurrentStep() {
    return _formKeys[_currentStep].currentState?.validate() ?? false;
  }

  void _validateStep(int step) {
    if (step == 0) {
      _stepValidation[0] =
          _invoice.client.isNotEmpty && _invoice.reference.isNotEmpty;
    } else if (step == 1) {
      _stepValidation[1] = true; // Legal info is optional
    } else if (step == 2) {
      _stepValidation[2] = _invoice.produits.isNotEmpty;
    }
  }

  void _onStepTapped(int step) {
    // Allow moving to a step if it's completed or if the current step is valid
    if (_stepValidation[_currentStep] == true || _validateCurrentStep()) {
      _validateStep(_currentStep);
      setState(() {
        _currentStep = step;
      });
    }
  }

  void _goToNextStep() {
    if (_validateCurrentStep()) {
      _validateStep(_currentStep);
      if (_currentStep < 3) {
        setState(() => _currentStep++);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'إنشاء فاتورة جديدة',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: mainColor,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: mainColor,
            secondary: secondaryColor,
            surface: surfaceColor,
            onSurface: textColor,
            // Add these for stepper colors
            outline: stepperInactiveColor,
            // primary: stepperActiveColor,
            onPrimary: Colors.white,
          ),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: textColor,
                displayColor: textColor,
              ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: surfaceColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: secondaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: secondaryColor.withValues(alpha: 0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: mainColor, width: 2),
            ),
            labelStyle: TextStyle(color: subtitleColor),
            contentPadding: const EdgeInsets.all(16),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: mainColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stepper(
            currentStep: _currentStep,
            type: StepperType.horizontal,
            onStepTapped: _onStepTapped,
            physics: const ClampingScrollPhysics(),
            elevation: 0,
            controlsBuilder: (context, details) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    if (_currentStep > 0)
                      TextButton(
                        onPressed: () {
                          setState(() => _currentStep--);
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back, color: mainColor, size: 20),
                            const SizedBox(width: 8),
                            Text('رجوع',
                                style:
                                    TextStyle(color: mainColor, fontSize: 16)),
                          ],
                        ),
                      ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed:
                          _currentStep < 3 ? _goToNextStep : _saveInvoice,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: stepperActiveColor,
                        elevation: 2,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _currentStep < 3 ? 'التالي' : 'حفظ الفاتورة',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (_currentStep < 3) ...[
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward, size: 20),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            steps: [
              _buildStepperStep(
                0,
                'معلومات العميل',
                Icons.person_outline,
                _buildClientInfoStep(),
              ),
              _buildStepperStep(
                1,
                'المعلومات القانونية',
                Icons.business_outlined,
                _buildCompanyInfoStep(),
              ),
              _buildStepperStep(
                2,
                'المنتجات',
                Icons.shopping_cart_outlined,
                _buildProductsStep(),
              ),
              _buildStepperStep(
                3,
                'مراجعة',
                Icons.fact_check_outlined,
                _buildReviewStep(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Step _buildClientInfoStep() {
    return Step(
      isActive: _currentStep >= 0,
      title: const Text('معلومات العميل'),
      content: Form(
        key: _formKeys[0],
        child: _buildStepContainer(
          ListView(
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
      ),
    );
  }

  Step _buildCompanyInfoStep() {
    return Step(
      isActive: _currentStep >= 1,
      title: const Text('المعلومات القانونية'),
      content: Form(
        key: _formKeys[1],
        child: _buildStepContainer(
          ListView(
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
        ),
      ),
    );
  }

  Step _buildProductsStep() {
    return Step(
      isActive: _currentStep >= 2,
      title: const Text('المنتجات'),
      content: Form(
        key: _formKeys[2],
        child: _buildStepContainer(
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                Flexible(
                  fit: FlexFit.loose,
                  child: ReorderableListView(
                    shrinkWrap: true,
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
          ),
        ),
      ),
    );
  }

  Widget _buildProductItem(Product product, int index) {
    return Container(
      key: Key('product_$index'),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: surfaceColor,
        border: Border.all(color: secondaryColor.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
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
      isActive: _currentStep >= 3,
      title: const Text('مراجعة'),
      content: Form(
        key: _formKeys[3],
        child: _buildStepContainer(
          Column(
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
              _buildTotalRow('الصافي المستحق', _invoice.netAPayer,
                  isBold: true),
              ElevatedButton(
                onPressed: _saveInvoice,
                child: const Text('حفظ الفاتورة'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Step _buildStepperStep(
      int index, String title, IconData iconData, Step step) {
    final isActive = _currentStep >= index;
    final isCompleted = _stepValidation[index] == true;

    return Step(
      isActive: isActive,
      state: isCompleted ? StepState.complete : StepState.indexed,
      title: Text(
        title,
        style: TextStyle(
          color: isActive ? stepperActiveColor : stepperInactiveColor,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      // Replace icon property with content
      content: step.content,
      // Add label property for the icon
      label: Icon(
        iconData,
        color: isCompleted
            ? stepperCompletedColor
            : (isActive ? stepperActiveColor : stepperInactiveColor),
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: isBold ? mainColor.withValues(alpha: 0.1) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              fontSize: isBold ? 16 : 14,
              color: isBold ? mainColor : textColor,
            ),
          ),
          Text(
            value.toStringAsFixed(2),
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              fontSize: isBold ? 16 : 14,
              color: isBold ? mainColor : textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContainer(Widget child) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
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
