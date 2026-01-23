import 'package:flutter/material.dart';

class DemoVideosScreen extends StatelessWidget {
  const DemoVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔝 HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 50, bottom: 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff5B86E5), Color(0xff36D1DC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // 🔙 BACK
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(12),
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Demo Videos',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🎬 VIDEO LIST
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: const [
                  _DemoVideoCard(
                    title: 'How to Create a Lead',
                    duration: '02:15',
                  ),
                  _DemoVideoCard(
                    title: 'How to Track Your Earnings',
                    duration: '03:10',
                  ),
                  _DemoVideoCard(
                    title: 'How to Redeem Points',
                    duration: '01:45',
                  ),
                  _DemoVideoCard(
                    title: 'Understanding Lead Status',
                    duration: '02:40',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// 🎥 DEMO VIDEO CARD
class _DemoVideoCard extends StatelessWidget {
  final String title;
  final String duration;

  const _DemoVideoCard({required this.title, required this.duration});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Open video player / YouTube
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🎞 THUMBNAIL
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                    child: const Icon(
                      Icons.video_library,
                      size: 60,
                      color: Colors.white70,
                    ),
                  ),
                ),

                // ▶ PLAY BUTTON
                const Positioned.fill(
                  child: Center(
                    child: CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.black54,
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),

                // ⏱ DURATION
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      duration,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),

            // 🧾 TITLE
            Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
