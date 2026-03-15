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
                  ),
                  CarCard(
                    name: "Hyundai Creta",
                    price: "₹3,000 / day",
                    image: "images/car2.png",
                  ),
                  CarCard(
                    name: "Swift Dzire",
                    price: "₹2,000 / day",
                    image: "images/car3.png",
                  ),
                  CarCard(
                    name: "Tata Safari",
                    price: "₹2,300 / day",
                    image: "images/car4.png",
                  ),
                  CarCard(
                    name: "Mahindra XUV300",
                    price: "₹3,100 / day",
                    image: "images/car5.png",
                  ),
                  CarCard(
                    name: "Toyota Fortuner",
                    price: "₹2,900 / day",
                    image: "images/car6.png",
                  ),
                  CarCard(
                    name: "Skoda Slavia",
                    price: "₹2,700 / day",
                    image: "images/car7.png",
                  ),
                  CarCard(
                    name: "volvo s60",
                    price: "₹3,800 / day",
                    image: "images/car8.png",
                  ),
                  CarCard(
                    name: "Honda City",
                    price: "₹3,200 / day",
                    image: "images/car9.png",
                  ),
                  CarCard(
                    name: "Audi Q8",
                    price: "₹2,400 / day",
                    image: "images/car10.png",
                  ),
                  CarCard(
                    name: "Renault Kwid",
                    price: "₹2,800 / day",
                    image: "images/car11.png",
                  ),
                  CarCard(
                    name: "Ford Raptor",
                    price: "₹4,500 / day",
                    image: "images/car12.png",
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

  const CarCard({
    super.key,
    required this.name,
    required this.price,
    required this.image,
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
              onPressed: () {
                // booking page later
              },
              child: const Text("Book"),
            ),
          ],
        ),
      ),
    );
  }
}
