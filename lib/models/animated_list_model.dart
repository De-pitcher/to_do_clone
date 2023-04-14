import 'package:flutter/material.dart';

typedef RemovedItemBuilder<T> = Widget Function(
    T item, BuildContext context, Animation<double> animation);

/// Keeps a Dart [List] in sync with an [AnimatedList].
///
/// The [insert] and [removeAt] methods apply to both the internal list and
/// the animated list that belongs to [listKey].
///
/// This class only exposes as much of the Dart List API as is needed by the
/// sample app. More list methods are easily added, however methods that
/// mutate the list must make the same changes to the animated list in terms
/// of [AnimatedListState.insertItem] and [AnimatedList.removeItem].
class AnimatedListModel<E> {
  AnimatedListModel({
    required this.listKey,
    required this.removedItemBuilder,
    Iterable<E>? initialItems,
  }) : _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final RemovedItemBuilder<E> removedItemBuilder;
  final List<E> _items;

  AnimatedListState? get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    if (_animatedList != null) {
      _animatedList!.insertItem(index);
    }
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      if (_animatedList == null) return removedItem;
      _animatedList!.removeItem(
        index,
        (BuildContext context, Animation<double> animation) {
          return removedItemBuilder(removedItem, context, animation);
        },
      );
    }
    return removedItem;
  }

  void filterItem(List<E> idList, List<E> initTasks) {
    // if idList is empty is removes the items from the
    // _items and returns
    if (idList.isEmpty) {
      while (_items.isNotEmpty) {
        for (var i = 0; i < _items.length; i++) {
          removeAt(i);
        }
      }
      return;
    }

    // Readd any item that might have been deleted from the previous
    // filter operation by checking if it does not exist
    for (var i = 0; i < initTasks.length; i++) {
      final index = _items.indexWhere((idL) => idL == initTasks[i]);
      if (index == -1) {
        insert(i, initTasks[i]);
      }
    }

    // The _items is assigned to tempList
    List<E> tempList = List.from(_items);

    // Loops and remove any _items item that is not idList
    for (var element in tempList) {
      final index = idList.indexWhere((idL) => idL == element);
      if (index == -1) {
        final cIndex = indexOf(element);
        removeAt(cIndex);
      }
    }
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);

  int indexWhere(bool Function(E element) test) => _items.indexWhere(test);

  bool get isEmpty => _items.isEmpty;
}
