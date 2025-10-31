import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mytravaly_app/Search_Page/Searh_Page.dart';

class HomePage extends StatefulWidget {
  final String visitorToken;

  const HomePage({super.key, required this.visitorToken});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _sampleHotels = [
    {
      'name': 'Ocean View Resort',
      'city': 'Goa',
      'country': 'India',
      'rating': 4.5,
      'price': 4200,
      'image':
          'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=60',
    },
    {
      'name': 'Mountain Escape Lodge',
      'city': 'Munnar',
      'country': 'India',
      'rating': 4.2,
      'price': 3500,
      'image':
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=60',
    },
    {
      'name': 'Cityscape Grand Hotel',
      'city': 'Bangalore',
      'country': 'India',
      'rating': 4.7,
      'price': 5600,
      'image':
          'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=60',
    },
  ];

  void _onSearch() {
    final query = _searchController.text.trim();

    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a search term")),
      );
      return;
    }
    _searchController.clear();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultPage(
          visitorToken: widget.visitorToken,
          // searchQuery: query,
        ),
      ),
    );
  }

  /// Bottom Navigation Bar OnTap section
  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF8),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchSection(),
            const SizedBox(height: 8),
            Expanded(child: _buildHotelList()),
          ],
        ),
      ),

      /// Bottom Navigation Bar
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onBottomNavTap,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.deepOrangeAccent,
            unselectedItemColor: Colors.grey,
            elevation: 0,
            showUnselectedLabels: true,
            selectedFontSize: 13,
            unselectedFontSize: 12,
            items: [
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _selectedIndex == 0
                        ? Colors.deepOrangeAccent.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.home_filled,
                    size: _selectedIndex == 0 ? 28 : 24,
                    color: _selectedIndex == 0
                        ? Colors.deepOrangeAccent
                        : Colors.grey,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _selectedIndex == 1
                        ? Colors.deepOrangeAccent.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.bookmark,
                    size: _selectedIndex == 1 ? 28 : 24,
                    color: _selectedIndex == 1
                        ? Colors.deepOrangeAccent
                        : Colors.grey,
                  ),
                ),
                label: 'Bookings',
              ),
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _selectedIndex == 2
                        ? Colors.deepOrangeAccent.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.person,
                    size: _selectedIndex == 2 ? 28 : 24,
                    color: _selectedIndex == 2
                        ? Colors.deepOrangeAccent
                        : Colors.grey,
                  ),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Search Section
  Widget _buildSearchSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _onSearch(),
                decoration: const InputDecoration(
                  hintText: 'Search by hotel, city, or country...',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon:
                      Icon(Icons.search, color: Colors.deepOrangeAccent),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ElevatedButton(
                onPressed: _onSearch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                ),
                child: const Text(
                  'Search',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///  Hotel list
  Widget _buildHotelList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: _sampleHotels.length,
      itemBuilder: (context, index) {
        final hotel = _sampleHotels[index];
        return _buildHotelCard(hotel);
      },
    );
  }

  ///  Hotel Card
  Widget _buildHotelCard(Map<String, dynamic> hotel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(18)),
              child: Stack(
                children: [
                  Image.network(
                    hotel['image'],
                    height: 190,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        height: 190,
                        color: Colors.grey[200],
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                    errorBuilder: (_, __, ___) => Container(
                      height: 190,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, size: 60),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    bottom: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            hotel['rating'].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel['name'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.deepOrangeAccent, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        "${hotel['city']}, ${hotel['country']}",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹${hotel['price'].toStringAsFixed(0)}/night",
                        style: const TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      RatingBarIndicator(
                        rating: hotel['rating'],
                        itemBuilder: (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                        itemCount: 5,
                        itemSize: 20,
                      ),
                    ],
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
