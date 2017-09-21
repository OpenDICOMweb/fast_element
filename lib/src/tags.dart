// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// Original author: Jim Philbin <jfphilbin@gmail.edu> - 
// See the AUTHORS file for other contributors.

import 'package:fast_element/src/lookup_table.dart';

/*
/// Returns an [AttributeType] corresponding to name.
const ByteData tagBD = const LookupAttributeByCodeTable(
		primaryTags, primaryTagIndex, secondaryTags, secondaryTagIndex);
*/

const List<int> primaryTags = const [
	0x00000000,
	0x00000001,
	0x00000002,
	0x00000003,
];
const List<int> primaryTagIndex = const [0, 1, 2, 3];

const List<int> secondaryTags = const [];
const List<int> secondaryTagIndex = const [];

int getAttributeTag(int index) => primaryTags[index];