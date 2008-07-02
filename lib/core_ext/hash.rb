# Extensions to the core Hash class.
class Hash
  # Turn all string keys into symbols.  Returns the modified hash.
  def symbolize_keys
    inject({}) do |options, (key, value)|
      options[key.to_sym || key] = value
      options
    end
  end

  # Destructive version of symbolize_keys.
  def symbolize_keys!
    self.replace(self.symbolize_keys)
  end
end
