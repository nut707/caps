class ExternalAuthor < ActiveRecord::Base
  audited
  belongs_to :publication

  def fio
    [last_name, first_name, middle_name].join(' ').strip
  end

  def fio=(name)
    split = name.split(' ', 3)
    self.last_name = split.first
    self.first_name = split.second
    self.middle_name = split.last
  end

end
