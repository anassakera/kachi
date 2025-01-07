import 'package:flutter/material.dart';

import '../../functions/auth/auth_functions.dart';
import '../../routes/app_routes.dart';

class SignupWidgets {
    
static Widget buildFormField(
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
              color: const Color(0xFF6E6CDF).withValues(alpha: 0.8),
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


static Widget buildSignUpButton(VoidCallback onPressed) {
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

static Widget buildDivider() {
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

static Widget buildWhatsAppButton() {
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

static Widget buildLoginLink(BuildContext context) {
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
          Navigator.pushReplacementNamed(context, AppRoutes.auth);
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

}