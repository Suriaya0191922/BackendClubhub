import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../models/student.dart';

class HomeScreen extends StatelessWidget {
  final Student? student;

  const HomeScreen({this.student, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with curved bottom
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppColors.primary,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 40, 24, 16), // reduced top & bottom padding
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // key fix to prevent overflow
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back,',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          student?.name ?? 'Guest',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Quick Stats
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatCard('5', 'Clubs', Icons.groups),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatCard('12', 'Events', Icons.event),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatCard('8', 'Messages', Icons.chat_bubble_outline),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            title: Row(
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.groups,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'ClubHub',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 20),
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.account_circle, color: Colors.white, size: 20),
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // My Clubs Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Clubs',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'See All',
                          style: TextStyle(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildClubCard(
                    'Coding Club',
                    'Next meeting: Monday 3PM',
                    Icons.code,
                    AppColors.accent,
                  ),
                  const SizedBox(height: 12),
                  _buildClubCard(
                    'Chess Club',
                    'Tournament this Friday',
                    Icons.sports_esports,
                    const Color(0xFF9B59B6),
                  ),
                  const SizedBox(height: 12),
                  _buildClubCard(
                    'Photography Club',
                    'Photo walk on Saturday',
                    Icons.camera_alt,
                    const Color(0xFF3498DB),
                  ),
                  const SizedBox(height: 32),

                  // Upcoming Events
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Upcoming Events',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'See All',
                          style: TextStyle(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildEventCard(
                    'Hackathon 2024',
                    'Nov 15-17',
                    'Computer Lab',
                    Icons.laptop_mac,
                    AppColors.accent,
                  ),
                  const SizedBox(height: 12),
                  _buildEventCard(
                    'Annual Sports Day',
                    'Nov 20',
                    'Sports Ground',
                    Icons.sports_soccer,
                    AppColors.secondaryBackground,
                  ),
                  const SizedBox(height: 12),
                  _buildEventCard(
                    'Tech Talk Series',
                    'Nov 25',
                    'Auditorium',
                    Icons.mic,
                    AppColors.primary,
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home, 'Home', true),
                _buildNavItem(Icons.explore_outlined, 'Explore', false),
                _buildNavItem(Icons.event_outlined, 'Events', false),
                _buildNavItem(Icons.person_outline, 'Profile', false),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppColors.accent.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.accent : AppColors.textSecondary,
            size: 26,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive ? AppColors.accent : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.accent, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClubCard(String title, String subtitle, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.arrow_forward_ios, color: color, size: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(String title, String date, String location, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.white, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.location_on, color: Colors.white, size: 14),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        location,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.bookmark_border, color: Colors.white, size: 22),
          ),
        ],
      ),
    );
  }
}
