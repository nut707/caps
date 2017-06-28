class OtherEvent < ActiveRecord::Base
  audited
  belongs_to :project
  validates :price, :numericality => { :greater_than_or_equal_to => 0 }, :allow_nil => true
end
