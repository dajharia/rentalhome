import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'rentar.dart'; // Import Rentar Screen
import 'landlord.dart';
import 'about.dart';
import 'login.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int _selectedIndex = 0;
  // ignore: unused_field
  final String _selectedStatus = 'available'; // Default selected status

  @override
  void initState() {
    super.initState();
  }

  Future<void> _updateStatus(String docId, String status) async {
    try {
      await _firestore.collection('landlords').doc(docId).update({
        'status': status,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Status updated to $status')),
      );
      setState(() {
        // Force a UI update if needed
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating status: $e')),
      );
      print("Error updating status: $e"); // Log the error for debugging
    }
  }

  Future<void> _deleteItem(String docId) async {
    try {
      await _firestore.collection('landlords').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Landlord deleted successfully')),
      );
      setState(() {}); // Re-render the screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting landlord: $e')),
      );
    }
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showStatusDialog(String docId) async {
    try {
      final statusSnapshot = await _firestore
          .collection('landlords')
          .doc(docId)
          .collection('status')
          .get();
      final statusData = statusSnapshot.docs.isNotEmpty
          ? statusSnapshot.docs.first.data()
          : {};
      String? currentStatus = statusData['status'];

      showDialog(
        context: context,
        builder: (context) {
          String? selectedStatus = currentStatus;
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Change Status'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text('Available'),
                        leading: Radio<String>(
                          value: 'available',
                          groupValue: selectedStatus,
                          onChanged: (value) {
                            setState(() {
                              selectedStatus = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Pending'),
                        leading: Radio<String>(
                          value: 'pending',
                          groupValue: selectedStatus,
                          onChanged: (value) {
                            setState(() {
                              selectedStatus = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Booked'),
                        leading: Radio<String>(
                          value: 'booked',
                          groupValue: selectedStatus,
                          onChanged: (value) {
                            setState(() {
                              selectedStatus = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      try {
                        final statusDoc = statusSnapshot.docs.first.reference;
                        await statusDoc.update({'status': selectedStatus});

                        // Firestore में स्टेटस अपडेट करने के बाद स्क्रीन को रीफ़्रेश करें
                        setState(() {
                          currentStatus = selectedStatus;
                        });
                        Navigator.of(context).pop();
                        // सक्रिय विंडो को रीफ़्रेश करें
                        setState(() {});
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error in updating: $e')),
                        );
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            },
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error finding status: $e')),
      );
    }
  }

  void _showEditDialog(
      String landlordId, Map<String, dynamic> currentData) async {
    final TextEditingController nameController =
        TextEditingController(text: currentData['name']);
    final TextEditingController mobileController =
        TextEditingController(text: currentData['mobile']);
    final TextEditingController emailController =
        TextEditingController(text: currentData['email']);
    final TextEditingController addressController =
        TextEditingController(text: currentData['address']);
    final TextEditingController houseTypeController =
        TextEditingController(); // House Type Controller

    // Fetch house_type data
    DocumentSnapshot houseDoc = await _firestore
        .collection('landlords')
        .doc(landlordId)
        .collection('house_detail')
        .doc('house_id') // Provide the correct house_id or dynamically fetch it
        .get();
    Map<String, dynamic> houseData = houseDoc.data() as Map<String, dynamic>;
    houseTypeController.text = houseData['house_type'] ?? 'N/A';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Landlord Details'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: mobileController,
                  decoration: const InputDecoration(labelText: 'Mobile'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                ),
                TextField(
                  controller: houseTypeController,
                  decoration: const InputDecoration(labelText: 'House Type'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final newData = {
                  'name': nameController.text,
                  'mobile': mobileController.text,
                  'email': emailController.text,
                  'address': addressController.text,
                };
                final houseData = {
                  'house_type': houseTypeController.text,
                };
                _firestore
                    .collection('landlords')
                    .doc(landlordId)
                    .update(newData);
                _firestore
                    .collection('landlords')
                    .doc(landlordId)
                    .collection('house_detail')
                    .doc(
                        'house_id') // Provide the correct house_id or dynamically fetch it
                    .update(houseData);
                Navigator.of(context).pop();
                setState(() {}); // Rebuild the screen to reflect changes
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _getScreen() {
    switch (_selectedIndex) {
      case 0:
        return _buildAdminScreen();
      case 1:
        return RenterScreen(scrollController: ScrollController());
      case 2:
        return const LandlordForm();
      case 3:
        return const Aboutpage();
      default:
        return _buildAdminScreen();
    }
  }

  Widget _buildAdminScreen() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collectionGroup('landlords_detail')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No landlords found!'));
        } else {
          final landlords = snapshot.data!.docs;

          return ListView.builder(
            itemCount: landlords.length,
            itemBuilder: (context, index) {
              var landlordDetail = landlords[index];
              var landlordId = landlordDetail.reference.parent.parent!.id;
              var landlordData = landlordDetail.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(10),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Landlord Name: ${landlordData['name'] ?? 'N/A'}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('landlords')
                                .doc(landlordId)
                                .collection('status')
                                .snapshots(),
                            builder: (context, statusSnapshot) {
                              if (statusSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              if (!statusSnapshot.hasData ||
                                  statusSnapshot.data!.docs.isEmpty) {
                                return const Icon(Icons.error,
                                    color: Colors.grey);
                              }

                              return Row(
                                children:
                                    statusSnapshot.data!.docs.map((statusDoc) {
                                  var statusData =
                                      statusDoc.data() as Map<String, dynamic>;
                                  var status =
                                      statusData['status'] ?? 'inactive';

                                  Color statusColor;
                                  IconData statusIcon;

                                  switch (status) {
                                    case 'available':
                                      statusColor = Colors.green;
                                      statusIcon = Icons.check_circle;
                                      break;
                                    case 'pending':
                                      statusColor = Colors.yellow;
                                      statusIcon = Icons.hourglass_empty;
                                      break;
                                    case 'booked':
                                      statusColor = Colors.red;
                                      statusIcon = Icons.cancel;
                                      break;
                                    default:
                                      statusColor = Colors.grey;
                                      statusIcon = Icons.error;
                                      break;
                                  }

                                  return Icon(
                                    statusIcon,
                                    color: statusColor,
                                    size: 20,
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text('Mobile: ${landlordData['mobile'] ?? 'N/A'}'),
                      Text('Email: ${landlordData['email'] ?? 'N/A'}'),
                      Text(
                        'Address: ${landlordData['address'] ?? ''}, ${landlordData['district'] ?? ''}, ${landlordData['state'] ?? ''}',
                      ),
                      const Divider(),

                      // Action Buttons (Edit, Delete, Book)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _showEditDialog(landlordId, landlordData);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _deleteItem(landlordId);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.bookmark),
                            onPressed: () {
                              _showStatusDialog(landlordId);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(toggleTheme: () {}, isDarkTheme: false)),
            );
          },
        ),
      ),
      body: _getScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings),
            label: 'Admin',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Renter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Landlord',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
