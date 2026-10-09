import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageScreen extends StatefulWidget {
  const PageScreen({super.key});

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  String selectedPage = 'Página A';

  @override
  void initState() {
    super.initState();
    loadPage();
  }

  Future<void> loadPage() async {
    final prefs = await SharedPreferences.getInstance();

    final savedPage = prefs.getString('lastPage');

    if (!mounted) return;

    setState(() {
      selectedPage = savedPage ?? 'Página A';
    });
  }

  Future<void> selectPage(String page) async {
    setState(() {
      selectedPage = page;
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastPage', page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Última página acessada'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Página selecionada: $selectedPage',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => selectPage('Página A'),
              child: const Text('Página A'),
            ),

            ElevatedButton(
              onPressed: () => selectPage('Página B'),
              child: const Text('Página B'),
            ),

            ElevatedButton(
              onPressed: () => selectPage('Página C'),
              child: const Text('Página C'),
            ),
          ],
        ),
      ),
    );
  }
}