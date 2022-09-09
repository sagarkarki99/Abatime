import 'package:device_apps/device_apps.dart';

class TorrentManager {
  List<String> trackers = [
    'udp://glotorrents.pw:6969/announce',
    'udp://tracker.opentrackr.org:1337/announce',
    'udp://torrent.gresille.org:80/announce',
    'udp://tracker.openbittorrent.com:80',
    'udp://tracker.coppersurfer.tk:6969',
    'udp://tracker.leechers-paradise.org:6969',
    'udp://p4p.arenabg.ch:1337',
    'udp://tracker.internetwarriors.net:1337',
  ];
  static String _availableclient = '';

  static getMagnetUrl(String? hash, String? url) {
    return 'magnet:?xt=urn:btih:$hash&dn=$url&tr=http://track.one:1234/announce&tr=udp://track.two:80';
  }

  static Future<bool> isTorrentClientAvailable() async {
    if (await DeviceApps.isAppInstalled('com.bittorrent.client')) {
      _availableclient = 'com.bittorrent.client';
      return true;
    } else if (await DeviceApps.isAppInstalled('com.utorrent.client')) {
      _availableclient = 'com.utorrent.client';
      return true;
    } else {
      return false;
    }
  }

  static String getAvailableClient() {
    return _availableclient;
  }
}
