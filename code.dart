import 'dart:convert';

import 'package:html/dom.dart' as html;

class Spankbang {
  dynamic getProperty(dynamic element, String propertyName) {
    if (element is html.Element) {
      switch (propertyName) {
        case 'image':
          return element
                  .querySelector('.thumb > picture > img')
                  ?.attributes['data-src'] ??
              '';
        case 'id':
          return element.querySelector('.thumb')?.attributes['href'] ?? '';
        case 'title':
          return element.querySelector('.thumb')?.attributes['title'] ?? '';
        case 'duration':
          return element.querySelector('.thumb >  .l')?.text ?? '';
        case 'preview':
          return element
                  .querySelector('.thumb > picture > img')
                  ?.attributes['data-preview'] ??
              '';
        case 'quality':
          return element.querySelector('.thumb >  .h')?.text ?? '';
        case 'time':
          return element.querySelector('.thumb >  .l')?.text ?? '';
        default:
          return '';
      }
    } else {
      switch (propertyName) {
        case 'selector':
          return element.querySelectorAll('.video-list > .video-item');
        default:
          return '';
      }
    }
  }

  dynamic getVideos(dynamic element, String propertyName) {
    if (element is html.Element) {
      var scripts =
          element.querySelectorAll('script[type="application/ld+json"]');
      var scriptContainingEmbedUrl = scripts.firstWhere(
        (element) => element.text.contains('embedUrl'),
      );

      // Extracting JSON string from the script text
      var jsonString1 = scriptContainingEmbedUrl.text;

      // Parsing JSON string into a Dart object
      var jsonData = json.decode(jsonString1);

      // Now you can use jsonData as a Map or any other desired data structure

      Map watchingLink = {};
      Map params = {'auto': jsonData['embedUrl']};
      watchingLink.addEntries(params.entries);
      // var watchingLink =
      //     element.querySelector('script[type="text/javascript"]')!.innerHtml;
      // final match =
      //     RegExp(r'var stream_data = ({.*?});').firstMatch(watchingLink);
      // final match2 =
      //     RegExp(r"var live_keywords = '(.*?)';").firstMatch(watchingLink);

      // final jsonString = match![1]!.replaceAll("'", '"');
      // final streamDataJson = json.decode(jsonString);

      // final streamUrls = Map<String, dynamic>.from(streamDataJson);

      // final keywords = match2!.group(1) ?? '';
      switch (propertyName) {
        case 'watchingLink':
          return watchingLink;
        // streamUrls;
        case 'keywords':
          return jsonData['keywords'];
        default:
          return '';
      }
    } else {
      switch (propertyName) {
        case 'selector':
          return element.querySelectorAll('#container');
        case 'keywords':
          return element
              .querySelector('meta[name="keywords"]')
              ?.attributes['content'];
        default:
          return '';
      }
    }
  }

  // dynamic getCategories(dynamic element, String propertyName) {
  //   if (element is html.Element) {
  //     switch (propertyName) {
  //       case 'image':
  //         return '';
  //       case 'id':
  //         return element.querySelector('a')?.attributes['href'] ?? '';
  //       case 'title':
  //         return element.querySelector('a')?.text ?? '';

  //       default:
  //         return '';
  //     }
  //   } else {
  //     switch (propertyName) {
  //       case 'selector':
  //         var mainTags = element.querySelector('#main_tags');
  //         if (mainTags != null) {
  //           var lists = mainTags.querySelectorAll('.list');
  //           if (lists.isNotEmpty) {
  //             var lastList = lists.last;
  //             var listItems = lastList.querySelectorAll('li');
  //             return listItems;
  //           }
  //         }
  //         return null;
  //       default:
  //         return '';
  //     }
  //   }
  // }
}
