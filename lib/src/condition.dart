// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// Author: Jim Philbin <jfphilbin@gmail.edu> - 
// See the AUTHORS file for other contributors.

import 'package:core/dataset.dart';

typedef bool Predicate(Dataset ds, e);
typedef bool Condition<K>(Dataset ds, K key, [Predicate p]);

class EType {
	final int index;
	final Condition condition;

	const EType(this.index, this.condition);

	static bool requiredWithValues<K>(Dataset ds, K key, [Predicate p]) =>
      ds.isPresentWithValues(key);
	static bool requiredWithValuesIf<K>(Dataset ds, K key, [Predicate p]) =>
			ds.isPresentWithValuesif(key, p);

	static bool required<K>(Dataset ds, K key, [Predicate p]) => ds.isPresent(key);
	static bool requiredIf<K>(Dataset ds, K key, [Predicate p]) => ds.isPresentIf(key, p);
	static bool optional<K>(Dataset ds, K key, [Predicate p]) => true;


static const k1 = const EType(0, requiredWithValues);
static const k1c = const EType(1, requiredWithValuesIf);
static const k2 = const EType(2, required);
static const k2c = const EType(3, requiredWithValues);
static const k3 = const EType(4, optional);
}