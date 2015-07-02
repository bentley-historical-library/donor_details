class DonorDetail < Sequel::Model(:donor_detail)
	include ASModel
	corresponds_to JSONModel(:donor_detail)

	include AutoGenerator
	
	set_model_scope :global

	auto_generate 	:property => :number,
			:generator => proc { |json|
			donors = DonorDetail.select(:number).map(&:number)    
    			donors_int = donors.map {|i| i.to_i}
                    	# note: this does not look for the name "max"
    			max_donor = donors_int.max
    			new_donor_int = max_donor + 1
    			new_donor = new_donor_int.to_s
    			new_donor
			},
			:only_if => proc { |json| json["number_auto_generate"]}
    
  def validate
    super
    validates_unique(:number, :message => "Donor number must be unique")
  end
    

end
