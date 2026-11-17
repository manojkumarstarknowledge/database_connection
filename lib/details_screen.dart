import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'registration_provider.dart';
import 'user_model.dart';
import 'login_screen.dart';

class DetailsScreen extends StatelessWidget {
<<<<<<< HEAD
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
            TextField(controller: nameInputController,
                decoration: const InputDecoration(labelText: "Full Name")),
            TextField(controller: emailInputController,
                decoration: const InputDecoration(labelText: "Email Address")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancel")),
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

=======
>>>>>>> temp-branch
  @override
  Widget build(BuildContext context) {
    final regProvider = Provider.of<RegistrationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: Text("Database List"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: buildBody(context, regProvider),
    );
  }
<<<<<<< HEAD
=======


  Widget buildBody(BuildContext context, RegistrationProvider regProvider) {
    if (regProvider.isPageLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (regProvider.savedUsersList.isEmpty) {
      return Center(
        child: Text(
          "No data saved in SQLite database yet.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }


    return ListView.builder(
      itemCount: regProvider.savedUsersList.length,
      itemBuilder: (context, index) {
        final user = regProvider.savedUsersList[index];

        return Card(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          elevation: 3,
          child: ListTile(
            title: Text(
              user.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(user.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    openUpdateDialog(context, user);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    regProvider.deleteUser(user.id);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void openUpdateDialog(BuildContext context, UserModel user) {
    final nameController = TextEditingController(text: user.name);
    final emailController = TextEditingController(text: user.email);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text("Update User Information"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Full Name"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email Address"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final updatedUser = UserModel(
                  id: user.id,
                  name: nameController.text,
                  email: emailController.text,
                  password: user.password,
                );

                final provider = Provider.of<RegistrationProvider>(
                  context,
                  listen: false,
                );
                await provider.modifyUser(updatedUser);
                Navigator.pop(dialogContext);
              },
              child: Text("Save Changes"),
            ),
          ],
        );
      },
    );
  }
>>>>>>> temp-branch
}