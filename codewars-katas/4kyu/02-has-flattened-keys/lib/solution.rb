# frozen_string_literal: true

# Extending the hash class with a method
class Hash
  def flattened_keys
    keys.each do |key|
      next unless self[key].is_a?(Hash)

      # create a new key with the combination
      stitches = self[key].keys
      stitches.each do |suffix|
        if suffix.is_a?(String) || key.is_a?(String)
          self["#{key}_#{suffix}"] = self[key][suffix]
        else
          self["#{key}_#{suffix}".to_sym] = self[key][suffix]
        end
      end

      delete(key)
      flattened_keys
    end
    self
  end
end
