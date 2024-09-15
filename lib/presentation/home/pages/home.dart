import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gronk/common/helpers/is_dark.dart';
import 'package:gronk/common/widgets/appbar/app_bar.dart';
import 'package:gronk/core/configs/assets/app_vectors.dart';
import 'package:gronk/core/configs/theme/app_colors.dart';
import 'package:gronk/core/configs/theme/app_images.dart';
import 'package:gronk/presentation/home/widgets/news_songs.dart';
import 'package:gronk/presentation/home/widgets/playlist.dart';
import 'package:gronk/presentation/profile/pages/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 4, vsync: this);

  // void initstate(){
  //   super.initState();
  //   _tabController = TabController(length: 4, vsync: this);
  // }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideBack: true,
        title: Padding(
            // alignment: Alignment.topCenter,
          padding: const EdgeInsets.all(0),
          child: Image.asset(
            context.isDarkMode ? AppVectors.lightlogo : AppVectors.darklogo,
            height: 42,
            width: 193,
          )
        ),
        action: IconButton(
          onPressed: (){
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (BuildContext context) => Profile())
              );
          }, 
          icon: const Icon(
            Icons.person
          )
          ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeTopCard(),
            _tabsView(),
            SizedBox(
              height: 260,
              child: TabBarView(
                controller: _tabController,
                children: [
                  const NewsSongs(),
                  Container(),
                  Container(),
                  Container(),
                ],
                ),
            ),
            const SizedBox(height: 40,),
            const Playlist()
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard(){
    return Center(
      child: SizedBox(
        height: 140,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                AppVectors.homeTopCard
              ),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 60,
                ),
                child: Image.asset(
                  AppImages.homrArtist
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _tabsView(){
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      indicatorColor: AppColors.primary,
      padding: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 16
      ),
      tabs: const [
        Text(
          'New',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16
          ),
        ),
        Text(
          'Genre',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16
          ),
        ),
        Text(
          'Artists',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16
          ),
        ),
        Text(
          'Podcasts',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16
          ),
        ),
      ],
    );
  }
}