class DonorDetail < Sequel::Model(:donor_detail)
    include ASModel
    corresponds_to JSONModel(:donor_detail)

    include AutoGenerator

    set_model_scope :global

    auto_generate(:property => :donor_number,
            :generator => proc { |json|
            donors = DonorDetail.select(:donor_number).map(&:donor_number)
            donors_int = donors.map {|i| i.to_i}
            new_donor_int = donors_int.max + 1
            new_donor_int.to_s
            },
            :only_if => proc { |json| json["donor_number_auto_generate"]},
            :only_if_nil => true)

    auto_generate(:property => :beal_contact_id,
            :generator => proc { |json|
            contacts = DonorDetail.select(:beal_contact_id).map(&:beal_contact_id)
            contacts_int = contacts.map {|i| i.to_i}
            new_contact_int = contacts_int.max + 1
            new_contact_int.to_s
            },
            :only_on_create => true)

end