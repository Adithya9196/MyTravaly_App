import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mytravaly_app/Home_Page/Home_Page.dart';
import 'package:http/http.dart' as http;

class GoogleSignInPage extends StatefulWidget {
  const GoogleSignInPage({super.key});

  @override
  State<GoogleSignInPage> createState() => _GoogleSignInPageState();
}

class _GoogleSignInPageState extends State<GoogleSignInPage>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  bool showDemoPopup = false;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  void _openDemoPopup() {
    setState(() => showDemoPopup = true);
    _controller.forward();
  }

  void _closeDemoPopup() {
    _controller.reverse().then((_) {
      if (mounted) setState(() => showDemoPopup = false);
    });
  }

  Future<void> _selectAccount(String name) async {
    _closeDemoPopup();
    setState(() => isLoading = true);

    try {
      // API endpoint
      const url = "https://api.mytravaly.com/public/v1/";

      // Header
      const headers = {
        "Content-Type": "application/json",
        "authtoken": "71523fdd8d26f585315b4233e39d9263",
      };

      // Body (same as Postman)
      final body = jsonEncode({
        "action": "deviceRegister",
        "deviceRegister": {
          "deviceModel": "RMX3521",
          "deviceBrand": "realme",
          "deviceId": "RE54E2L1",
          "deviceName": "RMX3521_11_C_10",
          "deviceManufacturer": "realme",
          "deviceProduct": "RMX3521",
          "deviceFingerprint":
              "realme/RMX3521/RE54E2L1:13/RKQ1.211119.001/S.f1bb32-7f7fa_1:user/release-keys",
          "deviceSerialNumber": "unknown"
        }
      });

      // Send request
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['data']?['visitorToken'] ?? 'No token';

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(visitorToken: token),
            ),
          );
        }
      } else {
        //_showError('Failed to register device (${response.statusCode})');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFF3E0),
                  Color(0xFFFFE0B2),
                  Color(0xFFFFCC80),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Decorative blurred circles
          Positioned(
            top: size.height * 0.1,
            left: -50,
            child: _buildBlurCircle(150, Colors.white.withOpacity(0.3)),
          ),
          Positioned(
            bottom: size.height * 0.15,
            right: -40,
            child: _buildBlurCircle(130, Colors.white.withOpacity(0.25)),
          ),

          // Glassmorphic card
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.45),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/img.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Welcome to MyTravaly",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Sign in with Google to explore your next stay",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: isLoading ? null : _openDemoPopup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 18),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset('assets/GoogleLogo.png', height: 26),
                            const SizedBox(width: 12),
                            const Text(
                              "Continue with Google",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Slide-up demo popup
          if (showDemoPopup)
            SlideTransition(
              position: _slideAnimation,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(22)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 20,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Choose an account",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "to continue to MyTravaly",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _accountTile("Adithya P A", "adithya@example.com"),
                        _accountTile("NewWorld", "newworld@gmail.com"),
                        _accountTile("Butterfly", "butterfly@gmail.com"),
                        const Divider(height: 25),
                        ListTile(
                          leading: const Icon(Icons.add_circle_outline,
                              color: Colors.black54),
                          title: const Text(
                            "Use another account",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          onTap: () => _selectAccount("NewUser"),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: _closeDemoPopup,
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.deepOrangeAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Loading overlay
          if (isLoading)
            Container(
              color: Colors.black26,
              child: const Center(
                child:
                    CircularProgressIndicator(color: Colors.deepOrangeAccent),
              ),
            ),
        ],
      ),
    );
  }

  Widget _accountTile(String name, String email) {
    return InkWell(
      onTap: () => _selectAccount(name),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.deepOrangeAccent.shade100,
              child: const Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlurCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 60,
            spreadRadius: 20,
          ),
        ],
      ),
    );
  }
}
