class Task
  # PROPERTIES = [:title, :done]
  # PROPERTIES.each {|prop| attr_accessor prop}

  # def initialize(hash = {})
  #   hash.each {|key, value|
  #     if PROPERTIES.member? key.to_sym
  #       self.send((key.to_s + "=").to_s, value)
  #     end
  #   }
  # end

  include MotionModel::Model
  include MotionModel::ArrayModelAdapter

  columns :title => :string,
          :done  => :boolean
end