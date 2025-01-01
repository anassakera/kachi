import 'package:flutter/material.dart';
import '../../functions/auth_functions.dart';
import '../../routes/app_routes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ResponsiveLayout(
          mobileLayout: MobileSignUpScreen(),
          desktopLayout: DesktopSignUpScreen(),
        ),
      ),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileLayout;
  final Widget desktopLayout;

  const ResponsiveLayout({
    super.key,
    required this.mobileLayout,
    required this.desktopLayout,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 710) {
          return mobileLayout;
        } else {
          return desktopLayout;
        }
      },
    );
  }
}

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
                      _buildFormField(
                        'الاسم الكامل',
                        'أدخل اسمك الكامل',
                        controller: _nameController,
                      ),
                      const SizedBox(height: 16),
                      _buildFormField(
                        'البريد الإلكتروني',
                        'أدخل بريدك الإلكتروني',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      _buildFormField(
                        'كلمة المرور',
                        'أدخل كلمة المرور',
                        isPassword: true,
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 16),
                      _buildFormField(
                        'تأكيد كلمة المرور',
                        'أعد إدخال كلمة المرور',
                        isPassword: true,
                        controller: _confirmPasswordController,
                      ),
                      const SizedBox(height: 24),
                      _buildSignUpButton(_handleSignUp),
                      const SizedBox(height: 16),
                      _buildDivider(),
                      const SizedBox(height: 16),
                      _buildWhatsAppButton(),
                      const SizedBox(height: 16),
                      _buildLoginLink(context),
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
                            _buildFormField(
                              'الاسم الكامل',
                              'أدخل اسمك الكامل',
                              controller: _nameController,
                            ),
                            const SizedBox(height: 16),
                            _buildFormField(
                              'البريد الإلكتروني',
                              'أدخل بريدك الإلكتروني',
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 16),
                            _buildFormField(
                              'كلمة المرور',
                              'أدخل كلمة المرور',
                              isPassword: true,
                              controller: _passwordController,
                            ),
                            const SizedBox(height: 16),
                            _buildFormField(
                              'تأكيد كلمة المرور',
                              'أعد إدخال كلمة المرور',
                              isPassword: true,
                              controller: _confirmPasswordController,
                            ),
                            const SizedBox(height: 24),
                            _buildSignUpButton(_handleSignUp),
                            const SizedBox(height: 16),
                            _buildDivider(),
                            const SizedBox(height: 16),
                            _buildWhatsAppButton(),
                            const SizedBox(height: 16),
                            _buildLoginLink(context),
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

Widget _buildFormField(
  String label,
  String hint, {
  bool isPassword = false,
  TextEditingController? controller,
  TextInputType? keyboardType,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontFamily: 'Rubik',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF424242),
        ),
      ),
      const SizedBox(height: 8),
      TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'هذا الحقل مطلوب';
          }
          if (label == 'البريد الإلكتروني' && !value.contains('@')) {
            return 'البريد الإلكتروني غير صحيح';
          }
          if (label == 'كلمة المرور' && value.length < 6) {
            return 'كلمة المرور يجب أن تكون على الأقل 6 أحرف';
          }
          if (label == 'الاسم الكامل' && value.length < 3) {
            return 'الاسم الكامل يجب أن يكون على الأقل 3 أحرف';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'Rubik',
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Color(0xFF757575),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: const Color(0xFF6E6CDF).withOpacity(0.8),
              width: 1,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
    ],
  );
}

Widget _buildSignUpButton(VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF6E6CDF),
      padding: const EdgeInsets.symmetric(vertical: 16),
      minimumSize: const Size(double.infinity, 56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    child: const Text(
      'إنشاء حساب',
      style: TextStyle(
        fontFamily: 'Rubik',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
  );
}

Widget _buildDivider() {
  return const Row(
    children: [
      Expanded(
        child: Divider(
          color: Color(0xFFE0E0E0),
          thickness: 1,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'أو',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Color(0xFFE0E0E0),
          ),
        ),
      ),
      Expanded(
        child: Divider(
          color: Color(0xFFE0E0E0),
          thickness: 1,
        ),
      ),
    ],
  );
}

Widget _buildWhatsAppButton() {
  return OutlinedButton(
    onPressed: () async {
      try {
        await FunctionsAuth.launchWhatsApp();
      } catch (e) {
        debugPrint('Error launching WhatsApp: $e');
      }
    },
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF424242),
      padding: const EdgeInsets.symmetric(vertical: 16),
      minimumSize: const Size(double.infinity, 56),
      side: const BorderSide(
        color: Color(0xFFE0E0E0),
        width: 0.8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/whatsapp.png',
          width: 21,
          height: 21,
        ),
        const SizedBox(width: 8),
        const Text(
          'تواصل مع الدعم عبر واتساب',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _buildLoginLink(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        'لديك حساب بالفعل؟',
        style: TextStyle(
          fontFamily: 'Rubik',
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Color(0xFF9E9E9E),
        ),
      ),
      TextButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
        },
        child: const Text(
          'سجل الدخول',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6E6CDF),
          ),
        ),
      ),
    ],
  );
}
