module RegexpM17N
  def self.non_empty?(str)
    cool_encoding = undummified_encoding(str.encoding)

    pattern = "^.+$".encode(cool_encoding)
    str = str.encode(cool_encoding)

    str =~ Regexp.new(pattern)
  end

  def self.undummified_encoding(encoding)
    return encoding unless encoding.dummy?
    case encoding.name
    when 'UTF-16'
      'UTF-16BE'
    when 'UTF-32'
      'UTF-32BE'
    else
      'UTF-8'
    end
  end
end
