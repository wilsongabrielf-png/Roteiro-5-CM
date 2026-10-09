import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    final savedName = prefs.getString('name') ?? '';
    final savedEmail = prefs.getString('email') ?? '';

    nameController.text = savedName;
    emailController.text = savedEmail;
  }

  Future<void> saveName(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', value);
  }

  Future<void> saveEmail(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', value);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário Persistente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
              onChanged: saveName,
            ),

            const SizedBox(height: 20),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
              onChanged: saveEmail,
            ),
          ],
        ),
      ),
    );
  }
}