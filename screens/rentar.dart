import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class RenterScreen extends StatefulWidget {
  const RenterScreen({super.key, required ScrollController scrollController});

  @override
  _RenterScreenState createState() => _RenterScreenState();
}

class _RenterScreenState extends State<RenterScreen>
    with AutomaticKeepAliveClientMixin<RenterScreen> {
  final ScrollController _scrollController = ScrollController();

  // Function to make a phone call
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch the dialer')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required when using AutomaticKeepAliveClientMixin

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collectionGroup('landlords_detail')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No landlords found!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          final landlords = snapshot.data!.docs;

          return ListView.builder(
            controller: _scrollController,
            itemCount: landlords.length,
            itemBuilder: (context, index) {
              var landlordDetail = landlords[index];
              var landlordId = landlordDetail.reference.parent.parent!.id;
              var landlordData = landlordDetail.data() as Map<String, dynamic>;

              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: const Color.fromARGB(255, 6, 48, 83),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row with Name and Status Icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            landlordData['name'] ?? 'N/A',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 245, 250, 147),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('landlords')
                                .doc(landlordId)
                                .collection('status')
                                .snapshots(),
                            builder: (context, statusSnapshot) {
                              if (statusSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2));
                              }

                              if (!statusSnapshot.hasData ||
                                  statusSnapshot.data!.docs.isEmpty) {
                                return const Icon(Icons.error,
                                    color: Colors.grey);
                              }

                              var statusData = statusSnapshot.data!.docs.first
                                  .data() as Map<String, dynamic>;
                              var status = statusData['status'] ?? 'inactive';

                              Color statusColor;
                              IconData statusIcon;

                              switch (status) {
                                case 'available':
                                  statusColor = Colors.green;
                                  statusIcon = Icons.check_circle;
                                  break;
                                case 'pending':
                                  statusColor = Colors.orange;
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
                                size: 22,
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Mobile Number with GestureDetector and "Call Now" text
                      GestureDetector(
                        onTap: () {
                          _makePhoneCall(landlordData['mobile'] ?? 'N/A');
                        },
                        child: Row(
                          children: [
                            Text(
                              '📞 Mobile: ${landlordData['mobile'] ?? 'N/A'}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 252, 252, 252),
                              ),
                            ),
                            const Text(
                              ' Call Now',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '✉️ Email: ${landlordData['email'] ?? 'N/A'}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 252, 252, 252),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Address
                      Text(
                        '📍 Address: ${landlordData['address'] ?? ''}, ${landlordData['district'] ?? ''}, ${landlordData['state'] ?? ''}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const Divider(thickness: 1, height: 20),
                      // Combined House Details Section
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('landlords')
                            .doc(landlordId)
                            .collection('house_detail')
                            .snapshots(),
                        builder: (context, houseSnapshot) {
                          if (houseSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (!houseSnapshot.hasData ||
                              houseSnapshot.data!.docs.isEmpty) {
                            return const Text(
                              'No house details available!',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.redAccent,
                              ),
                            );
                          }

                          final houseDetails = houseSnapshot.data!.docs;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: houseDetails.map((houseDoc) {
                              var houseData =
                                  houseDoc.data() as Map<String, dynamic>;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "House Details:",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 252, 252, 252),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '🏠 House Type: ${houseData['house_type'] ?? 'N/A'}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 252, 252, 252),
                                    ),
                                  ),
                                  Text(
                                    '🛏️ Rooms: ${houseData['rooms'] ?? 'N/A'}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 252, 252, 252),
                                    ),
                                  ),
                                  Text(
                                    '💰 Rental Amount: ₹${houseData['rental'] ?? 'N/A'}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 252, 252, 252),
                                    ),
                                  ),
                                  Text(
                                    '🚻 Lat Bath: ${houseData['lat_bath'] == true ? "Yes" : "No"}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 252, 252, 252),
                                    ),
                                  ),
                                  Text(
                                    '🚗 Parking: ${houseData['parking'] == true ? "Yes" : "No"}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 252, 252, 252),
                                    ),
                                  ),
                                  Text(
                                    '🌳 Courtyard: ${houseData['courtyard'] == true ? "Yes" : "No"}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 252, 252, 252),
                                    ),
                                  ),
                                  const Divider(),
                                ],
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
