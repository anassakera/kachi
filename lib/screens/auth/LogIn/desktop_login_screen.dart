import 'package:flutter/material.dart';

import '../../../functions/auth/auth_functions.dart';
import '../../../routes/app_routes.dart';

class DesktopLoginScreen extends StatelessWidget {
  const DesktopLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 1200,
        padding: const EdgeInsets.all(32),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'مرحبًا بعودتك!',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF424242),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'من فضلك سجل الدخول إلى حسابك',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFFBDBDBD),
                    ),
                  ),
                  const SizedBox(height: 32),
                  FunctionsAuth.buildFormField(
                      'البريد الإلكتروني', 'admin@gmail.com'),
                  const SizedBox(height: 16),
                  FunctionsAuth.buildFormField(
                      'كلمة المرور', 'أدخل كلمة المرور',
                      isPassword: true),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // إجراء عند النقر على "نسيت كلمة المرور؟"
                      },
                      child: const Text(
                        'نسيت كلمة المرور؟',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6E6CDF),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // إجراء عند النقر على "تسجيل الدخول"
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.dashboard);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6E6CDF),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Color(0xFFE0E0E0),
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          'أو',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
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
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () async {
                      try {
                        await FunctionsAuth.launchWhatsApp();
                      } catch (e) {
                        // ignore: avoid_print
                        print('Error launching WhatsApp: $e');
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF424242),
                      padding: const EdgeInsets.symmetric(vertical: 16),
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
                          'assets/images/whatsapp.png', // استبدل بمسار الصورة
                          width: 21,
                          height: 21,
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'تواصل مع الدعم عبر واتساب',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'ليس لديك حساب؟',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF9E9E9E),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // إجراء عند النقر على "سجل هنا"
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.register);
                        },
                        child: const Text(
                          'سجل هنا',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6E6CDF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Image.asset(
                'assets/images/loginImage.png', // صورة خاصة بالحاسوب
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
