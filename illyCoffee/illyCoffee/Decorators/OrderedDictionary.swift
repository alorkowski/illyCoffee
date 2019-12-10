import Foundation

struct OrderedDictionary<Key, Value> where Key: Hashable & Comparable {
    typealias HashTable = Dictionary<Key, Value>

    private var _orderedKeys: [Key]
    private var _unorderedDictionary: HashTable

    init() {
        self._orderedKeys = [Key]()
        self._unorderedDictionary = HashTable()
    }

    init(from dictionary: HashTable) {
        self._orderedKeys = Array(dictionary.keys).sorted{ $0 < $1 }
        self._unorderedDictionary = dictionary
    }
}

// MARK: - OrderedKeys Computed Properties
extension OrderedDictionary {
    var orderedKeys: [Key] {
        return self._orderedKeys
    }

    var count: Int {
        return self._orderedKeys.count
    }

    var isEmpty: Bool {
        return self._orderedKeys.isEmpty
    }
}

// MARK: - UnorderedDictionary Computed Properties
extension OrderedDictionary {
    var unorderedDictionary: HashTable {
        return self._unorderedDictionary
    }

    var unorderedKeys: HashTable.Keys {
        return self._unorderedDictionary.keys
    }

    var values: HashTable.Values {
        return self._unorderedDictionary.values
    }
}

// MARK: - Methods
extension OrderedDictionary {
    mutating func set(_ value: Value, forKey key: Key) {
        defer { self._unorderedDictionary[key] = value }
        guard !self._orderedKeys.contains(key) else { return }
        self._orderedKeys.append(key)
        self._orderedKeys.sort()
    }

    mutating func remove(_ key: Key) {
        guard self._orderedKeys.contains(key),
            let index = self._orderedKeys.firstIndex(of: key)
            else { return }
        self._orderedKeys.remove(at: index)
        self._unorderedDictionary[key] = nil
    }
}

// MARK: - Subscript Method
extension OrderedDictionary {
    subscript(key: Key) -> Value? {
        get { self._unorderedDictionary[key] }
        set {
            guard let newValue = newValue else {
                self.remove(key)
                return
            }
            self.set(newValue, forKey: key)
        }
    }
}
