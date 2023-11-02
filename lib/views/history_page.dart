import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class BookingHistoryPage extends StatefulWidget {
  final String bookingId;

  BookingHistoryPage({required this.bookingId});

  @override
  _BookingHistoryPageState createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage> {
  late DatabaseReference _bookingRef;
  String _qrData = '';

  @override
  void initState() {
    super.initState();

    // Get a reference to the booking node in the database
    _bookingRef = FirebaseDatabase.instance
        .reference()
        .child('bookings')
        .child(widget.bookingId);

    // Attach a listener to the booking node to update the UI when data changes
    _bookingRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          // Retrieve the data from the snapshot and update the UI
          // _qrData = event.snapshot.value['qrData'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Booking History'),
      //   // backgroundColor: Colors.green,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking Details:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              _qrData,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              child: Text('Back'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
