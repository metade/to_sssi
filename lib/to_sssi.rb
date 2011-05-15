# coding: utf-8

class NilClass
  def to_sssi
  end
end

class String
  def to_sssi
    escaped = self.gsub('$', '\$')
    escaped.gsub!('"', '\"')
    escaped.gsub!(/[‘’]/, "'")
    escaped
  end
end

class TrueClass
  def to_sssi
    1
  end
end

class FalseClass
  def to_sssi
    0
  end
end

class Hash
  def to_sssi(prefix='')
    self.sort.to_a.map do |key, val|
      value = (val.kind_of?(String) or 
               val.kind_of?(TrueClass) || 
               val.kind_of?(FalseClass)) ? val.to_sssi : val
      %[<!--#set var="#{prefix}#{key}" value="#{value}" -->]
    end.join("\n")
  end
end

class Array
  def to_sssi(name='array')
    result = []
    self.each_with_index do |val,i|
      if val.kind_of? Hash
        result << val.to_sssi("#{name}_#{i}_")
      else
        value = (val.kind_of?(String) or 
                 val.kind_of?(TrueClass) || 
                 val.kind_of?(FalseClass)) ? val.to_sssi : val
        result << %[<!--#set var="#{name}_#{i}" value="#{value}" -->]
      end
    end
    result.join("\n")
  end
end
