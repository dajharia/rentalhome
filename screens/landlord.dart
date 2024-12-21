import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../data/state.dart';

class LandlordForm extends StatefulWidget {
  final String? landlordId;
  final Map<String, dynamic>? landlordData;

  const LandlordForm({
    super.key,
    this.landlordId,
    this.landlordData,
  });

  @override
  _LandlordFormState createState() => _LandlordFormState();
}

class _LandlordFormState extends State<LandlordForm> {
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  String? selectedState;
  String? selectedDistrict;
  String? selectedHouseType;
  bool hasLatBath = false;
  bool hasParking = false;
  bool hasCourtyard = false;
  int? selectedRooms;
  bool showFloatingButton = false;

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final rentalController = TextEditingController();

  final List<String> houseTypes = [
    'Single Room',
    'Double Room',
    '1BHK',
    '2BHK',
    'Duplex',
    'Bungalow',
    'Apartment',
  ];
  final List<int> roomOptions = List.generate(10, (index) => index + 1);
  final Map<String, List<String>> states = getStatesMap();

  List<String> sortedStates() {
    return states.keys.toList()..sort();
  }

  List<String> sortedDistricts() {
    if (selectedState != null) {
      return List.from(states[selectedState]!)..sort();
    }
    return [];
  }

  Future<void> saveToFirestore() async {
    if (_formKey.currentState!.validate()) {
      try {
        final now =
            DateTime.now().toUtc().add(const Duration(hours: 5, minutes: 30));
        final formattedDate = DateFormat('dd/MM/yyyy hh:mm:ss').format(now);
        final landlordDocRef = widget.landlordId != null
            ? FirebaseFirestore.instance
                .collection('landlords')
                .doc(widget.landlordId)
            : FirebaseFirestore.instance.collection('landlords').doc();
        await landlordDocRef.collection('landlords_detail').doc().set({
          'name': nameController.text,
          'mobile': mobileController.text,
          'email': emailController.text,
          'address': addressController.text,
          'state': selectedState,
          'district': selectedDistrict,
        });

        await landlordDocRef.collection('house_detail').doc().set({
          'house_type': selectedHouseType,
          'rooms': selectedRooms,
          'lat_bath': hasLatBath,
          'parking': hasParking,
          'courtyard': hasCourtyard,
          'rental': rentalController.text,
        });
        await landlordDocRef.collection('status').doc().set({
          'booking': false,
          'status': 'available',
          'timestamp': formattedDate,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data saved successfully!")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    rentalController.addListener(() {
      // Check if rental amount field is filled
      setState(() {
        showFloatingButton = rentalController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    rentalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            controller: _scrollController,
            children: [
              buildTextField(
                controller: nameController,
                label: 'Landlord Name',
                icon: Icons.person,
              ),
              buildTextField(
                controller: mobileController,
                label: 'Mobile No',
                icon: Icons.phone,
                inputType: TextInputType.phone,
              ),
              buildTextField(
                controller: emailController,
                label: 'Email',
                icon: Icons.email,
                inputType: TextInputType.emailAddress,
              ),
              buildTextField(
                controller: addressController,
                label: 'Address',
                icon: Icons.location_on,
              ),
              // State and District dropdowns in Column
              Column(
                children: [
                  buildSearchableDropdown(
                    value: selectedState,
                    items: sortedStates(),
                    label: 'State',
                    icon: Icons.map,
                    onChanged: (value) {
                      setState(() {
                        selectedState = value;
                        selectedDistrict = null;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  buildSearchableDropdown(
                    value: selectedDistrict,
                    items: sortedDistricts(),
                    label: 'District',
                    icon: Icons.place,
                    onChanged: (value) {
                      setState(() {
                        selectedDistrict = value;
                      });
                    },
                  ),
                ],
              ),
              // House Type and Rooms dropdowns in Column
              Column(
                children: [
                  buildSearchableDropdown(
                    value: selectedHouseType,
                    items: houseTypes,
                    label: 'House Type',
                    icon: Icons.home,
                    onChanged: (value) {
                      setState(() {
                        selectedHouseType = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  buildSearchableDropdown(
                    value: selectedRooms?.toString(),
                    items: roomOptions.map((e) => e.toString()).toList(),
                    label: 'Rooms',
                    icon: Icons.meeting_room,
                    onChanged: (value) {
                      setState(() {
                        selectedRooms = int.tryParse(value ?? '');
                      });
                    },
                  ),
                ],
              ),
              buildSwitchTile(
                title: 'Has Lat/Bath',
                value: hasLatBath,
                onChanged: (value) {
                  setState(() {
                    hasLatBath = value;
                  });
                },
              ),
              buildSwitchTile(
                title: 'Has Parking',
                value: hasParking,
                onChanged: (value) {
                  setState(() {
                    hasParking = value;
                  });
                },
              ),
              buildSwitchTile(
                title: 'Has Courtyard',
                value: hasCourtyard,
                onChanged: (value) {
                  setState(() {
                    hasCourtyard = value;
                  });
                },
              ),
              Row(
                children: [
                  const Icon(
                    Icons.currency_rupee,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    flex: 2,
                    child: buildTextField(
                      controller: rentalController,
                      label: 'Rental Amount',
                      inputType: TextInputType.number,
                      icon: Icons.attach_money,
                    ),
                  ),
                  const Spacer(flex: 3),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: showFloatingButton
          ? FloatingActionButton.extended(
              onPressed: () async {
                await saveToFirestore();
                resetFields(); // Reset the fields after saving
              },
              label: const Text('Save'),
              icon: const Icon(Icons.save),
              backgroundColor: Colors.green,
              elevation: 8,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void resetFields() {
    setState(() {
      nameController.clear();
      mobileController.clear();
      emailController.clear();
      addressController.clear();
      rentalController.clear();
      selectedState = null;
      selectedDistrict = null;
      selectedHouseType = null;
      selectedRooms = null;
      hasLatBath = false;
      hasParking = false;
      hasCourtyard = false;
      showFloatingButton = false;
    });
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    IconData? icon,
    TextInputType inputType = TextInputType.text,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        keyboardType: inputType,
        validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
      ),
    );
  }

  Widget buildSearchableDropdown({
    required String? value,
    required List<String> items,
    required String label,
    required IconData icon,
    required Function(String?) onChanged,
  }) {
    return DropdownSearch<String>(
      items: items,
      selectedItem: value,
      onChanged: onChanged,
      popupProps: PopupProps.menu(
        showSearchBox: true, // Keep the search box visible when typing
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: 'Search $label',
          ),
        ),
        itemBuilder: (context, item, isSelected) {
          return ListTile(
            title: Text(item),
          );
        },
        // Customizing popup appearance
        constraints:
            BoxConstraints(maxHeight: 200), // Limit the dropdown height
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget buildSwitchTile({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
