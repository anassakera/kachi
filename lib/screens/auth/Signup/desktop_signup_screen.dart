
import 'package:flutter/material.dart';

import '../../../routes/app_routes.dart';
import '../../../widgets/auth/signup_widgets.dart';

class DesktopSignUpScreen extends StatefulWidget {
  const DesktopSignUpScreen({super.key});

  @override
  State<DesktopSignUpScreen> createState() => _DesktopSignUpScreenState();
}

class _DesktopSignUpScreenState extends State<DesktopSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('كلمتا المرور غير متطابقتين')),
        );
        return;
      }
      Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 1200,
          padding: const EdgeInsets.all(32),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'أنشئ حسابًا جديدًا',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF424242),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'من فضلك قم بملء النموذج لإنشاء حساب جديد',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFFBDBDBD),
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: 500, // تحديد العرض
                        child: Column(
                          children: [
                            SignupWidgets.buildFormField(
                              'الاسم الكامل',
                              'أدخل اسمك الكامل',
                              controller: _nameController,
                            ),
                            const SizedBox(height: 16),
                            SignupWidgets.buildFormField(
                              'البريد الإلكتروني',
                              'أدخل بريدك الإلكتروني',
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 16),
                            SignupWidgets.buildFormField(
                              'كلمة المرور',
                              'أدخل كلمة المرور',
                              isPassword: true,
                              controller: _passwordController,
                            ),
                            const SizedBox(height: 16),
                            SignupWidgets.buildFormField(
                              'تأكيد كلمة المرور',
                              'أعد إدخال كلمة المرور',
                              isPassword: true,
                              controller: _confirmPasswordController,
                            ),
                            const SizedBox(height: 24),
                            SignupWidgets.buildSignUpButton(_handleSignUp),
                            const SizedBox(height: 16),
                            SignupWidgets.buildDivider(),
                            const SizedBox(height: 16),
                            SignupWidgets.buildWhatsAppButton(),
                            const SizedBox(height: 16),
                            SignupWidgets.buildLoginLink(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Image.asset(
                  'assets/images/signupImage.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
