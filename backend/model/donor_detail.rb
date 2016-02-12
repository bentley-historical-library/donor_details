class DonorDetail < Sequel::Model(:donor_detail)
	include ASModel
	corresponds_to JSONModel(:donor_detail)

	include AutoGenerator

	set_model_scope :global

	auto_generate 	:property => :number,
			:generator => proc { |json|
			donors = DonorDetail.select(:number).map(&:number)
    			donors_int = donors.map {|i| i.to_i}
    			new_donor_int = donors_int.max + 1
    			new_donor_int.to_s
			},
			:only_if => proc { |json| json["number_auto_generate"]}

end
