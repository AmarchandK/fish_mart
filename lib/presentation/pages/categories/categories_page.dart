import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'id': '1',
        'name': 'Sea Fish',
        'icon': Icons.waves,
        'color': const Color(0xFF0077BE),
        'count': 25,
      },
      {
        'id': '2',
        'name': 'Boat Fish',
        'icon': Icons.sailing,
        'color': const Color(0xFF00A86B),
        'count': 18,
      },
      {
        'id': '3',
        'name': 'Vanchi Fish',
        'icon': Icons.anchor,
        'color': const Color(0xFFFF6B35),
        'count': 12,
      },
      {
        'id': '4',
        'name': 'Meat Products',
        'icon': Icons.restaurant,
        'color': const Color(0xFFE53E3E),
        'count': 8,
      },
      {
        'id': '5',
        'name': 'Fresh Water Fish',
        'icon': Icons.water_drop,
        'color': const Color(0xFF38A169),
        'count': 15,
      },
      {
        'id': '6',
        'name': 'Dried Fish',
        'icon': Icons.local_fire_department,
        'color': const Color(0xFFED8936),
        'count': 10,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${category['name']} selected'),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: (category['color'] as Color)
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          category['icon'] as IconData,
                          size: 32,
                          color: category['color'] as Color,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        category['name'] as String,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${category['count']} items',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
