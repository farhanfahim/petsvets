import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../components/resources/app_colors.dart';
import '../../../../components/resources/app_string.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/circle_image.dart';

class MapTileView extends StatefulWidget {
  final double lat;
  final double lng;
  final String address;
  final String image;

  const MapTileView({
    super.key,
    required this.image,
    required this.address,
    required this.lat,
    required this.lng,
  });

  @override
  State<MapTileView> createState() => _MapTileViewState();
}

Future<String> _loadMapDarkModeStyle() async {
  return await rootBundle.loadString(AppString.mapStyle);
}

Future<void> _setDarkModeStyle(GoogleMapController controller) async {
  String darkModeStyle = await _loadMapDarkModeStyle();
  controller.setMapStyle(darkModeStyle);
}

class _MapTileViewState extends State<MapTileView> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    _setDarkModeStyle(controller);

    await moveToCameraLocation(
      latLng: LatLng(widget.lat, widget.lng),
    );
  }

  String darkMapStyle = "";
  GoogleMapController? _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.maxFinite,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              onTap: (v) {},
              markers: Set<Marker>.of(markers.values),
              onMapCreated: _onMapCreated,
              scrollGesturesEnabled: false,
              zoomGesturesEnabled: false,
              initialCameraPosition: CameraPosition(
                target:
                    LatLng(widget.lat,widget.lng),
                zoom: 17.0,
              ),
              zoomControlsEnabled: false,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              // set this to false
              mapType: MapType.normal,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 30,
                  child: Image.asset(
                    AppImages.vetMarker,
                    width: 80,
                    height: 80,
                  ),
                ),
                Positioned(
                  top: 45,
                  child: widget.image.isNotEmpty?CircleImage(
                    imageUrl:  widget.image,
                    size: 35,
                    border: true,
                  ):CircleImage(
                    image: AppImages.user,
                    size: 35,
                    border: true,
                  ),
                ),
                Positioned(
                  bottom: 60,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.red.withOpacity(0.1),
                      border: Border.all(color: AppColors.red,width: 0.5),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppDimen.borderRadius),
                      ),
                    ),
                    padding: const EdgeInsets.all(AppDimen.contentPadding),
                    child:  MyText(
                      text: widget.address,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                      fontSize: 10,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  moveToCameraLocation({required LatLng latLng}) {
    _controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(latLng.latitude, latLng.longitude),
      zoom: 17.0,
    )));
  }
}
