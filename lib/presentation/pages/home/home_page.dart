import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart' hide CarouselController;

import '../../../core/config/app_config.dart';
import '../../widgets/category_card.dart';
import '../../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _bannerImages = [
    'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800',
    'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=800',
    'https://images.unsplash.com/photo-1563379091339-03246963d30a?w=800',
  ];

  final List<Map<String, dynamic>> _categories = [
    {
      'id': '1',
      'name': 'Sea Fish',
      'icon': Icons.waves,
      'color': const Color(0xFF0077BE),
      'image':
          'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=300',
    },
    {
      'id': '2',
      'name': 'Boat Fish',
      'icon': Icons.sailing,
      'color': const Color(0xFF00A86B),
      'image':
          'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=300',
    },
    {
      'id': '3',
      'name': 'Vanchi Fish',
      'icon': Icons.anchor,
      'color': const Color(0xFFFF6B35),
      'image':
          'https://images.unsplash.com/photo-1563379091339-03246963d30a?w=300',
    },
    {
      'id': '4',
      'name': 'Meat Products',
      'icon': Icons.restaurant,
      'color': const Color(0xFFE53E3E),
      'image':
          'https://images.unsplash.com/photo-1588168333986-5078d3ae3976?w=300',
    },
  ];

  final List<Map<String, dynamic>> _featuredProducts = [
    {
      'id': '1',
      'name': 'Fresh Salmon',
      'price': 299.99,
      'originalPrice': 399.99,
      'image':
          'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=300',
      'rating': 4.5,
      'isAvailable': true,
    },
    {
      'id': '2',
      'name': 'King Fish',
      'price': 249.99,
      'originalPrice': null,
      'image':
          'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=300',
      'rating': 4.8,
      'isAvailable': true,
    },
    {
      'id': '3',
      'name': 'Fresh Prawns',
      'price': 399.99,
      'originalPrice': 499.99,
      'image':
          'https://images.unsplash.com/photo-1563379091339-03246963d30a?w=300',
      'rating': 4.6,
      'isAvailable': false,
    },
    {
      'id': '4',
      'name': 'Tuna Steaks',
      'price': 199.99,
      'originalPrice': null,
      'image':
          'https://images.unsplash.com/photo-1588168333986-5078d3ae3976?w=300',
      'rating': 4.3,
      'isAvailable': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to ${AppConfig.appName}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Fresh Fish & Seafood Delivery',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(
                  context,
                ).textTheme.bodySmall?.color?.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications - Coming Soon')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Carousel
            _buildHeroCarousel(),

            const SizedBox(height: 24),

            // Categories Section
            _buildCategoriesSection(),

            const SizedBox(height: 24),

            // Featured Products Section
            _buildFeaturedProductsSection(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCarousel() {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: _bannerImages.length,
        itemBuilder: (context, index) {
          final imageUrl = _bannerImages[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.5),
                  ],
                ),
              ),
              child: const Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Fresh & Quality Seafood',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to categories page
                },
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: CategoryCard(
                  name: category['name'] as String,
                  icon: category['icon'] as IconData,
                  color: category['color'] as Color,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${category['name']} selected')),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedProductsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Products',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to products page
                },
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _featuredProducts.length,
            itemBuilder: (context, index) {
              final product = _featuredProducts[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ProductCard(
                  name: product['name'] as String,
                  price: (product['price'] as num).toDouble(),
                  originalPrice: product['originalPrice'] as double?,
                  imageUrl: product['image'] as String,
                  rating: (product['rating'] as num).toDouble(),
                  isAvailable: product['isAvailable'] as bool,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product['name']} selected')),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
