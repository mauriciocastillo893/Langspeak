import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class GeolocatorHelper {
  static Future<Map<String, String>> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar si los servicios de ubicación están habilitados.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Los servicios de ubicación no están habilitados, no continúe
      // solicitando la ubicación y regrese.
      return {
        'latitude': '0.0',
        'longitude': '0.0',
        'country': 'Earth',
      };
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Los permisos están denegados, el uso del manejo de ubicación no es posible.
        return {
          'latitude': '0.0',
          'longitude': '0.0',
          'country': 'Earth',
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Los permisos se niegan para siempre, el manejo de ubicación no es posible.
      return {
        'latitude': '0.0',
        'longitude': '0.0',
        'country': 'Earth',
      };
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Obtener el país usando geocodificación inversa
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    String country = placemarks[0].country ?? 'País no disponible';

    return {
      'latitude': position.latitude.toString(),
      'longitude': position.longitude.toString(),
      'country': country,
    };
  }
}
