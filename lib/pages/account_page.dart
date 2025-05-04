import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/auth.dart';
import 'map_page.dart';  // Импортируем MapPage
import '../services/user_preferences.dart';  // Для сохранения настроек пользователя

class AccountPage extends StatefulWidget {
  final void Function() onLogOut;
  final User user;

  const AccountPage({
    super.key,
    required this.onLogOut,
    required this.user,
  });

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  TextEditingController biographyController = TextEditingController();  // Контроллер для биографии

  @override
  void initState() {
    super.initState();
    biographyController.text = widget.user.biography;  // Если биография есть, заполняем её
  }

  void _saveBiography() {
    // Сохраняем биографию
    final updatedBiography = biographyController.text;
    setState(() {
      widget.user.biography = updatedBiography;  // Обновляем биографию в объекте пользователя
    });

    // Можно также добавить сохранение в localStorage или базу данных
    UserPreferences.saveBiography(updatedBiography);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: widget.onLogOut,  // Выйти из аккаунта
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(  // Для прокрутки, если содержимое не помещается
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.user.profileImageUrl),
              ),
              const SizedBox(height: 16),
              Text(
                '${widget.user.firstName} ${widget.user.lastName}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Biography:',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: biographyController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter your biography...',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveBiography,
                child: const Text('Save Biography'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MapPage(),  // Координаты Астаны
                    ),
                  );
                },
                child: const Text('View Map'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
