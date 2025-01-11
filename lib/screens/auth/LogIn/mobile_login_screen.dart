import 'package:flutter/material.dart';

import '../../../functions/auth/auth_functions.dart';
import '../../../routes/app_routes.dart';

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({super.key});

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/loginImage.png',
              height: 200, // يمكنك تعديل الارتفاع حسب احتياجاتك
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 32),
            FunctionsAuth.buildFormField(
                'البريد الإلكتروني', 'admin@gmail.com'),
            const SizedBox(height: 16),
            FunctionsAuth.buildFormField('كلمة المرور', 'أدخل كلمة المرور',
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
                    fontSize: 14,
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
                Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
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
                    fontSize: 16,
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
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () async {
                try {
                  await FunctionsAuth.launchWhatsApp();
                } catch (e) {
                  // استخدم logger بدلاً من print
                  debugPrint('Error launching WhatsApp: $e');
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
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'ليس لديك حساب؟',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // إجراء عند النقر على "سجل هنا"

                    Navigator.pushReplacementNamed(context, AppRoutes.register);
                  },
                  child: const Text(
                    'سجل هنا',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 14,
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
    );
  }
}
