import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'registration_provider.dart';
import 'user_model.dart';
import 'login_screen.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  void openUpdateDialog(BuildContext context, UserModel user) {
    final nameInputController = TextEditingController(text: user.name);
    final emailInputController = TextEditingController(text: user.email);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Update User Information"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameInputController, decoration: const InputDecoration(labelText: "Full Name")),
            TextField(controller: emailInputController, decoration: const InputDecoration(labelText: "Email Address")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              final updatedUserData = UserModel(
                id: user.id,
                name: nameInputController.text,
                email: emailInputController.text,
                password: user.password,
              );
              await context.read<RegistrationProvider>().modifyUser(updatedUserData);
              if (dialogContext.mounted) Navigator.pop(dialogContext);
            },
            child: const Text("Save Changes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final regProvider = context.watch<RegistrationProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Database List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
            },
          )
        ],
      ),
      body: regProvider.isPageLoading
          ? const Center(child: CircularProgressIndicator())
          : regProvider.savedUsersList.isEmpty
          ? const Center(child: Text("No data saved in SQLite database yet.", style: TextStyle(fontSize: 16, color: Colors.grey)))
          : ListView.builder(
        itemCount: regProvider.savedUsersList.length,
        itemBuilder: (context, index) {
          final user = regProvider.savedUsersList[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            elevation: 3,
            child: ListTile(
              title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              subtitle: Text(user.email),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => openUpdateDialog(context, user),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => regProvider.deleteUser(user.id),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
