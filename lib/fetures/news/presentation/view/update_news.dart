import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/snackbar/snackbar.dart';
import '../../domain/entity/news_entity.dart';
import '../view_model/news_get_my_news_view_news.dart';

class UpdateView extends ConsumerStatefulWidget {
  const UpdateView({super.key, required this.news});
  final NewsEntity news;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadViewState();
}

class _UploadViewState extends ConsumerState<UpdateView> {
  late String img;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  late TextEditingController _locationController;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.news.title);
    _descriptionController =
        TextEditingController(text: widget.news.description);
    _locationController = TextEditingController(text: widget.news.location);

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();

    super.dispose();
  }

  final _key = GlobalKey<FormState>();
  final gap = const SizedBox(
    height: 20,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  gap,
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: "Title",
                      hintText: "Write the title of the News",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  gap,
                  TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      labelText: "Location",
                      hintText: "Enter the location of the News",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  gap,
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: "Description",
                      hintText: "Write description of the News",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  gap,
                  ElevatedButton(
                      onPressed: () {
                        // if (_key.currentState!.validate()) {
                        NewsEntity news = NewsEntity(
                          title: _titleController.text,
                          location: _locationController.text,
                          description: _descriptionController.text,
                          image: ref
                              .watch(newsGetMyNewsViewModelProvider)
                              .imageName,
                          user: '',
                        );
                        ref
                            .read(newsGetMyNewsViewModelProvider.notifier)
                            .updateNews(news, widget.news.newsId!);
                        ref
                            .watch(newsGetMyNewsViewModelProvider.notifier)
                            .getMyNews()
                            .then((value) {
                          Navigator.pop(context);
                          showSnackBar(
                            context: context,
                            message: "News updated successfully",
                            color: Colors.green,
                          );
                        });
                        // }
                      },
                      child: const Text('Update newss'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
