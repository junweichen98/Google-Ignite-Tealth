import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import '../services/geolocator_service.dart';
import '../services/marker_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/place.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    final placesProvider = Provider.of<Future<List<Place>>>(context);
    final geoService = GeoLocatorService();
    final markerService = MarkerService();

    return FutureProvider(
      create: (context) => placesProvider,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading:
          Image.asset('assets/tealth_logo_250.png', width: 40, height: 40),
          leadingWidth: 100,
          title: const Text(
            "Dental Clinics Near Me",
            style: TextStyle(
              fontFamily: 'Average Sans',
              color: Color(0xff34346E),
              fontSize: 18,
            ),
          ),
          elevation: 0,
          backgroundColor: const Color(0xffCCEFFC),
          toolbarHeight: 130,
        ),
        body: (currentPosition != null)
            ? Consumer<List<Place>>(
                builder: (_, places, __) {
                  var markers = (places != null)
                      ? markerService.getMarkers(places)
                      : <Marker>[];
                  return (places != null)
                      ? Column(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width,
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                    target: LatLng(currentPosition.latitude,
                                        currentPosition.longitude),
                                    zoom: 13.0),
                                zoomGesturesEnabled: true,
                                markers: Set<Marker>.of(markers),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Expanded(
                              child: (places.length > 0)
                                  ? ListView.builder(
                                      itemCount: places.length,
                                      itemBuilder: (context, index) {
                                        return FutureProvider(
                                          create: (context) =>
                                              geoService.getDistance(
                                                  currentPosition.latitude,
                                                  currentPosition.longitude,
                                                  places[index]
                                                      .geometry
                                                      .location
                                                      .lat,
                                                  places[index]
                                                      .geometry
                                                      .location
                                                      .lng),
                                          initialData: "fetching",
                                          child: Card(
                                            child: ListTile(
                                              title: Text(places[index].name),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  (places[index].rating != null)
                                                      ? Row(
                                                          children: <Widget>[
                                                            RatingBarIndicator(
                                                              rating:
                                                                  places[index]
                                                                      .rating,
                                                              itemBuilder: (context,
                                                                      index) =>
                                                                  Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .amber),
                                                              itemCount: 5,
                                                              itemSize: 10.0,
                                                              direction: Axis
                                                                  .horizontal,
                                                            )
                                                          ],
                                                        )
                                                      : Row(),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Text('${places[index].vicinity}'),
                                                ],
                                              ),
                                              trailing: IconButton(
                                                icon: Icon(Icons.directions),
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                onPressed: () {
                                                  _launchMapsUrl(
                                                      places[index]
                                                          .geometry
                                                          .location
                                                          .lat,
                                                      places[index]
                                                          .geometry
                                                          .location
                                                          .lng);
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                  : Center(
                                      child: Text('No Parking Found Nearby'),
                                    ),
                            )
                          ],
                        )
                      : Center(child: CircularProgressIndicator());
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  void _launchMapsUrl(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
