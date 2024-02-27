import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/model/Home_model.dart';
import 'package:newsapp/screen/webview.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<newsCenter>(context, listen: false).setNews();
      Provider.of<newsCenter>(context, listen: false).BusinessNews();
    });
  }

  final CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    print("Build");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "News",
                style: TextStyle(fontSize: 25),
              ),
              Text(
                "Center",
                style: TextStyle(color: Colors.teal, fontSize: 30),
              )
            ],
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: FutureBuilder(
          future: checkInternetConnection(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // The Future is still running, show a loading indicator
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasError) {
                // There was an error, handle it accordingly
                return Text('Error: ${snapshot.error}');
              } else {
                // Check the internet connection status
                bool isConnected = snapshot.data ?? false;

                if (isConnected) {
                  // Internet connection is available, do something
                  return SingleChildScrollView(
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(
                          top: MediaQuery.sizeOf(context).height * 0.01),
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.sizeOf(context).width * .03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Leading Menu icon
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.more_vert,
                                      size: 40,
                                    )),
                                // Spacer(),
                                //Search Bar
                                Consumer(
                                  builder: (BuildContext context, value,
                                      Widget? child) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.grey[200],
                                      ),
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.055,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.75,
                                      child: Center(
                                        child: TextField(
                                          // onChanged: (valuee) {
                                          //   value.getAllpets(valuee.toLowerCase().toString());
                                          // },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            prefixIcon:
                                                const Icon(Icons.search),
                                            hintText: "Search News ",
                                            hintStyle:
                                                const TextStyle(fontSize: 13),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.009),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          // Carousel Image
                          Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.sizeOf(context).height * 0.02),
                            child: Consumer<newsCenter>(
                              builder: (BuildContext context, newsCenter value,
                                  Widget? child) {
                                return value.isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : InkWell(
                                        onTap: () {},
                                        child: Stack(
                                          children: [
                                            CarouselSlider(
                                              items: value.breckingNews
                                                  .map(
                                                    (e) => e['urlToImage'] !=
                                                            null
                                                        ? Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.5),
                                                                    blurRadius:
                                                                        5.0,
                                                                    spreadRadius:
                                                                        1.0,
                                                                    blurStyle:
                                                                        BlurStyle
                                                                            .outer),
                                                              ],
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                              child: Stack(
                                                                children: [
                                                                  Image.network(
                                                                    e['urlToImage'],
                                                                    errorBuilder:
                                                                        (context,
                                                                            error,
                                                                            stackTrace) {
                                                                      return Container(
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                      );
                                                                    },
                                                                    fit: BoxFit
                                                                        .fitWidth,
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.9,
                                                                  ),
                                                                  Positioned(
                                                                    bottom:
                                                                        10.0,
                                                                    left: 5,
                                                                    // Adjust this value to center the text
                                                                    right: 5,
                                                                    child: Text(
                                                                      e["title"] ??
                                                                          "",
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            13.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            // You can replace Container() with a placeholder image or widget if needed
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.3),
                                                            ),
                                                          ),
                                                  )
                                                  .toList(),
                                              options: CarouselOptions(
                                                scrollPhysics:
                                                    const BouncingScrollPhysics(),
                                                autoPlay: true,
                                                aspectRatio: 2,
                                                viewportFraction: 2,
                                                autoPlayCurve:
                                                    Curves.easeOutBack,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                              },
                            ),
                          ),

                          Consumer<newsCenter>(
                            builder: (BuildContext context, newsCenter value,
                                Widget? child) {
                              return Container(
                                // color: Colors.grey,
                                height: 50,
                                width: double.infinity,
                                child: ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            value.BusinessNews();
                                          },
                                          child: const Text(
                                            "Business",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            value.EntertainmentNews();
                                          },
                                          child: const Text(
                                            "Entertainment",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            value.GeneralNews();
                                          },
                                          child: const Text(
                                            "General",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            value.HealthNews();
                                          },
                                          child: const Text(
                                            "Health",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            value.SportNews();
                                          },
                                          child: const Text(
                                            "Sport",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            value.ScienceNews();
                                          },
                                          child: const Text(
                                            "Science",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            value.TechnologyNews();
                                          },
                                          child: const Text(
                                            "Technology",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                    ]),
                              );
                            },
                          ),

                          // News
                          Consumer<newsCenter>(
                            builder: (context, value, child) {
                              return value.isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : value.isLoadingdata
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: value.allNews.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 16.0),
                                              child: Card(
                                                elevation: 0.5,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: ListTile(
                                                  leading: value.allNews[index]
                                                              ["urlToImage"] !=
                                                          null
                                                      ? Container(
                                                          child: Image.network(
                                                            "${value.allNews[index]["urlToImage"]}",
                                                            errorBuilder: (context,
                                                                    exception,
                                                                    stackTrack) =>
                                                                const Icon(
                                                              Icons.error,
                                                            ),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        )
                                                      : Container(
                                                          height: 50,
                                                          width: 50,
                                                        ),
                                                  contentPadding:
                                                      const EdgeInsets.all(
                                                          16.0),
                                                  title: Text(
                                                    "${value.allNews[index]["title"]}",
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10.0,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    "${value.allNews[index]["author"]}",
                                                    textAlign: TextAlign.right,
                                                    style: const TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 10),
                                                  ),
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              webview(
                                                                  url:
                                                                      "${value.allNews[index]["url"]}"),
                                                        ));
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  // No internet connection, display a message or take appropriate action
                  return const Text('No internet connection');
                }
              }
            }
          },
        ));
  }
}

Future<bool> checkInternetConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.none) {
    return false; // No internet connection
  } else {
    return true; // Internet connection is available
  }
}
