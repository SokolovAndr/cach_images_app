import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  /*static final customCacheManager = CacheManager(
    Config('customCacheKey',
    stalePeriod: Duration(days: 15),
    //maxNrOfCacheObjects: 100
    )
  );*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Приложение"),
          actions: [
            TextButton(
                onPressed: clearCache,
                child: const Text(
                  'Clear Cache',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: 50,
            itemBuilder: (context, index) => Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: buildImage(index),
                    title: Text(
                      'Image ${index + 1}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                )),
      ),
    );
  }

  Widget buildImage(int index) => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          //cacheManager: customCacheManager,
          key: UniqueKey(),
          imageUrl: 'https://source.unsplash.com/random?sig=$index/100x100',
          height: 50,
          width: 50,
          fit: BoxFit.cover,
          maxHeightDiskCache: 75,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Container(
            color: Colors.black12,
            child: const Icon(Icons.error, color: Colors.red),
          ),
        ),
      );

  void clearCache() {
    DefaultCacheManager().emptyCache();

    imageCache!.clear();
    imageCache!.clearLiveImages();
    setState(() {});
  }
}
