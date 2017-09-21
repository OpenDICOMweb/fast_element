// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// Author: Jim Philbin <jfphilbin@gmail.edu> -
// See the AUTHORS file for other contributors.

import 'package:system/server.dart';
import 'package:test/test.dart';

import 'package:fast_element/fast_element.dart';

main() {
	Server.initialize(name: 'lookup_table_test.dart', level: Level.debug);

  group('Lookup Table Tests', () {
    test('Integer Lookup Test', () {
      log.debug(Attribute.kE0.info);
      bool valid = Attribute.kE0.isValidLength([]);
      log.debug('isValidLength kE0: $valid');
      expect(valid, false);
      valid = Attribute.kE0.isValidLength([1]);
      log.debug('isValidLength kE0: $valid');
      expect(valid, true);
      valid = Attribute.kE0.isValidLength([1, 2]);
      log.debug('isValidLength kE0: $valid');
      expect(valid, false);

      log.debug(Attribute.kE1.info);
      valid = Attribute.kE0.isValidLength([]);
      log.debug('isValidLength kE0: $valid');
      expect(valid, true);
      valid = Attribute.kE0.isValidLength([1]);
      log.debug('isValidLength kE0: $valid');
      expect(valid, true);
      valid = Attribute.kE0.isValidLength([1, 2, 3]);
      log.debug('isValidLength kE0: $valid');
      expect(valid, true);
      valid = Attribute.kE0.isValidLength([1, 2]);
      log.debug('isValidLength kE0: $valid');
      expect(valid, true);


      log.debug(Attribute.kE2.info);
      log.debug(Attribute.kE3.info);


      for (int i = 0; i < Attribute.kAttributes.length; i++) {
	      Attribute a = Attribute.kAttributes[i];
	      log.debug('a: $a');
	      expect(a.index == i, true);
	      expect(a.vrIndex == i + 1, true);
      }
/*      LookupByTagTable ilt = new LookupByTagTable(t1, t1, t2, t2);
      print('ilt: $ilt');

      for (int i = 0; i < t1.length; i++) {
        int v1 = t1[i];
        print('v1: $v1');
        expect(v1 == ilt[i], true);
      }

      for (int i = 0; i < t2.length; i++) {
	      int v2 = t2[i];
	      int result = ilt[v2];
	      print('v2: $v2, result: $result');
	      expect(v2 == result, true);
      }*/
    });
  });
}
