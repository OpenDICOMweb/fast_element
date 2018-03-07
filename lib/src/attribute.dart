// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// Author: Jim Philbin <jfphilbin@gmail.edu> -
// See the AUTHORS file for other contributors.

import 'package:core/core.dart';

import 'package:fast_element/src/keywords.dart';
import 'package:fast_element/src/names.dart';
import 'package:fast_element/src/tags.dart';

const int kVROffset = 0;
const int kVMMinOffset = 1;
const int kVMMaxOffset = 2;
const int kVMWidthOffset = 3;
const int kModeOffset = 4;
const int kIsRetiredOffset = 5;
const int kIsPrivateOffset = 5;
const int kIndexOffset = 6;
const int kGroupOffset = 6;
const int kElementOffset = 7;

const List<int> eTypeCodes = const [];
const List<int> eTypeCodeIndex = const [];

const List<String> eTypeNames = const [];
const List<int> eTypeNameIndex = const [];

const List<int> eTypes = const [];

String toDcm(int group, int elt) =>
    '(${group.toRadixString(16).padLeft(4, '0')},${elt.toRadixString(16).padLeft(4, '0')
		})';

const kVMLenthN = 255;

class Attribute<V> {
  final Bytes bd;

  const Attribute(this.bd);

  int get index => bd.getUint16(kIndexOffset);
  int get tag => getAttributeTag(index);
  int get group => bd.getUint8(kGroupOffset);
  int get elt => bd.getUint8(kElementOffset);
  String get dcm => toDcm(group, elt);

  String get keyword => getAttributeKeyword(index);
  String get name => getAttributeName(index);

  int get vrIndex => bd.getUint8(kVROffset);
  VR get vr => vrByIndex[vrIndex];

  int get vmMin => bd.getUint8(kVMMinOffset) * vmWidth;
  int get vmMax => bd.getUint8(kVMMaxOffset) * vmWidth;

  int get vmWidth => bd.getUint8(kVMWidthOffset);

  int get mode => bd.getUint8(kModeOffset);
  bool get isRetired => bd.getUint8(kIsRetiredOffset) == 1;
  bool get isNotRetired => !isRetired;
  bool get isPrivate => bd.getUint8(kIsPrivateOffset) == 1;
  bool get isPublic => !isPrivate;

  /// Returns true if
  /// Rules for determining valid length
  /// 1. If values length == 0 and type > 1 or 1c
  ///     - This is encoded as vmMin == 0
  /// 2. If VM == 1-N then any values length other than zero is always valid.
  ///     - These will be encoded vmMin = 1 vmMax == Attribute.vmMax = kMax32BitInt
  /// 3. If values length == 1:
  ///    - The following VRs always have a VM of one:
  ///    ```LT, OB, OD, OF, OL, OW, SQ, ST, UN, UR, and UT```
  ///    These are always encoded with a VM Min of 1 and VM Max of 1.
  ///    -	All elements with a VM == 1 will have a special encoding of vmMax == 255;
  /// 4. If vmWidth == 1 and values length > 1:
  ///    -	If (length >= vmMin && length <= vmMax) return true
  /// 5.	Otherwise if width > 1 then:
  ///    - vmMin is encoded as (vmMin * vmWidth) and vmMax is encoded as (vmMax *
  ///    vmWidth)
  bool isValidLength(List<V> values, [Issues issues]) {
    assert(values != null);
    int length = values.length;
    if ((length == 0 && mode > 1) ||
        (length >= vmMin && length <= vmMax && (length % vmWidth == 0))) return true;
    return invalidValuesLengthError(this, values);
  }

  bool isNotValidLength(List<V> values) => !isValidLength(values);

  bool isValidValues(List<V> values) {
    if (isNotValidLength(values)) return false;
    for (V value in values) if (vr.isValidValue(value)) return false;
    return true;
  }

  String get info => '$this min($vmMin) max($vmMax) width($vmWidth) Retired($isRetired)'
      ' Public($isPublic) Type($mode)';

  @override
  String toString() => '$runtimeType$dcm "$keyword" $vr "$name" ';

  static final Attribute kE0 = new Attribute(e0bd);
  static final Attribute kE1 = new Attribute(e1bd);
  static final Attribute kE2 = new Attribute(e2bd);
  static final Attribute kE3 = new Attribute(e3bd);

  static final List<Attribute> kAttributes = <Attribute>[kE0, kE1, kE2, kE3];
}

class InvalidNullValuesError extends Error {
  String msg;
  InvalidNullValuesError(this.msg);

  String toString() => msg;
}

Null invalidNullValuesError<V>(EType type) {
  var msg = 'Invalid Null Values for $type';
  log.error(msg);
  if (throwOnError) throw new InvalidNullValuesError(msg);
  return null;
}

class InvalidValuesLengthError<V> extends Error {
	Attribute a;
	List<V> values;
	InvalidValuesLengthError(this.a, this.values);

	String toString() => _msg(a, values);

	static String _msg(Attribute a, List values) =>
	'Invalid Values Length Error: value($values) for $a';
}

invalidValuesLengthError<V>(Attribute a, List<V> values) {
  var msg = InvalidValuesLengthError._msg(a, values);
	log.error(msg);
	if (throwOnError) throw new InvalidNullValuesError(msg);
	return null;
}

const List<List<int>> eTypeList = const <List<int>>[
  //          vr mn mx  wd  md r  index
  const <int>[1, 0, 1, 1, 0, 0, 0, 0], // VM.k1
  const <int>[2, 1, -1, 1, 2, 1, 0, 1], // VM.k1_n
  const <int>[3, 1, 2, 1, 4, 1, 0, 2], // VM.k1_2
  const <int>[4, 1, -1, 3, 0, 1, 0, 3] // VM.k3n
];

final Bytes e0bd = new Bytes.fromList(eTypeList[0]);
final Bytes e1bd = new Bytes.fromList(eTypeList[1]);
final Bytes e2bd = new Bytes.fromList(eTypeList[2]);
final Bytes e3bd = new Bytes.fromList(eTypeList[3]);

//TODO: replace with real issues
class Issues {
	List<String> issues = <String>[];

	Issues();
	void operator+(String s) => issues.add(s);
}