import 'package:flutter/material.dart';
import 'package:kachi/screens/test/inventory_screen.dart';
import 'package:kachi/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: buildProductImage('assets/images/man_image.png'),
        actions: [
          iconButtonStyleAnass(const Icon(Icons.notifications_none)),
          const SizedBox(width: 3),
          iconButtonStyleAnass(const Icon(Icons.add)),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Search bar
            _buildSearchBar(),
            const SizedBox(height: 24),
            // Statistics
            _buildStatistics(),
            const SizedBox(height: 24),
            // Recent documents
            _buildRecentDocumentsHeader(),
            const SizedBox(height: 16),
            // Recent documents list
            Expanded(child: _buildRecentDocumentsList()),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Color(0xFF2D3436)),
                  prefixIcon: Icon(Icons.search, color: Color(0xFF2D3436)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatistics() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatCard(
          icon: Icons.shopping_bag_outlined,
          title: '60',
          subtitle: 'Out of stock',
          color: Colors.blue,
        ),
        _buildStatCard(
          icon: Icons.storefront_outlined,
          title: '360',
          subtitle: 'Total items',
          color: Colors.blue,
        ),
        _buildStatCard(
          icon: Icons.person_outlined,
          title: '360',
          subtitle: 'Total clients',
          color: Colors.blue,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentDocumentsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Recent Documents',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'View All',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentDocumentsList() {
    // Sample data for recent documents
    final List<Map<String, dynamic>> recentItems = [
      {
        'name': 'Coca Cola',
        'image': 'assets/images/whatsapp.png',
        'user': 'Olivia Thornton',
        'time': '20 min',
        'trend': 'up',
      },
      {
        'name': 'Doritos',
        'image': 'assets/images/whatsapp.png',
        'user': 'Laura Kennedy',
        'time': '1h ago',
        'trend': 'down',
      },
      {
        'name': 'Lays',
        'image': 'assets/images/whatsapp.png',
        'user': 'Carmen Dominguez',
        'time': '8:45 am',
        'trend': 'up',
      },
      {
        'name': 'Kitkat',
        'image': 'assets/images/whatsapp.png',
        'user': 'Manuel Flores',
        'time': 'Yesterday',
        'trend': 'neutral',
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      // Added cacheExtent for better scrolling performance.
      cacheExtent: 200,
      itemCount: recentItems.length,
      itemBuilder: (context, index) {
        final item = recentItems[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: _buildDocumentItem(
            name: item['name'],
            image: item['image'],
            user: item['user'],
            time: item['time'],
            trend: item['trend'],
          ),
        );
      },
    );
  }

  Widget _buildDocumentItem({
    required String name,
    required String image,
    required String user,
    required String time,
    required String trend,
  }) {
    IconData trendIcon;
    Color trendColor;

    switch (trend) {
      case 'up':
        trendIcon = Icons.trending_up;
        trendColor = Colors.green;
        break;
      case 'down':
        trendIcon = Icons.trending_down;
        trendColor = Colors.red;
        break;
      default:
        trendIcon = Icons.trending_flat;
        trendColor = Colors.orange;
    }

    return RepaintBoundary(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                // Placeholder for product image
                child: Icon(Icons.shopping_bag, color: Colors.blue.shade300),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.person_outline,
                          size: 14, color: Color(0xFF2D3436)),
                      const SizedBox(width: 4),
                      Text(
                        user,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              trendIcon,
              color: trendColor,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductImage(String image) {
    return Container(
      width: 50,
      height: 50,
      padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          image,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          cacheWidth: 50,
          cacheHeight: 50,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.person,
              color: Color(0xFF2D3436),
              size: 30,
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
              // Home screen (current screen)
              break;
            case 1:
              // Navigate to Documents screen
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const InventoryScreen(),
                ),
              );
              break;
            case 3:
              // Navigate to Reports screen
              break;
            case 4:
              // Navigate to Settings screen
              break;
          }
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_outlined),
            label: 'Documents',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            label: 'Inventory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment_outlined),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  // Functions
}

Widget iconButtonStyleAnass(Widget icon) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.1),
          blurRadius: 10,
          spreadRadius: 0,
        ),
      ],
    ),
    child: IconButton(
      icon: icon,
      color: const Color(0xFF2D3436),
      onPressed: () {},
    ),
  );
}
