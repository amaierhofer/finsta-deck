# encoding: UTF-8
class Type < ActiveRecord::Base
  attr_accessible :name, :text, :unit

  scope :valid, where(id: Type.pluck(:id))

  def formatted_unit
    unit == 'percent' ? "%" : "CHF"
  end

  def to_s
    [id, name, formatted_unit].join(', ')
  end

  def pretty_name
    self.class.pretty_names[id]
  end

  def self.pretty_names
    Type.all.each_with_object({}) do |type, memo|
      memo[type.id] = type.name =~ /Nation/ ? 'Nationen' : type.name
    end
  end


end
