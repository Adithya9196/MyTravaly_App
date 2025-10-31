import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mytravaly_app/Search_Page/Model_Page/Search_Model.dart';
import 'package:mytravaly_app/Search_Page/Services/hotel_service.dart';

class SearchResultPage extends StatefulWidget {
  final String visitorToken;

  const SearchResultPage({
    super.key,
    required this.visitorToken,
  });

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  final SearchRepository _searchRepository = SearchRepository();
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';
  List<ArrayOfHotelList> _hotels = [];

  @override
  void initState() {
    super.initState();
    _fetchHotels();
  }

  Future<void> _fetchHotels() async {
    try {
      final searchModel =
          await _searchRepository.searchHotels(widget.visitorToken);

      setState(() {
        _hotels = searchModel.data?.arrayOfHotelList ?? [];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Hotel Search Results',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.deepOrangeAccent))
          : _hasError
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Error: $_errorMessage',
                      style: const TextStyle(
                          color: Colors.redAccent, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : _hotels.isEmpty
                  ? const Center(child: Text('No hotels found'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: _hotels.length,
                      itemBuilder: (context, index) {
                        final hotel = _hotels[index];
                        return Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Hotel Image
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16)),
                                child: Image.network(
                                  hotel.propertyImage.fullUrl,
                                  height: 160,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    height: 140,
                                    color: Colors.grey[300],
                                    alignment: Alignment.center,
                                    child: const Icon(Icons.broken_image,
                                        size: 60, color: Colors.grey),
                                  ),
                                ),
                              ),

                              // Hotel Details
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      hotel.propertyName,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      '${hotel.propertyAddress.city}, ${hotel.propertyAddress.state}',
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                    const SizedBox(height: 6),

                                    // Rating Bar
                                    RatingBarIndicator(
                                      rating: hotel.propertyStar.toDouble(),
                                      itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber),
                                      itemSize: 18,
                                    ),
                                    //const SizedBox(height: 4),

                                    // Price Row
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'From: ${hotel.propertyMinPrice.displayAmount}',
                                          style: const TextStyle(
                                            color: Colors.deepOrangeAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          style: TextButton.styleFrom(
                                            backgroundColor:
                                                Colors.deepOrangeAccent,
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 5),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text('View'),
                                        ),
                                      ],
                                    ),
                                  ],
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
