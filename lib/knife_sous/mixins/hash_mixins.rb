module KnifeSous
  module HashMixins

    module_function

    def normalize_keys(hash)
      Hash[hash.map{ |k, v| [sanitize_key(k), v] }]
    end

    def sanitize_key(key)
      key.to_s.downcase.gsub(/-/, '_').to_sym
    end
  end
end
