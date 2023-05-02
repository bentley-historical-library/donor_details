class DonorDetail < Sequel::Model(:donor_detail)
    include ASModel
    corresponds_to JSONModel(:donor_detail)

    include AutoGenerator

    set_model_scope :global

    auto_generate(:property => :donor_number,
            :generator => proc { |json|
            donors = ASUtils.wrap(DonorDetail.select(:donor_number).all).map{|row| row[:donor_number]}
            donors_int = donors.empty? ? [0] : donors.map {|i| i.to_i}
            new_donor_int = donors_int.max + 1
            new_donor_int.to_s
            },
            :only_if => proc { |json| 
                if json["donor_number_auto_generate"]
                  if json.has_key?("donor_number") and not (json["donor_number"].nil? or json["donor_number"].empty?)
                    false
                  elsif json.has_key?(:donor_number) and not (json[:donor_number].nil? or json[:donor_number].empty?)
                    false
                  else
                    true
                  end
                else
                  false
                end
            },
            :only_if_nil => true)

    auto_generate(:property => :beal_contact_id,
            :generator => proc { |json|
            contacts = DonorDetail.select(:beal_contact_id).map(&:beal_contact_id)
            contacts_int = contacts.map {|i| i.to_i}
            new_contact_int = contacts_int.max + 1
            new_contact_int.to_s
            },
            :only_if => proc { |json| 
              if json.has_key?("beal_contact_id") and not (json["beal_contact_id"].empty? or json["beal_contact_id"].nil?)
                false
              elsif json.has_key?(:beal_contact_id) and not (json[:beal_contact_id].empty? or json[:beal_contact_id].nil?)
                false
              else
                true
              end
            },
            :only_on_create => true,
            :only_if_nil => true)

end