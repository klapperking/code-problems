# Kata Overview

---

### Description:

For this kata you will be extending the Hash class to support a new method called 'flattened_keys'. The purpose of this method is to return a new hash that has any nested values flattened so that there is only the single root hash structure. The keys from the nested hash will be merged into the parent, separated by underscores.

Basic example:

```ruby
unflat = {id: 1, info: {name: 'example'}}.flattened_keys
unflat.flattened_keys # equals {id: 1, info_name: 'example'}
# notice the info_name flattened key
```

The method should handle any level of nesting. For example:

```ruby
unflat = {
  id: 1,
  info: {
    name: 'example',
    more_info: {
      count: 1
    }
  }
}

flat = unflat.flattened_keys
flat # equals {id: 1, info_name: 'example', info_more_info_count: 1}
```

Notice that so far only symbols have been used as hash keys. If at any point in the path one of the keys is a string then the resulting flattened key should be a string as well.

For example:

```ruby
unflat = {a: 1, 'b' => 2, info: {id: 1, 'name' => 'example'}}
flat = unflat.flattened_keys
flat # equals {a: 1, 'b' => 2, info_id: 1, 'info_name' => 'example'}
```
