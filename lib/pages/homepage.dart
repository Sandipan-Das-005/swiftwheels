import 'package:carrental/pages/booking_page.dart';
import 'package:flutter/material.dart';
import 'account_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SwiftWheels"),
        backgroundColor: const Color.fromARGB(255, 61, 152, 244),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountPage()),
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Welcome Text
            const Text(
              "Find your perfect ride 🚗",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            /// Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search cars",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 25),

            /// Section title
            const Text(
              "Popular Cars",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            /// Car List
            Expanded(
              child: ListView(
                children: const [
                  CarCard(
                    name: "Honda City",
                    price: "₹2,500 / day",
                    image: "images/car1.png",
                    carId: "1",
                  ),
                  CarCard(
                    name: "Hyundai Creta",
                    price: "₹3,000 / day",
                    image: "images/car2.png",
                    carId: "2",
                  ),
                  CarCard(
                    name: "Swift Dzire",
                    price: "₹2,000 / day",
                    image: "images/car3.png",
                    carId: "3",
                  ),
                  CarCard(
                    name: "Tata Safari",
                    price: "₹2,300 / day",
                    image: "images/car4.png",
                    carId: "4",
                  ),
                  CarCard(
                    name: "Mahindra XUV300",
                    price: "₹3,100 / day",
                    image: "images/car5.png",
                    carId: "5",
                  ),
                  CarCard(
                    name: "Toyota Fortuner",
                    price: "₹2,900 / day",
                    image: "images/car6.png",
                    carId: "6",
                  ),
                  CarCard(
                    name: "Skoda Slavia",
                    price: "₹2,700 / day",
                    image: "images/car7.png",
                    carId: "7",
                  ),
                  CarCard(
                    name: "Volvo S60",
                    price: "₹3,800 / day",
                    image: "images/car8.png",
                    carId: "8",
                  ),
                  CarCard(
                    name: "Honda City",
                    price: "₹3,200 / day",
                    image: "images/car9.png",
                    carId: "9",
                  ),
                  CarCard(
                    name: "Audi Q8",
                    price: "₹2,400 / day",
                    image: "images/car10.png",
                    carId: "10",
                  ),
                  CarCard(
                    name: "Renault Kwid",
                    price: "₹2,800 / day",
                    image: "images/car11.png",
                    carId: "11",
                  ),
                  CarCard(
                    name: "Ford Raptor",
                    price: "₹4,500 / day",
                    image: "images/car12.png",
                    carId: "12",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarCard extends StatelessWidget {
  final String name;
  final String price;
  final String image;
  final String carId;

  const CarCard({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.carId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Image.asset(image, width: 100, height: 60, fit: BoxFit.cover),
            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    price,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            ElevatedButton(
              onPressed: () async {
                // convert price string → double
                double numericPrice = double.parse(
                  price.replaceAll(RegExp(r'[^0-9]'), ''),
                );

                // ✅ WAIT for result from BookingPage
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingPage(
                      carName: name,
                      pricePerDay: numericPrice,
                      carId: carId,
                    ),
                  ),
                );

                if (result != null) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(result)));
                }
              },
              child: const Text("Book"),
            ),
          ],
        ),
      ),
    );
  }
}
