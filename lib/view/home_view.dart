import 'package:book/view/widgets/me_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF11071F),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: Color(0xFF1A0B2E),
            floating: true,
            pinned: true,
            expandedHeight: 0,
            flexibleSpace: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(child: SvgPicture.asset('assets/Logo.svg')),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: .spaceEvenly,
                      children: [
                        _buildNavItem('Home', () {}),
                        _buildNavItem('About', () {}),
                        _buildNavItem('Lab', () {}),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: MeWidget(),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        title,
        style: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w400,
          color: Colors.white,
          fontSize: 16,
        ),
        // style: TextStyle(
        //   fontSize: 20,
        //   fontWeight: FontWeight.w500,
        //   color: Colors.white,
        // ),
      ),
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          overlayColor: Color(0xFF00d4ff).withOpacity(0.1),
          textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

