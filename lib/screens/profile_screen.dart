import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Changed to use a prefix to avoid 'AppColors' ambiguity in main.dart
import '../utils/app_colors.dart' as colors; 
import '../models/student.dart'; 

class ProfileScreen extends StatefulWidget {
  // Constructor remains non-const
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Initialization of non-constant objects is fine here or in initState
  final FirebaseAuth _auth = FirebaseAuth.instance; 
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // State to hold student data
  Student? _student;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final doc = await _firestore.collection('students').doc(user.uid).get();
        if (doc.exists) {
          setState(() {
            _student = Student.fromMap(doc.data()!, doc.id);
            _isLoading = false;
          });
        } else {
          setState(() => _isLoading = false);
        }
      } catch (e) {
        print('Error fetching user data: $e');
        setState(() => _isLoading = false);
      }
    } else {
      setState(() => _isLoading = false);
    }
  }
  
  void _logout() async {
    try {
      await _auth.signOut();
      if (mounted) {
        // Navigate to the login screen or welcome screen
        Navigator.of(context).pushNamedAndRemoveUntil('/welcome', (Route<dynamic> route) => false);
      }
    } catch (e) {
      print('Logout Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to log out: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.AppColors.background,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: colors.AppColors.white),
        ),
        centerTitle: true,
        backgroundColor: colors.AppColors.primary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: colors.AppColors.white),
            onPressed: _logout,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _student == null
              ? Center(
                  child: Text(
                    'User data not found.',
                    style: GoogleFonts.poppins(color: colors.AppColors.textLight),
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    // Profile Header
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: colors.AppColors.accent,
                            child: Text(
                              _student!.name.isNotEmpty ? _student!.name[0].toUpperCase() : 'U',
                              style: GoogleFonts.poppins(fontSize: 36, color: colors.AppColors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _student!.name,
                            style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700, color: colors.AppColors.textDark),
                          ),
                          Text(
                            _student!.email,
                            style: GoogleFonts.poppins(fontSize: 14, color: colors.AppColors.textLight),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    
                    // Detail Cards
                    _buildDetailCard(
                      icon: Icons.school, 
                      title: 'Department & Year', 
                      subtitle: '${_student!.deptName ?? 'N/A'} - Year ${_student!.year ?? 'N/A'}',
                    ),
                    _buildDetailCard(
                      icon: Icons.star_border, 
                      title: 'Interests', 
                      subtitle: _student!.fieldOfInterest ?? 'Not specified',
                    ),
                    _buildDetailCard(
                      icon: Icons.group, 
                      title: 'Clubs Joined', 
                      subtitle: _student!.clubsJoined ?? 'None',
                    ),
                    _buildDetailCard(
                      icon: Icons.contact_mail, 
                      title: 'Contact Info', 
                      subtitle: _student!.contactInfo ?? 'N/A',
                    ),
                    const SizedBox(height: 40),
                    _buildEditButton(context),
                  ],
                ),
    );
  }

  Widget _buildDetailCard({required IconData icon, required String title, required String subtitle}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.AppColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: colors.AppColors.primary.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: colors.AppColors.accent, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(fontSize: 13, color: colors.AppColors.textLight, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(fontSize: 16, color: colors.AppColors.textDark, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // TODO: Implement navigation to edit profile screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Edit Profile feature coming soon!')),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.AppColors.accent,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
      ),
      child: Text(
        'Edit Profile',
        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: colors.AppColors.white),
      ),
    );
  }
}