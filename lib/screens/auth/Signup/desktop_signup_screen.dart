import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/auth/signup_widgets.dart';

class MobileSignUpScreen extends StatefulWidget {
  const MobileSignUpScreen({super.key});

  @override
  State<MobileSignUpScreen> createState() => _MobileSignUpScreenState();
}

class _MobileSignUpScreenState extends State<MobileSignUpScreen> {
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/signupImage.png',
                  height: 200,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8, // تحديد العرض
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
      ),
    );
  }



}


