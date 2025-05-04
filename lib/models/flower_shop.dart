// lib/models/flower_shop.dart

class FlowerItem {
  final String name;
  final double price;
  final String imageUrl;

  FlowerItem({required this.name, required this.price, required this.imageUrl});
}

class FlowerShop {
  final String id;
  final String name;
  final String imageUrl;
  final String logoUrl;
  final String description;
  final double rating;
  final double deliveryPrice;
  final String address;
  final List<FlowerItem> items;

  FlowerShop({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.logoUrl,
    required this.description,
    required this.rating,
    required this.deliveryPrice,
    required this.address,
    required this.items,
  });
}

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
      FlowerItem(name: 'Wild Garden', price: 4900, imageUrl: 'assets/flowers/5flo.jpg'),
      FlowerItem(name: 'Bright Emotions', price: 4100, imageUrl: 'assets/flowers/1flo.jpg'),
      FlowerItem(name: 'Summer Joy', price: 4450, imageUrl: 'assets/flowers/2flo.jpg'),
    ],
  ),
];
