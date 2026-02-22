import 'package:flutter/material.dart';

class Appointment {
  final String patientName;
  final String date;
  final String time;
  final String treatment;

  const Appointment({
    required this.patientName,
    required this.date,
    required this.time,
    required this.treatment,
  });
}

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final List<Appointment> _appointments = [
    const Appointment(
      patientName: 'John Smith',
      date: '2026-02-23',
      time: '09:00 AM',
      treatment: 'Teeth Cleaning',
    ),
    const Appointment(
      patientName: 'Sara Johnson',
      date: '2026-02-23',
      time: '10:30 AM',
      treatment: 'Cavity Filling',
    ),
    const Appointment(
      patientName: 'Mark Lee',
      date: '2026-02-24',
      time: '02:00 PM',
      treatment: 'Root Canal',
    ),
  ];

  void _showAddAppointmentDialog() {
    final nameController = TextEditingController();
    final dateController = TextEditingController();
    final timeController = TextEditingController();
    final treatmentController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('New Appointment'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Patient Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(
                  labelText: 'Date (YYYY-MM-DD)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: timeController,
                decoration: const InputDecoration(
                  labelText: 'Time (e.g. 09:00 AM)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: treatmentController,
                decoration: const InputDecoration(
                  labelText: 'Treatment',
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
                  _appointments.add(Appointment(
                    patientName: nameController.text,
                    date: dateController.text,
                    time: timeController.text,
                    treatment: treatmentController.text,
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
        title: const Text('Appointments'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _appointments.isEmpty
          ? const Center(child: Text('No appointments scheduled.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _appointments.length,
              itemBuilder: (ctx, index) {
                final appt = _appointments[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.calendar_today, color: Colors.white),
                    ),
                    title: Text(appt.patientName,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(
                        '${appt.date} at ${appt.time}\n${appt.treatment}'),
                    isThreeLine: true,
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAppointmentDialog,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
