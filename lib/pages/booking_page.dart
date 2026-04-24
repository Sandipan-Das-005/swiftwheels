import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingPage extends StatefulWidget {
  final String carName;
  final double pricePerDay;
  final String carId;

  const BookingPage({
    super.key,
    required this.carName,
    required this.pricePerDay,
    required this.carId,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? startDate;
  DateTime? endDate;

  bool isLoading = false;

  /// 🔍 Find active booking (REAL-TIME SOURCE OF TRUTH)
 Future<QueryDocumentSnapshot?> getActiveBooking() async {
  final snapshot = await FirebaseFirestore.instance
      .collection('bookings')
      .where('carId', isEqualTo: widget.carId)
      .where('status', isEqualTo: 'active')
      .limit(1)
      .get();

  if (snapshot.docs.isEmpty) return null;
  return snapshot.docs.first;
}

  double getTotalPrice() {
    if (startDate == null || endDate == null) return 0;

    int days = endDate!.difference(startDate!).inDays;
    if (days <= 0) return 0;

    return days * widget.pricePerDay;
  }

  Future<void> pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  /// ✅ BOOK CAR
  Future<void> handleBooking() async {
  if (startDate == null || endDate == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Select dates")),
    );
    return;
  }

  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  /// 🔥 CHECK IF CAR ALREADY BOOKED
  final existingBooking = await FirebaseFirestore.instance
      .collection('bookings')
      .where('carId', isEqualTo: widget.carId)
      .where('status', isEqualTo: 'active')
      .limit(1)
      .get();

  if (existingBooking.docs.isNotEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Car already booked")),
    );
    return;
  }

  /// ✅ PROCEED BOOKING
  await FirebaseFirestore.instance.collection('bookings').add({
    "userId": user.uid,
    "carId": widget.carId,
    "carName": widget.carName,
    "startDate": startDate,
    "endDate": endDate,
    "totalPrice": getTotalPrice(),
    "status": "active",
    "createdAt": Timestamp.now(),
  });

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Booking Confirmed")),
  );
}

  /// ❌ CANCEL BOOKING (from THIS page too)
  Future<void> cancelBooking() async {
    setState(() => isLoading = true);

    try {
      final doc = await getActiveBooking();

      if (doc != null) {
        await FirebaseFirestore.instance
            .collection('bookings')
            .doc(doc.id)
            .update({"status": "cancelled"});
      }

      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Booking Cancelled")),
      );
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.carName)),

      body: FutureBuilder<QueryDocumentSnapshot?>(
        future: getActiveBooking(),
        builder: (context, snapshot) {
          final activeBooking = snapshot.data;
          final isBooked = activeBooking != null;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ListTile(
                  title: Text(startDate == null
                      ? "Start Date"
                      : startDate.toString().split(" ")[0]),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: isBooked ? null : () => pickDate(true),
                ),

                ListTile(
                  title: Text(endDate == null
                      ? "End Date"
                      : endDate.toString().split(" ")[0]),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: isBooked ? null : () => pickDate(false),
                ),

                const SizedBox(height: 20),

                Text("Total: ₹${getTotalPrice()}"),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : isBooked
                            ? cancelBooking
                            : handleBooking,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isBooked ? Colors.red : Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            isBooked
                                ? "Cancel Booking"
                                : "Confirm Booking",
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}