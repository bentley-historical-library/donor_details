module DonorDetails

  def self.included(base)
    base.one_to_many :donor_detail

    base.def_nested_record(:the_property => :donor_details,
                           :contains_records_of_type => :donor_detail,
                           :corresponding_to_association => :donor_detail)
  end

end