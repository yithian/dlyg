# a validator to ensure that a character's name is unique in its game

class UniqueInGameValidator < ActiveModel::EachValidator
  # validates all records passed to it
  def validate_each(record, attribute, value)
    return if value.nil? or value.empty?

    record.game.characters.each do |c|
      record.errors[attribute] << "Another character already has this name." if c.name == value and not c.id == record.id
    end
  end
end
