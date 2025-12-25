import 'package:first_app/models/catagory_model.dart';
import 'package:first_app/models/diet_model.dart';
import 'package:first_app/models/popular_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CatagoryModel> catagoryList = [];
  List<DietModel> dietList = [];
  List popularList = [];

  void _getCatagoryList() {
    catagoryList = CatagoryModel.getCatagoryList();
  }

  void _getDietList() {
    dietList = DietModel.getDietList();
  }

  void _getPopularList() {
    popularList = PopularModel.getPopularList();
  }

  void _getInitailInfo() {
    _getCatagoryList();
    _getDietList();
    _getPopularList();
  }

  @override
  Widget build(BuildContext context) {
    _getInitailInfo();
    return Scaffold(
      appBar: appBar(),

      body: ListView(
        children: [
          _searchField(),
          _catagorySection(),
          SizedBox(height: 16),
          _deitSection(),
          SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Text(
                  'ពេញនិយម', // "Popular" in Khmer
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
                ),
              ),
              SizedBox(height: 12),
              ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                itemCount: popularList.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 115,
                    decoration: BoxDecoration(
                      color: popularList[index].boxIsSelected
                          ? Color(0xFFB2DFDB)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: popularList[index].boxIsSelected
                          ? [
                              BoxShadow(
                                color: Colors.teal.withValues(alpha: 0.2),
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                                blurRadius: 40,
                              ),
                            ]
                          : [],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          popularList[index].iconPath,
                          height: 60,
                          width: 60,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              popularList[index].name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.grey[800],
                              ),
                            ),
                            Text(
                              '${popularList[index].duration} | ${popularList[index].calorie}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            'assets/icons/box-arrow-in-up-right.svg',
                            width: 20,
                            height: 20,
                            fit: BoxFit.contain,
                            colorFilter: const ColorFilter.mode(
                              Colors.grey,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          // Expanded(
          //   child: Center(
          //     child: Text(
          //       'ស្វាគមន៍មកកាន់ទំព័រដើម!', // "Welcome to the Home Page!" in Khmer
          //       style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          //     ),
          //   ),
          // ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Column _deitSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(
            'ណែនាំ', // "Diets" in Khmer
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
          ),
        ),
        SizedBox(
          height: 240,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                width: 210,
                decoration: BoxDecoration(
                  color: dietList[index].boxColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      dietList[index].iconPath,
                      height: 80,
                      width: 80,
                    ),
                    Text(
                      dietList[index].name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey[800],
                      ),
                    ),
                    Text(
                      '${dietList[index].lavel} | ${dietList[index].duration} | ${dietList[index].calorie}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            dietList[index].viewIsSelected
                                ? Colors.teal
                                : Colors.transparent,
                            dietList[index].viewIsSelected
                                ? Colors.teal.shade700
                                : Colors.transparent,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'ជ្រើសរើស', // "Select" in Khmer
                          style: TextStyle(
                            color: dietList[index].viewIsSelected
                                ? Colors.white
                                : Colors.grey[800],
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: 12),
            itemCount: dietList.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ],
    );
  }

  Column _catagorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
          child: Text(
            'ប្រភេទ', // "Categories" in Khmer
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
          ),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 150,
          child: ListView.separated(
            itemCount: catagoryList.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              return Container(
                width: 120,
                decoration: BoxDecoration(
                  color: catagoryList[index].boxColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(catagoryList[index].iconPath!),
                      ),
                    ),
                    Text(
                      catagoryList[index].catagoryName!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.teal,
      title: Text(
        'ទំព័រដើម', // "Home Page" in Khmer
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFF00897B),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            'assets/icons/arrow-left.svg',
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            width: 20,
            height: 20,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            width: 37,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFF00897B),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              'assets/icons/three-dots.svg',
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              width: 20,
              height: 20,
            ),
          ),
        ),
      ],
      centerTitle: true,
    );
  }

  Widget _searchField() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 0,
            blurRadius: 40,
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'ស្វែងរក...',
          filled: true,
          fillColor: Colors.grey[50],
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              'assets/icons/search.svg',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              'assets/icons/sort-numeric-down.svg',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
