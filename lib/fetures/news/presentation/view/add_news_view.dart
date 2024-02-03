import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/snackbar/snackbar.dart';
import '../../domain/entity/news_entity.dart';
import '../view_model/news_viewmodel.dart';

class AddNews extends ConsumerStatefulWidget {
  const AddNews({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddNewsState();
}

class _AddNewsState extends ConsumerState<AddNews> {
  final _titleController = TextEditingController();
  final _descrpitionController = TextEditingController();
  final _locationController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descrpitionController.dispose();
    _priceController.dispose();

    _locationController.dispose();

    super.dispose();
  }

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final newsState = ref.watch(newsViewModelProvider);
    double width = MediaQuery.of(context).size.width;
    const gap = SizedBox(
      height: 10,
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            margin: const EdgeInsets.only(left: 40, right: 40),
            child: Column(
              children: [
                gap,
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: "Title ",
                          hintText: "Enter the Title or the News ",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please wirte the title of the News ';
                          }
                          return null;
                        },
                      ),
                      gap,
                      TextFormField(
                        controller: _locationController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please insert the location of the news';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Location",
                          hintText: "Enter the location ",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Container(
                        width: width * 0.55,
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              NewsEntity news = NewsEntity(
                                title: _titleController.text,
                                location: _locationController.text,
                                description: _descrpitionController.text,
                                user: '',
                              );
                              ref
                                  .read(newsViewModelProvider.notifier)
                                  .addNews(news, context);
                            }
                            if (newsState.error != null) {
                              showSnackBar(
                                context: context,
                                message: newsState.error.toString(),
                              );
                            } else {
                              showSnackBar(
                                context: context,
                                message: 'Added News Descpriotions',
                                color: Colors.green,
                              );
                            }
                          },
                          child: const Text('Upload Image'),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
