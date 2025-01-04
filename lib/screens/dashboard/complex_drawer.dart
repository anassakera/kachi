import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class ComplexDrawer extends StatefulWidget {
  const ComplexDrawer({super.key});

  @override
  State<ComplexDrawer> createState() => _ComplexDrawerState();
}

class _ComplexDrawerState extends State<ComplexDrawer>
    with SingleTickerProviderStateMixin {
  int selectedIndex = -1;
  bool isExpanded = true;
  late AnimationController _controller;

  late final List<DrawerMenuItem> menuItems;

  @override
  void initState() {
    super.initState();
    _initializeMenuItems();
    _controller = AnimationController(
      duration: DrawerConstants.animationDuration,
      vsync: this,
    );
    if (isExpanded) _controller.forward();
  }

  void _initializeMenuItems() {
    menuItems = [
      DrawerMenuItem(
        icon: Icons.add_circle_outline_rounded,
        title: "جديد",
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
            onPressed: () {
              // Navigator.pushNamed(context, '/new-payment');
            },
          ),
          DrawerSubMenuItem(
            title: "تسجيل معاملة جديدة",
            icon: Icons.add_task_rounded,
            iconColor: const Color(0xFF4DD0E1),
            onPressed: () {
              // Navigator.pushNamed(context, '/new-transaction');
            },
          ),
        ],
        iconColor: const Color(0xFFFFB74D),
      ),
      const DrawerMenuItem(
        icon: Icons.admin_panel_settings_rounded,
        title: "المدير",
        submenus: [
          DrawerSubMenuItem(
            title: "إدارة المستخدمين",
            icon: Icons.manage_accounts_rounded,
            iconColor: Color(0xFF64B5F6),
            onPressed: null, // Add callback here
          ),
          DrawerSubMenuItem(
            title: "الصلاحيات والأذونات",
            icon: Icons.security_rounded,
            iconColor: Color(0xFF81C784),
            onPressed: null, // Add callback here
          ),
          DrawerSubMenuItem(
            title: "سجل النشاطات",
            icon: Icons.history_rounded,
            iconColor: Color(0xFFFFB74D),
            onPressed: null, // Add callback here
          ),
        ],
        iconColor: Color(0xFF42A5F5),
      ),
      const DrawerMenuItem(
        icon: Icons.book_rounded,
        title: "الدفاتر",
        submenus: [
          DrawerSubMenuItem(
            title: "دفاتر الشيكات النشطة",
            icon: Icons.book_online_rounded,
            iconColor: Color(0xFFBA68C8),
            onPressed: null, // Add callback here
          ),
          DrawerSubMenuItem(
            title: "طلب دفتر شيكات جديد",
            icon: Icons.add_box_rounded,
            iconColor: Color(0xFF4FC3F7),
            onPressed: null, // Add callback here
          ),
          DrawerSubMenuItem(
            title: "سجل الدفاتر السابقة",
            icon: Icons.history_edu_rounded,
            iconColor: Color(0xFF4DB6AC),
            onPressed: null, // Add callback here
          ),
        ],
        iconColor: Color(0xFF7E57C2),
      ),
      const DrawerMenuItem(
        icon: Icons.check_circle_outline_rounded,
        title: "الشيكات المصدرة",
        submenus: [
          DrawerSubMenuItem(
            title: "عرض جميع الشيكات المصدرة",
            icon: Icons.view_list_rounded,
            iconColor: Color(0xFFFFD54F),
            onPressed: null, // Add callback here
          ),
          DrawerSubMenuItem(
            title: "تصنيف حسب التاريخ",
            icon: Icons.date_range_rounded,
            iconColor: Color(0xFFA1887F),
            onPressed: null, // Add callback here
          ),
          DrawerSubMenuItem(
            title: "متابعة حالة الصرف",
            icon: Icons.track_changes_rounded,
            iconColor: Color(0xFFF06292),
            onPressed: null, // Add callback here
          ),
        ],
        iconColor: Color(0xFF81C784),
      ),
      const DrawerMenuItem(
        icon: Icons.send_rounded,
        title: "تسليم الشيكات",
        submenus: [
          DrawerSubMenuItem(
            title: "تسجيل عملية تسليم",
            icon: Icons.delivery_dining_rounded,
            iconColor: Color(0xFF4FC3F7),
            onPressed: null, // Add callback here
          ),
          DrawerSubMenuItem(
            title: "سجل التسليمات",
            icon: Icons.history_rounded,
            iconColor: Color(0xFFFF8A65),
            onPressed: null, // Add callback here
          ),
          DrawerSubMenuItem(
            title: "تقرير التسليمات الشهري",
            icon: Icons.report_rounded,
            iconColor: Color(0xFFAED581),
            onPressed: null, // Add callback here
          ),
        ],
        iconColor: Color(0xFFEF5350),
      ),
      const DrawerMenuItem(
        icon: Icons.download_rounded,
        title: "الشيكات المستلمة",
        submenus: [
          DrawerSubMenuItem(
            title: "تسجيل شيك مستلم",
            icon: Icons.receipt_rounded,
            iconColor: Color(0xFF64B5F6),
            onPressed: null, // Add callback here
          ),
          DrawerSubMenuItem(
            title: "متابعة حالة الإيداع",
            icon: Icons.track_changes_rounded,
            iconColor: Color(0xFF4DB6AC),
            onPressed: null, // Add callback here
          ),
          DrawerSubMenuItem(
            title: "سجل الشيكات المستلمة",
            icon: Icons.history_rounded,
            iconColor: Color(0xFFBA68C8),
            onPressed: null, // Add callback here
          ),
        ],
        iconColor: Color(0xFF26A69A),
      ),
      const DrawerMenuItem(
        icon: Icons.business_rounded,
        title: "الشركات",
        submenus: [
          DrawerSubMenuItem(
            title: "إدارة الشركات",
            icon: Icons.business_center_rounded,
            iconColor: Color(0xFF7986CB),
            onPressed: null, // Add callback here
          ),
          DrawerSubMenuItem(
            title: "البيانات الضريبية",
            icon: Icons.receipt_long_rounded,
            iconColor: Color(0xFFEF5350),
            onPressed: null, // Add callback here
          ),
          DrawerSubMenuItem(
            title: "معلومات التواصل",
            icon: Icons.contact_phone_rounded,
            iconColor: Color(0xFF81C784),
            onPressed: null, // Add callback here
          ),
        ],
        iconColor: Color(0xFF8D6E63),
      ),
      const DrawerMenuItem(
        icon: Icons.account_balance_rounded,
        title: "الحسابات البنكية",
        submenus: [
          DrawerSubMenuItem(
            title: "عرض الحسابات النشطة",
            icon: Icons.account_balance_wallet_rounded,
            iconColor: Color(0xFFFFD54F),
            onPressed: null, // Add callback here
          ),
          DrawerSubMenuItem(
            title: "إضافة حساب جديد",
            icon: Icons.add_circle_rounded,
            iconColor: Color(0xFF4DD0E1),
            onPressed: null, // Add callback here
          ),
          DrawerSubMenuItem(
            title: "كشوفات الحسابات",
            icon: Icons.receipt_long_rounded,
            iconColor: Color(0xFF9575CD),
            onPressed: null, // Add callback here
          ),
        ],
        iconColor: Color(0xFF78909C),
      ),
      const DrawerMenuItem(
        icon: Icons.people_rounded,
        title: "المستفيدون",
        submenus: [
          DrawerSubMenuItem(
            title: "قائمة المستفيدين",
            icon: Icons.list_rounded,
            iconColor: Color(0xFFFFB74D),
            onPressed: null, // Add callback here
          ),
          DrawerSubMenuItem(
            title: "إضافة مستفيد جديد",
            icon: Icons.person_add_rounded,
            iconColor: Color(0xFF4FC3F7),
            onPressed: null, // Add callback here
          ),
          DrawerSubMenuItem(
            title: "سجل التعاملات",
            icon: Icons.history_rounded,
            iconColor: Color(0xFFF06292),
            onPressed: null, // Add callback here
          ),
        ],
        iconColor: Color(0xFF7E57C2),
      ),
      const DrawerMenuItem(
        icon: Icons.account_balance_wallet_rounded,
        title: "البنوك",
        submenus: [
          DrawerSubMenuItem(
            title: "قائمة البنوك المعتمدة",
            icon: Icons.list_rounded,
            iconColor: Color(0xFF64B5F6),
            onPressed: null, // Add callback here
          ),
          DrawerSubMenuItem(
            title: "معلومات الفروع",
            icon: Icons.location_city_rounded,
            iconColor: Color(0xFFA1887F),
            onPressed: null, // Add callback here
          ),
          DrawerSubMenuItem(
            title: "بيانات التواصل",
            icon: Icons.contact_phone_rounded,
            iconColor: Color(0xFF4DB6AC),
            onPressed: null, // Add callback here
          ),
        ],
        iconColor: Color(0xFF5C6BC0),
      ),
      const DrawerMenuItem(
        icon: Icons.dashboard_customize_rounded,
        title: "النماذج",
        submenus: [
          DrawerSubMenuItem(
            title: "نماذج الشيكات",
            icon: Icons.description_rounded,
            iconColor: Color(0xFFBA68C8),
            onPressed: null, // Add callback here
          ),
          DrawerSubMenuItem(
            title: "تخصيص النماذج",
            icon: Icons.edit_rounded,
            iconColor: Color(0xFFFF8A65),
            onPressed: null, // Add callback here
          ),
          DrawerSubMenuItem(
            title: "إعدادات الطباعة",
            icon: Icons.print_rounded,
            iconColor: Color(0xFF7986CB),
            onPressed: null, // Add callback here
          ),
        ],
        iconColor: Color(0xFF26C6DA),
      ),
      const DrawerMenuItem(
        icon: Icons.settings_rounded,
        title: "التفضيلات",
        submenus: [
          DrawerSubMenuItem(
            title: "إعدادات النظام",
            icon: Icons.settings_rounded,
            iconColor: Color(0xFF81C784),
            onPressed: null, // Add callback here
          ),
          DrawerSubMenuItem(
            title: "تخصيص الواجهة",
            icon: Icons.dashboard_customize_rounded,
            iconColor: Color(0xFFFFD54F),
            onPressed: null, // Add callback here
          ),
          DrawerSubMenuItem(
            title: "خيارات العرض",
            icon: Icons.view_compact_rounded,
            iconColor: Color(0xFF64B5F6),
            onPressed: null, // Add callback here
          ),
        ],
        iconColor: Color(0xFF9E9E9E),
      ),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1a1c1e),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(DrawerConstants.borderRadius),
          bottomRight: Radius.circular(DrawerConstants.borderRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: AnimatedContainer(
        duration: DrawerConstants.animationDuration,
        width: isExpanded
            ? DrawerConstants.getDrawerWidth(context)
            : DrawerConstants.collapsedWidth,
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
          // استبدل FlutterLogo بـ GestureDetector
          GestureDetector(
            // onTap: _toggleDrawer, // استدعاء _toggleDrawer عند النقر
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
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: menuItems.length,
      separatorBuilder: (context, index) => const SizedBox(height: 4),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        final isSelected =
            selectedIndex == index; // Store selection state locally

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
      },
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

  // void _toggleDrawer() {
  //   setState(() {
  //     isExpanded = !isExpanded;
  //     if (isExpanded) {
  //       _controller.forward();
  //     } else {
  //       _controller.reverse();
  //     }
  //   });
  // }
}

class DrawerMenuItem {
  final IconData icon;
  final String title;
  final List<DrawerSubMenuItem> submenus; // Changed from List<String>
  final Color? iconColor;

  const DrawerMenuItem({
    required this.icon,
    required this.title,
    this.submenus = const [],
    this.iconColor,
  });
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

class DrawerConstants {
  static double getDrawerWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) return screenWidth * 0.85;
    if (screenWidth < 900) return 320.0;
    return 380.0;
  }

  static const double collapsedWidth = 80.0;
  static const double submenuWidth = 200.0;
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const double borderRadius = 16.0;
  static const double itemSpacing = 8.0;
  static const double menuItemHeight = 56.0;
}
