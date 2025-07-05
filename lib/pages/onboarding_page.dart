import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final green = const Color(0xFF007A4C);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // FULL BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_hagia.png',
              fit: BoxFit.cover,
            ),
          ),

          // MAIN CONTENT
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // LOGO BULAT DI ATAS
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        'assets/images/logo2.png',
                        width: 120,
                        height: 120,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // HAGIA COFFE! TITLE
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'HAGIA ',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.green.shade900,
                              letterSpacing: 4,
                            ),
                          ),
                          TextSpan(
                            text: 'COFFE!',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // GAMBAR KOPI DENGAN DAUN (TENGAH & PROPOSIONAL)
                    Image.asset(
                      'assets/images/coffee.png',
                      width: width * 0.7,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 32),

                    // HEADINGS
                    Text(
                      'Find your favorite',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Coffee Taste!',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // SUBTEXT
                    Text(
                      "We're coffee shop, beer and wine bar,\n& event space for performing arts",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // GET STARTED BUTTON
                    SizedBox(
                      width: 220,
                      height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: green,
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/signin');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Get Started',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // INDICATOR
                    Container(
                      width: 120,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
