import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:full_screen_image/full_screen_image.dart';

import '../../../../../core/common/text/disaster_style_text.dart';
import '../../../../../core/common/text/text.dart';
import '../../../../news/domain/entity/news_entity.dart';
import '../../../../news/presentation/view_model/news_get_my_news_view_news.dart';
import '../../../../news/presentation/view_model/news_viewmodel.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    ref.watch(newsGetMyNewsViewModelProvider);

    final newsState = ref.watch(newsViewModelProvider);

    final List<NewsEntity> newsList = newsState.news;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: width * 1,
                    height: height * 0.3,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(51, 0, 255, 0.45),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: const Align(
                      alignment: Alignment.topCenter,
                      child: StyleText(),
                    ),
                  ),
                  Positioned(
                    top: height * 0.1,
                    left: width * 0.11,
                    width: width * 0.8,
                    height: height * 0.24,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.topCenter,
                            child: MakingText('Find News'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              width: width * 0.7,
                              child: Form(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                51, 0, 255, 0.45),
                                            width: 2,
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                51, 0, 255, 0.45),
                                            width: 2,
                                          ),
                                        ),
                                        prefixIcon: Icon(
                                          Icons.location_on,
                                        ),
                                        hintText: 'Enter the Location or the title of news',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.5,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('Search'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              if (newsState.isLoading) ...{
                const Center(child: CircularProgressIndicator()),
              } else if (newsState.error != null) ...{
                Text(newsState.error.toString()),
              } else if (newsState.news.isEmpty) ...{
                const Center(child: Text('No news Found')),
              } else ...{
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    // separatorBuilder: (context, index) =>
                    //     const SizedBox(height: 10),
                    itemCount: newsList.length,
                    itemBuilder: (context, index) {
                      NewsEntity news = newsList[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 12,
                        shadowColor: const Color.fromARGB(255, 211, 199, 199),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  FullScreenWidget(
                                    disposeLevel: DisposeLevel.Medium,
                                    child: SizedBox(
                                      width: width * 0.25,
                                      height: width * 0.35,
                                      child: Image.network(
                                        'http://10.0.2.2:4000/uploads/${news.image}',
                                        // 'http://192.168.101.4/uploads/${news.image}',
                                        // ApiEndpoints.imageUrl,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          news.title,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.6,
                                          child: ListTile(
                                            leading:
                                                const Icon(Icons.location_on),
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            title: Transform(
                                              transform:
                                                  Matrix4.translationValues(
                                                -10,
                                                0.0,
                                                0.0,
                                              ),
                                              child: Text(
                                                news.location,
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.6,
                                          child: ListTile(
                                            leading:
                                                const Icon(Icons.description),
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            title: Transform(
                                              transform:
                                                  Matrix4.translationValues(
                                                -10,
                                                0.0,
                                                0.0,
                                              ),
                                              child: Text(
                                                news.description,
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
