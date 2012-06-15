# a validator to ensure that discipline + madness = 3

class BalancesDisciplineValidator < ActiveModel::EachValidator
  # validates all records passed to it
  def validate_each(record, attribute, value)
    record.errors[attribute] << "Madness and Discipline must total 3" if (record.discipline + value) != 3
  end
end
