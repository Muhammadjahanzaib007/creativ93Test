import 'package:creativ93_test/Models/unsplash_image_model.dart';
import 'package:creativ93_test/Presentation/photos_list/photo_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagesList extends StatelessWidget {
  const ImagesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PhotosController>(
        init: PhotosController(),
        builder: (controller) {
          return controller.images.isEmpty? Center(child: CircularProgressIndicator(),) :ListView.builder(
              controller: controller.imageScroll,
              itemCount: controller.images.length + 1,
              prototypeItem: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: FadeInImage(placeholder: const AssetImage("assets/images/imgplaceholder.png"), image: NetworkImage(controller.images.first.urls!.regular!),)
              ),
              itemBuilder: (context, index) {

                if (index == controller.images.length) {
                    return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: CircularProgressIndicator(),
                        ));
                }

                final UnsplashImage image = controller.images[index];
                return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: FadeInImage(placeholder: const AssetImage("assets/images/imgplaceholder.png"), image: NetworkImage(image.urls?.regular??""),)
                );
              }
          );

        }
      ),
    );
  }
}
