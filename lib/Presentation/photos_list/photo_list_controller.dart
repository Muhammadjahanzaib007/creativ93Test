
import 'package:creativ93_test/App/repositories.dart';
import 'package:creativ93_test/Models/unsplash_image_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PhotosController extends GetxController {
  final PhotosRepository _repository = PhotosRepository();
  List<UnsplashImage> images = [];
  int pageNumber = 1;
  ScrollController imageScroll = ScrollController();
  RxBool itemsLoading = false.obs;
  @override
  Future<void> onInit() async {
    await getImages();
    imageScroll.addListener(offersProductListListener);
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    imageScroll.dispose();
  }
  offersProductListListener() {
    var nextPageTrigger = 0.8 * imageScroll.position.maxScrollExtent;

// _scrollController fetches the next paginated data when the current postion of the user on the screen has surpassed
    if (imageScroll.position.pixels > nextPageTrigger&&!itemsLoading.value) {
      itemsLoading.value = true;
      pageNumber++;
      getImages();
    }
  }
  Future<void> getImages() async {
    try {
      List<UnsplashImage> response = await _repository.getPhotos(pageNumber,perPage: 20);
      for (var element in response) {images.add(element);}
      itemsLoading.value = false;
      update();
    } catch (e) {
      itemsLoading.value = false;
      Get.log('error in getting images : $e');
    }
  }
}