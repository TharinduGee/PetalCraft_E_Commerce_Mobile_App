import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  final FirebaseStorage storage = FirebaseStorage.instance;

  // Future<String> downloadURL(String imageName) async {
  //   String downloadURl =
  //       await storage.ref('Fresh Flowers/$imageName').getDownloadURL();
  //   return downloadURl;
  // }

  String? downloadURL;

  Future<void> downlaodURLExample() async {
    downloadURL = await storage.ref('Fresh Flowers/6.png').getDownloadURL();
    print(downloadURL.toString());
  }

  Future getData() async {
    try {
      await downlaodURLExample();
      return downloadURL;
    } catch (e) {
      print("Error - $e");
      return null;
    }
  }

  Future<List<String>> fetchImages() async {
    List<String> imageUrls = [];
    try {
      ListResult list = await storage.ref('Fresh Flowers/').listAll();

      for (var item in list.items) {
        var url = await item.getDownloadURL();
        imageUrls.add(url);
      }

      return imageUrls;
    } catch (e) {
      print("Error - $e");
      return imageUrls;
    }
  }
}
