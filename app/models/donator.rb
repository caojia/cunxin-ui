class Donator < Contributor
  #TODO: add more validations
  validates_presence_of :canonical_name
  validates_uniqueness_of :canonical_name
end
