import 'package:get/get.dart';
import '../Models/unsplash_image_model.dart';
import 'Network/api_endpoints.dart';
import 'Network/api_service.dart';

class PhotosRepository {
  late APIProvider apiClient;

  PhotosRepository() {
    apiClient = APIProvider();
  }

  Future<List<UnsplashImage>> getPhotos(int page, {int perPage = 10}) async {
    try{
    var data = await apiClient.baseGetAPI(
        "${APIEndpoint.getPhotos}?&page=$page&per_page=$perPage",
        Get.context);
    print(data);
    List<UnsplashImage> images =
        List<UnsplashImage>.generate(data.length, (index) {
      return UnsplashImage.fromJson(data[index]);
    });
    // return images
    return images;

    }catch(e){
      print("eeee$e");
      return [];
    }
  }

  Future<UnsplashImage> loadImage(String id) async {
    var data = await apiClient.baseGetAPI(
        "${APIEndpoint.getPhotos}$id",  Get.context);
    return UnsplashImage.fromJson(data);
  }

}
