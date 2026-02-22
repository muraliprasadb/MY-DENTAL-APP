import 'package:flutter/material.dart';

class Patient {
  final String name;
  final String phone;
  final String email;
  final String lastVisit;

  const Patient({
    required this.name,
    required this.phone,
    required this.email,
    required this.lastVisit,
  });
}

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key});

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  final List<Patient> _patients = [
    const Patient(
      name: 'John Smith',
      phone: '+1 555-0100',
      email: 'john.smith@email.com',
      lastVisit: '2026-01-15',
    ),
    const Patient(
      name: 'Sara Johnson',
      phone: '+1 555-0101',
      email: 'sara.j@email.com',
      lastVisit: '2026-02-01',
    ),
    const Patient(
      name: 'Mark Lee',
      phone: '+1 555-0102',
      email: 'mark.lee@email.com',
      lastVisit: '2025-12-20',
    ),
  ];

  void _showAddPatientDialog() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Patient'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  _patients.add(Patient(
                    name: nameController.text,
                    phone: phoneController.text,
                    email: emailController.text,
                    lastVisit: 'N/A',
                  ));
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: _patients.isEmpty
          ? const Center(child: Text('No patients found.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _patients.length,
              itemBuilder: (ctx, index) {
                final patient = _patients[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Text(
                        patient.name.isNotEmpty ? patient.name[0] : '?',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(patient.name,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(
                        '${patient.phone}\nLast visit: ${patient.lastVisit}'),
                    isThreeLine: true,
                    trailing: const Icon(Icons.chevron_right),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPatientDialog,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
