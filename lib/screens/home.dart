import 'package:flutter/material.dart';
import 'game.dart'; // Import the game.dart file

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Define turquoise color
  static const Color turquoise = Color(0xFF40E0D0);

  // PageController to control the scroll of the horizontally scrollable list
  final PageController _pageController = PageController();
  int _currentIndex = 0; // To track the current index of the image

  // List of images to be displayed in the horizontally scrollable list
  List<String> imageList = [
    'lib/assets/images/boss.jpg', // Replace with your image paths
    'lib/assets/images/boss.jpg',
    'lib/assets/images/boss.jpg',
    'lib/assets/images/boss.jpg',
    'lib/assets/images/boss.jpg',
    'lib/assets/images/boss.jpg',
    'lib/assets/images/boss.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    // Get the height of the device screen
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rage Arcade'),
        centerTitle: true,
        backgroundColor: turquoise,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Handle settings action
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings clicked')),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // First Row: Music Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Select Character'),
                  Icon(Icons.music_note, size: 40, color: turquoise),
                ],
              ),
              const SizedBox(height: 20),

              // Second Row: Horizontally Scrollable List of Images
              SizedBox(
                height: screenHeight * 0.5,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: imageList.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          imageList[index],
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Third Row: Locked/Unlocked Icon & Select Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Locked/Unlocked Icon
                  Row(
                    children: [
                      Icon(
                        _currentIndex == 0 ? Icons.lock_open : Icons.lock,
                        color: _currentIndex == 0 ? Colors.green : Colors.red,
                        size: 30,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _currentIndex == 0 ? 'Unlocked' : 'Locked',
                        style: TextStyle(
                          color: _currentIndex == 0 ? Colors.green : Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),

                  // Select Button
                  ElevatedButton(
                    onPressed: _currentIndex == 0
                        ? () {
                            // Navigate to MyGame screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyGame(),
                              ),
                            );
                          }
                        : null, // Disable if not the first image
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentIndex == 0
                          ? turquoise
                          : Colors.grey, // Gray when not the first image
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    child: const Text('Select', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Bottom Row: Previous and Next Buttons to swipe images
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Previous Button
                  ElevatedButton(
                    onPressed: _currentIndex > 0
                        ? () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: turquoise,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    child:
                        const Text('Previous', style: TextStyle(fontSize: 16)),
                  ),

                  // Next Button
                  ElevatedButton(
                    onPressed: _currentIndex < imageList.length - 1
                        ? () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: turquoise,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    child: const Text('Next', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
