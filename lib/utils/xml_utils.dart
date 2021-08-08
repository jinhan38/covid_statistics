import 'package:xml/xml.dart';

class XmlUtils {
  static String searchResultForString(XmlElement xml, String key) {
    return xml.findAllElements(key).map((e) => e.text).first.isEmpty
        ? ""
        : xml.findAllElements(key).map((e) => e.text).first;
  }

  static double searchResultForDouble(XmlElement xml, String key) {
    return xml.findAllElements(key).map((e) => e.text).first.isEmpty
        ? 0
        : double.parse(xml.findAllElements(key).map((e) => e.text).first);
  }

  static T searchResult<T>(XmlElement xml, String key) {
    assert(null is! T,
        '제네릭 타입을 지정해 주세요. searchResult<String> | searchResult<double>');
    late T result;
    var elements = xml.findAllElements(key).map((e) => e.text);
    switch (T) {
      case double:
        result = (elements.isEmpty ? 0 : double.parse(elements.first)) as T;
        break;
      case String:
        result = (elements.isEmpty ? "" : elements.first) as T;
    }
    return result;
  }
}
