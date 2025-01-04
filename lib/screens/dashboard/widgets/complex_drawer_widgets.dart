import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';
import '../functions/complex_drawer_functions.dart';

class ComplexDrawerWidgets extends StatefulWidget {
  const ComplexDrawerWidgets({super.key});

  @override
  State<ComplexDrawerWidgets> createState() => ComplexDrawerWidgetsState();
}

class ComplexDrawerWidgetsState extends State<ComplexDrawerWidgets> {
  bool isExpanded = false;
  int selectedIndex = 0;
  late List<CDMenuItem> menuItems;

  @override
  void initState() {
    super.initState();
    _initializeMenuItems();
  }

  void _initializeMenuItems() {
    menuItems = [
      CDMenuItem(
        'جديد',
        Icons.add_circle_outline_rounded,
        iconColor: const Color(0xFFFFB74D),
        submenus: [
          DrawerSubMenuItem(
            title: "إصدار شيك جديد",
            icon: Icons.create_rounded,
            iconColor: const Color(0xFF7986CB),
            onPressed: () {
              if (mounted) {
                Navigator.of(context).pushReplacementNamed(AppRoutes.auth);
              }
            },
          ),
          DrawerSubMenuItem(
            title: "إنشاء سند دفع",
            icon: Icons.receipt_long_rounded,
            iconColor: const Color(0xFF9575CD),
            onPressed: () {},
          ),
          DrawerSubMenuItem(
            title: "تسجيل معاملة جديدة",
            icon: Icons.add_task_rounded,
            iconColor: const Color(0xFF4DD0E1),
            onPressed: () {},
          ),
        ],
      ),
      CDMenuItem(
        'المدير',
        Icons.admin_panel_settings_rounded,
        iconColor: const Color(0xFF42A5F5),
        submenus: const [
          DrawerSubMenuItem(
            title: "إدارة المستخدمين",
            icon: Icons.manage_accounts_rounded,
            iconColor: Color(0xFF64B5F6),
          ),
          DrawerSubMenuItem(
            title: "الصلاحيات والأذونات",
            icon: Icons.security_rounded,
            iconColor: Color(0xFF81C784),
          ),
          DrawerSubMenuItem(
            title: "سجل النشاطات",
            icon: Icons.history_rounded,
            iconColor: Color(0xFFFFB74D),
          ),
        ],
      ),
      CDMenuItem(
        'الدفاتر',
        Icons.book_rounded,
        iconColor: const Color(0xFF7E57C2),
        submenus: const [
          DrawerSubMenuItem(
            title: "دفاتر الشيكات النشطة",
            icon: Icons.book_online_rounded,
            iconColor: Color(0xFFBA68C8),
          ),
          DrawerSubMenuItem(
            title: "طلب دفتر شيكات جديد",
            icon: Icons.add_box_rounded,
            iconColor: Color(0xFF4FC3F7),
          ),
          DrawerSubMenuItem(
            title: "سجل الدفاتر السابقة",
            icon: Icons.history_edu_rounded,
            iconColor: Color(0xFF4DB6AC),
          ),
        ],
      ),
      CDMenuItem(
        'الشيكات المصدرة',
        Icons.check_circle_outline_rounded,
        iconColor: const Color(0xFF81C784),
        submenus: const [
          DrawerSubMenuItem(
            title: "عرض جميع الشيكات المصدرة",
            icon: Icons.view_list_rounded,
            iconColor: Color(0xFFFFD54F),
          ),
          DrawerSubMenuItem(
            title: "تصنيف حسب التاريخ",
            icon: Icons.date_range_rounded,
            iconColor: Color(0xFFA1887F),
          ),
          DrawerSubMenuItem(
            title: "متابعة حالة الصرف",
            icon: Icons.track_changes_rounded,
            iconColor: Color(0xFFF06292),
          ),
        ],
      ),
      CDMenuItem(
        'تسليم الشيكات',
        Icons.send_rounded,
        iconColor: const Color(0xFFEF5350),
        submenus: const [
          DrawerSubMenuItem(
            title: "تسجيل عملية تسليم",
            icon: Icons.delivery_dining_rounded,
            iconColor: Color(0xFF4FC3F7),
          ),
          DrawerSubMenuItem(
            title: "سجل التسليمات",
            icon: Icons.history_rounded,
            iconColor: Color(0xFFFF8A65),
          ),
          DrawerSubMenuItem(
            title: "تقرير التسليمات الشهري",
            icon: Icons.report_rounded,
            iconColor: Color(0xFFAED581),
          ),
        ],
      ),
      CDMenuItem(
        'الشيكات المستلمة',
        Icons.download_rounded,
        iconColor: const Color(0xFF26A69A),
        submenus: const [
          DrawerSubMenuItem(
            title: "تسجيل شيك مستلم",
            icon: Icons.receipt_rounded,
            iconColor: Color(0xFF64B5F6),
          ),
          DrawerSubMenuItem(
            title: "متابعة حالة الإيداع",
            icon: Icons.track_changes_rounded,
            iconColor: Color(0xFF4DB6AC),
          ),
          DrawerSubMenuItem(
            title: "سجل الشيكات المستلمة",
            icon: Icons.history_rounded,
            iconColor: Color(0xFFBA68C8),
          ),
        ],
      ),
      CDMenuItem(
        'الشركات',
        Icons.business_rounded,
        iconColor: const Color(0xFF8D6E63),
        submenus: const [
          DrawerSubMenuItem(
            title: "إدارة الشركات",
            icon: Icons.business_center_rounded,
            iconColor: Color(0xFF7986CB),
          ),
          DrawerSubMenuItem(
            title: "البيانات الضريبية",
            icon: Icons.receipt_long_rounded,
            iconColor: Color(0xFFEF5350),
          ),
          DrawerSubMenuItem(
            title: "معلومات التواصل",
            icon: Icons.contact_phone_rounded,
            iconColor: Color(0xFF81C784),
          ),
        ],
      ),
      CDMenuItem(
        'الحسابات البنكية',
        Icons.account_balance_rounded,
        iconColor: const Color(0xFF78909C),
        submenus: const [
          DrawerSubMenuItem(
            title: "عرض الحسابات النشطة",
            icon: Icons.account_balance_wallet_rounded,
            iconColor: Color(0xFFFFD54F),
          ),
          DrawerSubMenuItem(
            title: "إضافة حساب جديد",
            icon: Icons.add_circle_rounded,
            iconColor: Color(0xFF4DD0E1),
          ),
          DrawerSubMenuItem(
            title: "كشوفات الحسابات",
            icon: Icons.receipt_long_rounded,
            iconColor: Color(0xFF9575CD),
          ),
        ],
      ),
      CDMenuItem(
        'المستفيدون',
        Icons.people_rounded,
        iconColor: const Color(0xFF7E57C2),
        submenus: const [
          DrawerSubMenuItem(
            title: "قائمة المستفيدين",
            icon: Icons.list_rounded,
            iconColor: Color(0xFFFFB74D),
          ),
          DrawerSubMenuItem(
            title: "إضافة مستفيد جديد",
            icon: Icons.person_add_rounded,
            iconColor: Color(0xFF4FC3F7),
          ),
          DrawerSubMenuItem(
            title: "سجل التعاملات",
            icon: Icons.history_rounded,
            iconColor: Color(0xFFF06292),
          ),
        ],
      ),
      CDMenuItem(
        'البنوك',
        Icons.account_balance_wallet_rounded,
        iconColor: const Color(0xFF5C6BC0),
        submenus: const [
          DrawerSubMenuItem(
            title: "قائمة البنوك المعتمدة",
            icon: Icons.list_rounded,
            iconColor: Color(0xFF64B5F6),
          ),
          DrawerSubMenuItem(
            title: "معلومات الفروع",
            icon: Icons.location_city_rounded,
            iconColor: Color(0xFFA1887F),
          ),
          DrawerSubMenuItem(
            title: "بيانات التواصل",
            icon: Icons.contact_phone_rounded,
            iconColor: Color(0xFF4DB6AC),
          ),
        ],
      ),
      CDMenuItem(
        'النماذج',
        Icons.dashboard_customize_rounded,
        iconColor: const Color(0xFF26C6DA),
        submenus: const [
          DrawerSubMenuItem(
            title: "نماذج الشيكات",
            icon: Icons.description_rounded,
            iconColor: Color(0xFFBA68C8),
          ),
          DrawerSubMenuItem(
            title: "تخصيص النماذج",
            icon: Icons.edit_rounded,
            iconColor: Color(0xFFFF8A65),
          ),
          DrawerSubMenuItem(
            title: "إعدادات الطباعة",
            icon: Icons.print_rounded,
            iconColor: Color(0xFF7986CB),
          ),
        ],
      ),
      CDMenuItem(
        'التفضيلات',
        Icons.settings_rounded,
        iconColor: const Color(0xFF9E9E9E),
        submenus: const [
          DrawerSubMenuItem(
            title: "إعدادات النظام",
            icon: Icons.settings_rounded,
            iconColor: Color(0xFF81C784),
          ),
          DrawerSubMenuItem(
            title: "تخصيص الواجهة",
            icon: Icons.dashboard_customize_rounded,
            iconColor: Color(0xFFFFD54F),
          ),
          DrawerSubMenuItem(
            title: "خيارات العرض",
            icon: Icons.view_compact_rounded,
            iconColor: Color(0xFF64B5F6),
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return buildDrawer(context, ComplexDrawerFunctions());
  }

  Widget buildDrawer(BuildContext context, ComplexDrawerFunctions functions) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1a1c1e).withValues(alpha: 0.95),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SizedBox(
        width: isExpanded ? 250 : 70,
        child: Column(
          children: [
            _buildHeader(),
            const Divider(color: Colors.white24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildMenuItems(),
                    const Divider(color: Colors.white24),
                    _buildProfile(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: const FlutterLogo(size: 40),
          ),
          if (isExpanded) ...[
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                "KACHI",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade300,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMenuItems() {
    return Column(
      children: menuItems.map((item) => _buildMenuItem(menuItems.indexOf(item)))
          .toList(),
    );
  }

  Widget _buildMenuItem(int index) {
    final item = menuItems[index];
    final isSelected = selectedIndex == index; // Store selection state locally

    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: SizedBox(
            width: 30,
            height: 30,
            child: Icon(
              item.icon,
              // ignore: deprecated_member_use
              color: item.iconColor?.withValues(alpha: 0.9),
              size: 20,
            ),
          ),
          title: isExpanded
              ? Text(
                  item.title,
                  style: TextStyle(
                    color: isSelected ? item.iconColor : Colors.white70,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                )
              : null,
          onTap: () {
            setState(() => selectedIndex = isSelected ? -1 : index);
          },
          selected: isSelected,
          selectedTileColor: item.iconColor?.withValues(alpha: 0.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        if (isSelected && isExpanded && item.submenus.isNotEmpty)
          Column(
            children: item.submenus.map((subMenu) {
              return _buildSubMenuItem(subMenu, item.iconColor);
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildSubMenuItem(DrawerSubMenuItem subMenu, Color? color) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 56, right: 16),
      leading: SizedBox(
        width: 20, // Fixed width for leading icon
        child: Icon(
          subMenu.icon,
          color: color?.withValues(alpha: 0.8) ?? Colors.white60,
          size: 20,
        ),
      ),
      title: Text(
        subMenu.title,
        style: TextStyle(
          fontSize: 14,
          color: color?.withValues(alpha: 0.8) ?? Colors.white60,
        ),
      ),
      onTap: subMenu.onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      hoverColor: color?.withValues(alpha: 0.05),
      dense: true, // Make the ListTile more compact
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildProfile() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Prevent row overflow
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white24,
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white70,
            ),
          ),
          if (isExpanded) ...[
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Prevent column overflow
                children: [
                  Text(
                    "User Name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade300,
                    ),
                    overflow: TextOverflow.ellipsis, // Handle text overflow
                  ),
                  const Text(
                    "Developer",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white60,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              iconSize: 20, // Smaller icon
              padding: EdgeInsets.zero, // Remove padding
              constraints: const BoxConstraints(), // Remove constraints
              icon: const Icon(
                Icons.logout_rounded,
                color: Colors.white70,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.auth);
              },
              tooltip: 'Logout',
            ),
          ],
        ],
      ),
    );
  }
}

class CDMenuItem {
  final String title;
  final IconData icon;
  final Color? iconColor;
  final List<DrawerSubMenuItem> submenus;

  CDMenuItem(this.title, this.icon, {this.iconColor, this.submenus = const []});
}

class DrawerSubMenuItem {
  final String title;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback? onPressed;

  const DrawerSubMenuItem({
    required this.title,
    required this.icon,
    this.iconColor,
    this.onPressed,
  });
}

