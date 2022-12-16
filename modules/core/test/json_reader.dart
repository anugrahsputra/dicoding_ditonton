import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;

  if (dir.endsWith('test')) {
    return File('$dir/$name').readAsStringSync();
  } else if (dir.endsWith('core')) {
    return File('$dir/test/$name').readAsStringSync();
  } else if (dir.endsWith('modules')) {
    return File('$dir/core/test/$name').readAsStringSync();
  } else {
    return File('$dir/modules/core/test/$name').readAsStringSync();
  }
}
