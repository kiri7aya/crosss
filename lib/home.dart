import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';  // Import GoRouter for navigation
import 'pages/home_page.dart';
import 'pages/favorites_page.dart';
import 'pages/my_orders_page.dart';
import 'pages/account_page.dart';
import '../models/user.dart';  // Ensure this is correctly imported
import '../models/auth.dart';  // For log out logic
import '../models/flower_shop.dart';  // Import FlowerShop model

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  final User _currentUser = User(
    firstName: 'Zhansaya',
    lastName: 'Serikkali',
    profileImageUrl: 'https://i.pinimg.com/736x/8d/0f/9a/8d0f9ad893bafd6a80b34dcf2354c463.jpg',  // Removed 'role' and 'points'
    darkMode: true,
  );

  List<Map<String, dynamic>> addedItems = [];

  // Track favorite products globally
  Set<String> favoriteProducts = {};

  // Track favorite shops globally
  Set<String> favoriteShops = {};

  // Your list of all flower shops (example data)
  final List<FlowerShop> flowerShops = [
    FlowerShop(
      id: '1',
      name: 'Rose Garden',
      imageUrl: 'assets/shop/1shop.jpg',
      logoUrl: 'https://i.pinimg.com/736x/fd/bc/f3/fdbcf3a28a419974794931f8cdc6a245.jpg',
      description: 'National flower network. Best prices in Kazakhstan! Premium quality & fast delivery.',
      rating: 4.9,
      deliveryPrice: 990,
      address: 'Astana, Dostyk Avenue 24',
      items: [
        FlowerItem(name: 'Red Roses', price: 4500, imageUrl: 'assets/flowers/7flo.jpg'),
        FlowerItem(name: 'White Tulips', price: 3800, imageUrl: 'assets/flowers/5flo.jpg'),
        FlowerItem(name: 'Sunflower Delight', price: 5200, imageUrl: 'assets/flowers/2flo.jpg'),
        FlowerItem(name: 'Peony Blush', price: 4900, imageUrl: 'assets/flowers/3flo.jpg'),
        FlowerItem(name: 'Lily Love', price: 4300, imageUrl: 'assets/flowers/6flo.jpg'),
        FlowerItem(name: 'Spring Basket', price: 5700, imageUrl: 'assets/flowers/1flo.jpg'),
      ],
    ),
    FlowerShop(
      id: '2',
      name: 'Bloom Studio',
      imageUrl: 'assets/shop/2shop.jpg',
      logoUrl: 'https://i.pinimg.com/736x/84/8b/ee/848bee42a682907f882e7a1a4c5a427f.jpg',
      description: 'Elegant bouquets & custom flower designs. We deliver happiness.',
      rating: 4.5,
      deliveryPrice: 800,
      address: 'Astana, Abay Street 45',
      items: [
        FlowerItem(name: 'Pastel Dreams', price: 4700, imageUrl: 'assets/flowers/1flo.jpg'),
        FlowerItem(name: 'White Grace', price: 4100, imageUrl: 'assets/flowers/4flo.jpg'),
        FlowerItem(name: 'Orchid Elegance', price: 6900, imageUrl: 'assets/flowers/7flo.jpg'),
        FlowerItem(name: 'Romantic Pink', price: 5200, imageUrl: 'assets/flowers/5flo.jpg'),
        FlowerItem(name: 'Spring Joy', price: 3900, imageUrl: 'assets/flowers/2flo.jpg'),
        FlowerItem(name: 'Mixed Colors', price: 4500, imageUrl: 'assets/flowers/3flo.jpg'),
      ],
    ),
    FlowerShop(
      id: '3',
      name: 'Petal Palace',
      imageUrl: 'assets/shop/3shop.jpg',
      logoUrl: 'https://i.pinimg.com/736x/b7/98/1c/b7981cb16b711653571d6149722c3bd7.jpg',
      description: 'Stylish and trendy floral arrangements. Express yourself with flowers!',
      rating: 3.9,
      deliveryPrice: 750,
      address: 'Astana, Baitursynov Street 18',
      items: [
        FlowerItem(name: 'Color Mix Box', price: 4300, imageUrl: 'assets/flowers/4flo.jpg'),
        FlowerItem(name: 'Peach Rose Set', price: 4600, imageUrl: 'assets/flowers/6flo.jpg'),
        FlowerItem(name: 'Fresh Daisy Bundle', price: 3400, imageUrl: 'assets/flowers/7flo.jpg'),
        FlowerItem(name: 'Wild Garden', price: 4900, imageUrl: 'assets/flowers/8flo.jpg'),
        FlowerItem(name: 'Bright Emotions', price: 4100, imageUrl: 'assets/flowers/1flo.jpg'),
        FlowerItem(name: 'Summer Joy', price: 4450, imageUrl: 'assets/flowers/2flo.jpg'),
      ],
    ),
  ];

  // List of products (Example data)
  final List<Map<String, dynamic>> allProducts = [
    {
      'name': 'Red Roses',
      'price': 4500,
      'category': 'Flowers',
      'imageUrl': 'assets/flowers/1flo.jpg',
    },
    {
      'name': 'Peony Blush',
      'price': 4900,
      'category': 'Flowers',
      'imageUrl': 'assets/flowers/2flo.jpg',
    },
    {
      'name': 'Lily Love',
      'price': 4300,
      'category': 'Flowers',
      'imageUrl': 'assets/flowers/3flo.jpg',
    },
    {
      'name': 'Spring Basket',
      'price': 5700,
      'category': 'Decor',
      'imageUrl': 'assets/flowers/decor.jpg',
    },
    {
      'name': 'Gift Box',
      'price': 7000,
      'category': 'Gift Sets',
      'imageUrl': 'assets/flowers/gift.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      // Pass addedItems and onAddToCart to HomePage
      HomePage(
        addedItems: addedItems,
        onAddToCart: (item) {
          setState(() {
            addedItems.add(item);  // Add item to cart
          });
        },
        favoriteProducts: favoriteProducts,  // Pass favoriteProducts
        favoriteShops: favoriteShops,  // Pass favoriteShops
        onFavoriteProductToggle: (productName) {
          setState(() {
            if (favoriteProducts.contains(productName)) {
              favoriteProducts.remove(productName);
            } else {
              favoriteProducts.add(productName);
            }
          });
        },
        onFavoriteShopToggle: (shopName) {
          setState(() {
            if (favoriteShops.contains(shopName)) {
              favoriteShops.remove(shopName);
            } else {
              favoriteShops.add(shopName);
            }
          });
        },
      ),
      // Pass addedItems to MyOrdersPage
      MyOrdersPage(addedItems: addedItems),
      // Pass favoriteProducts and favoriteShops to FavoritesPage
      FavoritesPage(
        favoriteProducts: favoriteProducts,
        favoriteShops: favoriteShops,  // Pass favoriteShops to FavoritesPage
        allProducts: allProducts,     // Pass allProducts to FavoritesPage
        allShops: flowerShops,        // Pass flowerShops to FavoritesPage
      ),
      AccountPage(
        onLogOut: () async {
          // Perform sign out
          await FlowwowAuth().signOut();
          // Redirect to login page after logging out
          context.go('/login');  // Navigate to login using GoRouter
        },
        user: _currentUser,  // Passing user data to AccountPage
      ),
    ];

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'My Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}
