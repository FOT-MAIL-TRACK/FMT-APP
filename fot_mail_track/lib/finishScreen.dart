import 'package:flutter/material.dart';
import 'package:fot_mail_track/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({super.key});

  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  final AuthService _authService = AuthService();
  List<dynamic> pData = [];
  List<dynamic> LetterData = [];
  List<dynamic> filteredData = [];
  String? userRegNo;
  DateTime? selectedDate;
  bool isFiltered = false;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _fetchLetters(String pickedDate) async {
    if (userRegNo != null) {
      try {
        final fetchedData = await _authService.fetchLetters(userRegNo!);
        List<dynamic> filtered = [];

        if (fetchedData.isNotEmpty) {
          for (var letter in fetchedData) {
            DateTime date = DateTime.parse(letter['createdAt'].toString());
            String formattedDate =
                "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

            if (pickedDate == formattedDate) {
              filtered.add(letter);
            }
          }

          setState(() {
            filteredData = filtered;
            isFiltered = true;
          });
        }
      } catch (error) {
        print("Error fetching letters: $error");
      }
    }
  }

  //Clear filter method
  Future<void> _clearFilter() async {
    setState(() {
      selectedDate = null;
      isFiltered = false;
      filteredData.clear();
    });
  }

  Future<void> _loadUserId() async {
    userRegNo = await getUserInfo();
    setState(() {});
  }

  Future<String?> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userRegNo = prefs.getString('user_Regno');
    return userRegNo;
  }

  //Date Picker Method
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      // Convert selected date to the required format
      String formattedDate = "${picked.toIso8601String().split('T')[0]}";
      _fetchLetters(formattedDate);
      // Use this formattedDate for filtering
      print("Formatted Date is : ${formattedDate}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finished - "),
        actions: [
          InkWell(onTap: _clearFilter, child: Text("Clear Filter")),
          const SizedBox(
            width: 20,
          ),
          Text("| Filter By Date : "),
          IconButton(
            icon: Image.asset('assets/calendar.png'),
            onPressed: () => _selectDate(context),
          ),
          if (selectedDate != null)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  selectedDate = null;
                });
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.15),
        child: Column(
          children: [
            FutureBuilder(
                future: _authService.fetchLetters(userRegNo.toString()),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    // Update pData with the snapshot data

                    pData = snapshot.data
                        .where((letter) => letter['status'] == 'Completed')
                        .toList();
                    // Determine which data to display
                    final displayData = isFiltered ? filteredData : pData;

                    if (displayData.isEmpty && isFiltered) {
                      return const Center(
                        child: Text('No letters found for selected date'),
                      );
                    }

                    return Expanded(
                      child: ListView.builder(
                          itemCount: displayData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal:
                                        16.0), // Spacing between list tiles
                                decoration: BoxDecoration(
                                  color: Colors.white, // Background color
                                  borderRadius: BorderRadius.circular(
                                      12.0), // Rounded corners
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), // Shadow color
                                      spreadRadius:
                                          2, // How much the shadow spreads
                                      blurRadius:
                                          5, // The blur effect of the shadow
                                      offset:
                                          const Offset(0, 3), // Shadow position
                                    ),
                                  ],
                                ),
                                // ... rest of your container code ...
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Letter ID : ${displayData[index]['uniqueID']}",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Senders Name: ${displayData[index]['sender']['name']}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Receiver Name: ${displayData[index]['receiver']['name']}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
